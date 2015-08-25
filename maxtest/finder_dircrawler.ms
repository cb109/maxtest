/*
 *	Copyright (c) 2012, Pixelbaker
 *	All rights reserved.
 *
 *	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *		Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 *		Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

fileIn "model.ms"


/*
 *	DirCrawler is a finder which finds unittests recursively in a folder structure and
 *	returns the found tests as objects the runner can use to execute the tests.
 *	@info: finders need to support getTests() which need to return MaxTestFile objects.
 */
struct DirCrawler
(
	-- Members
	public filepath = "",
	public filePattern = "*test_*.ms",
	public structPattern = "Test",
	public fnPattern = "test_",


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

		for fileOn in files do
		(
			local fstream = openFile fileOn mode:"r"
			local structNames = getTestSuiteNamesFromFileStream fstream
			close fstream

			if structNames.count > 0 then
			(
				fileIn fileOn

				local suites = #()
				for structNameOn in structNames do
				(
					-- Execute struct to get aware of methods
					local ssProperty = StringStream ""
					showProperties (execute structNameOn) to:ssProperty

					local testFnNames = getTestFnNamesFromPropertyStream ssProperty

					Append suites (MAXTestSuite structName:structNameOn testFnNames:testFnNames)
				)

				Append tests (MAXTestFile fileOn suites)
			)
		)

		tests
	),


	public
	function getTests =
	(
		/*
		 *	<Array of MAXTestFile>getTests
		 *	Returns tests found in and under the filepath.
		 */

		local files = this.findFiles()
		this.gatherTests files
	)
)