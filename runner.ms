/*
 *	Copyright (c) 2012, Pixelbaker
 *	All rights reserved.
 *
 *	Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 *		Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 *		Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 *	THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


/*
 *	Class for storing result information of a unit test when run by the Runner.
 */
struct MAXTestResult 
(
	public structName = "",
	public testName = "",
	public state = undefined, -- -1 == error, 0 == passed, 1 == failed
	public resultStream = StringStream ""
)


/*
 *	Class for running tests of object type MAXTestFile.
 *	Runner needs custom asserts, like assertEqual.
 *	Runner distinguishes between a test which passes, fails or errors.
 */
struct Runner 
(
	-- Members
	public tests = #(),
	private results = #(),
	
	
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
	mapped function runTest testFnName structName suiteInstance =
	(
		/*
		 *	<Void>runTest <String>testFnName <String>structName <Struct Instance>suiteInstance
		 *	Runs a single test and stores the result object on the runner instance.
		 */
		
		local state = 0 -- ok
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
				
				state = 1 -- failure
				
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
					state = -1 -- error
				)
			)
		)
		else
		(
			print "Error while initializing testFn." to:ssResult
			state = -1 -- error
		)
		
		resultObj.resultStream = ssResult
		resultObj.state = state
		
		Append this.results resultObj
	),
	
	
	private 
	function runSuite structName testFnNames =
	(
		/*
		 *	<Void>runSuite <String>structName <Array of String>testFnNames
		 *	Runs a test suite of name structName by executing all methods inside testFnNames.
		 */
		
		local suiteObj = initSuite structName
		if undefined != suiteObj then
		(
			-- Mapped call
			runTest testFnNames structName suiteObj
		)
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
		
		for testOn in tests do
		(
			filename = testOn.filename
			
			fileIn filename
			
			for suiteOn in testOn.testSuites do
			(
				runSuite suiteOn.structName suiteOn.testFnNames
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
		
		this.results
	)
)
