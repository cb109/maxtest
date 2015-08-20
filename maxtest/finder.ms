/*
 *	Copyright (c) 2012, Pixelbaker
 *	All rights reserved.
 *
 *	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *		Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 *		Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
(

	/*
	 *	Class for storing test suite information.
	 *	Necessary for the runner to execute the test functions inside a struct.
	 */
	global MAXTestSuite
	struct MAXTestSuite
	(
		public structName = "",

		-- <Array of String>
		public testFnNames = #()
	)


	/*
	 *	Class for storing all test suites found inside a test file.
	 *	Test runner uses these information for running the tests.
	 *	@info: all finders must return MAXTestFile objects
	 */
	global MAXTestFile
	struct MAXTestFile
	(
		public filename = undefined,

		-- <Array of MAXTestSuite>
		public testSuites = #()
	)



	/*
	 *	DirCrawler is a finder which finds unittests recursively in a folder structure and
	 *	returns the found tests as objects the runner can use to execute the tests.
	 *	@info: finders need to support getTests() which need to return MaxTestFile objects.
	 */
	global DirCrawler
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
		function getTestSuiteNamesFromFileStream fstream =
		(
			/*
			 *	<Array of String>getTestSuiteNamesFromFileStream <FileStream>fstream
			 *	Collect Test Suite names from a file stream.
			 *	This function doesn't close the filestream.
			 */

			local structNames = #()

			seek fstream 0

			while skipToString fstream ("struct " + this.structPattern) != undefined do
			(
				local structName = ""
				local afterPatternPos = filePos fstream

				-- Move cursor back to begin of struct name
				seek fstream (afterPatternPos - this.structPattern.count - 1)

				do
				(
					char = readChar fstream
					-- Don't add special characters
					if not isSpace char then
					(
						structName += char
					)
				)
				while not isNameComplete char structName

				Append structNames structName
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
)
