fileIn "model.ms"
fileIn "keyexpr.ms"
fileIn "logger.ms"


/*
 *	DirCrawler is a finder which finds unittests recursively in a folder
 *  structure and returns the found tests as objects the runner can use
 *  to execute the tests. Finders need to support getTests() which need
 *  to return MaxTestFile objects.
 */
struct DirCrawler
(
	-- Members
	public filepath = "",
	public filePattern = "*test_*.ms",
	public structPattern = "Test",
	public fnPattern = "test_",
	public key = undefined,

	private _log = MAXTestLogger "maxtest.finder",

	-- Methods
	private
	function findFiles dir: =
	(
		/*
		 *	<Array of String>findFiles <String>dir:
		 *	Get all files recursively from filepath matching filePattern.
		 */

		if unsupplied == dir then
		(
			dir = this.filepath
		)

		-- Remove invalid characters

		local trimStr = " /*?"
		local escapeStr = "\\*"

		dir = TrimRight dir trimStr
		dir = TrimLeft dir trimStr

		if pathIsNetworkPath dir then
			dir = TrimRight dir "\\"

		local dirs = GetDirectories (dir+escapeStr)
		local files = GetFiles (dir+escapeStr)

		local matchFiles = for fileOn in files where MatchPattern fileOn pattern:this.filePattern collect fileOn

		-- Recursion
		for dirOn in dirs do
		(
			Join matchFiles (this.findFiles dir:dirOn)
		)

		matchFiles
	),


	private
	function isNameComplete char structName =
	(
		/*
		 *	<BooleanClass>isNameComplete <String>char <String>structName
		 *	Returns True if struct name is not empty and the character is a space, newline or tab,
		 *	else returns False.
		 */

		if structName != "" and isSpace char then true else false
	),


	private
	fn readFilestream fstream =
	(
		/*
			 * <String>readFilestream <File>fstream
			 * Read the entire content of the filestream and return as string.
			 */
		seek fstream #eof
		local maxlen = filepos fstream
		seek fstream 0
		local res = readChars fstream maxlen errorAtEOF:false
		res
	),


	private
	fn getStructNameFromGroups groups =
	(
	    /*
	     * <Array of String>getStructNameFromGroups <GroupCollection>groups:
	     * The 1st match group will contain the whole string, so we skip it.
	     * The 2nd match group containts the actual content inside the group's
	     * parentheses from the pattern above, which is the struct name we are
	     * looking for.
	     */
	    local groupEnum = groups.GetEnumerator()
	    groupEnum.moveNext()
	    groupEnum.moveNext()
	    local structname = groupEnum.current.Value
	    structname
	),


	private
	function getTestSuiteNamesFromFileStream fstream =
	(
		/*
		 *	<Array of String>getTestSuiteNamesFromFileStream <FileStream>fstream
		 *	Collect Test Suite names from a file stream.
		 *	This function doesn't close the filestream.
		 */
		local structNames = #()
		local pattern = @"struct\s+(" + this.structPattern + @"\w+)\s*\("
		local regex = dotnetObject "System.Text.RegularExpressions.Regex" pattern

		local content = this.readFilestream fstream
		local matches = regex.Matches content
		if matches.Count == 0 do
			return structNames

		local matchesEnum = matches.getEnumerator()
		while matchesEnum.moveNext() do (
		    local match = matchesEnum.current
		    local structName = this.getStructNameFromGroups match.Groups
		    append structNames structName
		)

		structNames
	),


	private
	function addFormatSpaces = (
		"  "
	),


	private
	function getTestFnNamesFromPropertyStream ssProperty =
	(
		/*
		 *	<Array of String>getTestFnNamesFromPropertyStream <StringStream>ssProperty
		 *	Return function names which match fnPattern and are public,
		 *	by parsing a stringstream containing the methods and members.
		 */

		local fnNames = #()

		seek ssProperty 0

		while skipToString ssProperty (addFormatSpaces()+fnPattern) != undefined do
		(
			local curPos = filePos ssProperty
			-- Go to line start
			seek ssProperty (curPos-this.fnPattern.count)

			local ln = readLine ssProperty

			if MatchPattern ln pattern:"*<fn>; Public*" then
			(
				ln = trimLeft ln
				local splitLn = filterString ln ":"

				if splitLn.count > 0 then
				(
					Append fnNames splitLn[1]
				)
				else
				(
					throw "MAXTest: Property list format is unexpected."
				)
			)
		)

		fnNames
	),


	private
	function gatherTests files =
	(
		/*
		 *	<Array of MAXTestFile>gatherTests <Array of String>files
		 *	Finds all the test suites and tests inside files and
		 *	returns them as MAXTestFile objects.
		 */

		local tests = #()

		for filePath in files do
		(
			local fstream = openFile filePath mode:"r"
			local structNames = getTestSuiteNamesFromFileStream fstream
			close fstream

			if structNames.count > 0 then
			(
				fileIn filePath

				local suites = #()
				for structName in structNames do
				(
					-- Execute struct to get aware of methods
					local ssProperty = StringStream ""
					showProperties (execute ("::" + structName)) to:ssProperty

					local testFnNames = getTestFnNamesFromPropertyStream ssProperty

					local testSuite = MAXTestSuite structName:structName testFnNames:testFnNames filePath:filePath
					Append suites testSuite
				)

				local testFile = MAXTestFile filePath suites
				Append tests testFile
			)
		)

		tests
	),


	private
	function selectTestsByExpression tests expr =
	(
		/*
		 *	<Array of MAXTestFile>selectTestsByExpression
		 *	Returns tests after selection only those that match the
		 *  given key expression (the returned array is rebuild from the
		 *  matches). They key must be a maxscript expression that
		 *  specifies which keywords the test's file, struct and test
		 *  name must include. It is tested against it like:
		 *
		 *  <testfile>.<testsuite>.<testcase>
		 *
		 */
		local filteredTests = #()
		local matcher = KeyExpressionMatcher()

		for testFile in tests do (
			local filteredTestFile = MAXTestFile testFile.filename #()

			for testSuite in testFile.testSuites do (
				local filteredTestSuite = MAXTestSuite testSuite.structName #() testSuite.filePath

				for testFnName in testSuite.testFnNames do (
					local testCase = MAXTestCase testFnName testSuite
					local matches = matcher.matchTests #(testCase) expr
					local testMatched = matches.count == 1
					if testMatched do (
						append filteredTestSuite.testFnNames testFnName
					)
				)

				local suiteNotEmpty = filteredTestSuite.testFnNames.count > 0
				if suiteNotEmpty do (
					append filteredTestFile.testSuites filteredTestSuite
				)
			)

			local fileNotEmpty = filteredTestFile.testSuites.count > 0
			if fileNotEmpty do (
				append filteredTests filteredTestFile
			)
		)

		filteredTests
	),


	public
	function getTests =
	(
		/*
		 *	<Array of MAXTestFile>getTests
		 *	Returns tests found in and under the filepath.
		 */
		local files = this.findFiles()
		local tests = this.gatherTests files

		local selectByKey = this.key != undefined
		if selectByKey do (
			tests = this.selectTestsByExpression tests this.key
		)

		-- Log number of tests that have been found (that match filter).
		local testCount = 0
		for testFile in tests do (
			for testSuite in testFile.testSuites do (
				for testCase in testSuite.testFnNames do (
					testCount += 1
				)
			)
		)
		this._log.info ("Found " + testCount as string + " tests.")

		tests
	)
)
