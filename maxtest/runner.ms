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
	 *	Class for running tests of object type MAXTestFile.
	 *	Runner needs custom asserts, like assertEqual.
	 *	Runner distinguishes between a test which passes, fails or errors.
	 */
	global Runner
	struct Runner
	(
		-- Members
		public tests = #(),
		private _results = #(),


		-- Methods
		private
		function initSuite suiteName =
		(
			/*
			 *	<Instance of struct suiteName>initSuite <String>suiteName
			 *	Returns an instance of the struct with suiteName, on execption returns undefined.
			 */

			local suite = undefined

			try
			(
				suite = (execute suiteName)()
			)
			catch
			(
				print "Error while initializing suite." to:errorMsg
				suite = undefined
			)

			suite
		),


		private
		function initTestFn suiteInstance testFnName =
		(
			/*
			 *	<Pointer to function>initTestFn <Struct Instance>suiteInstance <String>testFnName <StringStream>errorMsg:
			 *	Returns a pointer to the static method of name testFnName inside the class of name suiteName.
			 *	Returns undefined on exception.
			 */

			local testFn = undefined

			try
			(
				testFn = getProperty suiteInstance testFnName
			)
			catch
			(
				testFn = undefined
			)

			testFn
		),


		private
		function isAssertMsg exceptionStr pattern:"*Maxscript Assert2* Failed*" =
		(
			/*
			 *	<BooleanClass>isAssertMsg <String>exceptionStr <String>pattern:
			 *	Returns True if exceptionStr contains the pattern, identifying it as an Assert,
			 *	otherwise returns False.
			 */

			if MatchPattern exceptionStr pattern:pattern then true else false
		),


		private
		function runTest testFnName structName suiteInstance =
		(
			/*
			 *	<Void>runTest <String>testFnName <String>structName <Struct Instance>suiteInstance
			 *	Runs a single test and stores the result object on the runner instance.
			 */

			local state = #Ok
			local ssResult = StringStream ""

			-- Init result object
			local resultObj = MAXTestResult structName:structName testName:testFnName

			-- Get Pointer to test method
			local testFn = initTestFn suiteInstance testFnName

			if undefined != testFn then
			(
				local setUp = undefined
				local tearDown = undefined

				if hasProperty suiteInstance #setUp then
					setUp =	getProperty suiteInstance #setUp

				if hasProperty suiteInstance #tearDown then
					tearDown =	getProperty suiteInstance #tearDown

				try
				(
					if undefined != setUp then setUp()

					testFn()

					if undefined != tearDown then tearDown()
				)
				catch
				(
					try
					(
						if undefined != tearDown then tearDown()
					)
					catch
					(
						throw()
					)

					local exceptionStr = getCurrentException()

					format "%\n" exceptionStr to:ssResult

					state = #Failure

					if isAssertMsg exceptionStr then
					(
						seek ssResult 0
						skipToNextLine ssResult

						local newResult = StringStream ""
						while not eof ssResult do
						(
							format "%\n" (readLine ssResult) to:newResult
						)

						ssResult = newResult
					)
					else
					(
						stack showLocals:True firstFrameOnly:True to:ssResult
						state = #Error
					)
				)
			)
			else
			(
				print "Error while initializing testFn." to:ssResult
				state = #Error
			)

			resultObj.resultStream = ssResult
			resultObj.state = state

			return resultObj
		),


		private
		function runSuite structName testFnNames =
		(
			/*
			 *	<Void>runSuite <String>structName <Array of String>testFnNames
			 *	Runs a test suite of name structName by executing all methods inside testFnNames.
			 */

			local suiteObj = initSuite structName
			local results = #()
			if undefined != suiteObj then
			(
				results = for testFnNameOn in testFnNames collect
				(
					runTest testFnNameOn structName suiteObj
				)
			)
			return results
		),


		private
		function runAllTests =
		(
			/*
			 *	<Void>runAllTests
			 *	Runs all tests associated with the runner instance.
			 *	Loads the files containing tests with fileIn
			 *	and does a garbage collection after each file has been run.
			 */

			_results = #()

			for testOn in tests do
			(
				filename = testOn.filename

				fileIn filename

				for suiteOn in testOn.testSuites do
				(
					local results = runSuite suiteOn.structName suiteOn.testFnNames
					for resultOn in results do
						resultOn.fileName = filename
					join _results results
				)
				gc light:false delayed:false
			)
		),


		public
		function getResults =
		(
			/*
			 *	<Array of MAXTestResult>getResults
			 *	Returns all the results after running all tests.
			 */

			runAllTests()
			return _results
		)
	)
)