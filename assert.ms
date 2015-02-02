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
	local AssertUtil
	struct AssertUtil
	(
		/*
			Helper functions to assist the asserts
		 */
		
		
		private
		function isSciptedStructDefinitionHandlerException exceptionStr = 
		(
			/*
				Tests if a string contains the signature of a exception raised during construction.
				
				@param exceptionStr: the exception		 
				@type exceptionStr: String
				
				@return: True if exceptionStr contains the pattern describing an exception during construction
				@rtype: bool
			 */
			
			return matchPattern exceptionStr pattern:#'*MAXScript Scripted Struct Definition Handler Exception:*'
		),
		
		
		public
		function getListenerContent = 
		(
			/*
				Returns the content of the listener
				
				@return: the complete content of the listener
				@rtype: String
			 */
			
			setListenerSel #(0, -1)
			return getListenerSelText()
		),
		
		
		private
		function initAssertRaiseHelper fnPointer args keywords =
		(
			/*
				Creates a dummy struct definition, which holds all information to run a pointer to a function and its parameters and keywords
				
				Idea inspired by Ofer Zelichover.
			 */
			
			local structStream = stringStream ""
			
			format "(\n" to:structStream
			format "local AssertRaiseHelper\n" to:structStream
			format "struct AssertRaiseHelper (\n" to:structStream
			format "\tpublic fnPointer,\n" to:structStream
			format "\tpublic args = #(),\n" to:structStream
			format "\tpublic keywords = #(),\n" to:structStream
			format "\tpublic function execute = (" to:structStream
			format "\t\tfnPointer" to:structStream
			
			if args.count == 0 and keywords.count == 0 then
				format "()" to:structStream
			else (
				for i=1 to args.count do
					format " args[%]" i to:structStream
				
				for i=1 to keywords.count do
					format " %:keywords[%].v2" keywords[i].v1 i to:structStream
			)
			
			format "\n" to:structStream
			format "\t)\n" to:structStream
			format ")\n)\n" to:structStream
			
			seek structStream 0
			
			local AssertRaiseHelperDef = execute structStream
			
			return AssertRaiseHelperDef fnPointer args keywords
		),
		
		
		public
		function raiseOnExceptionInAndOutOfConstructor fnPointer args keywords =
		(
			/*
				Exceptions raised in a struct constructor create a popup and a listener message,
				but nothing which fires the catch statement inside a try statment.
				The only notification we can use is a print to the listener.
				If the signature of a constructor exception is inside the listener, we throw manually.
				
				@raises Exception: 	any exception caused by executing the assertRaiseHelper, 
									including MAXScript Scripted Struct Definition Handler Exception
			 */
			
			local assertRaiseHelper = initAssertRaiseHelper fnPointer args keywords
			
			clearListener()
			
			try (
				assertRaiseHelper.execute()
			)
			catch (
				throw()
			)
			
			local listenerContent = getListenerContent()
			
			if isSciptedStructDefinitionHandlerException listenerContent then
				throw listenerContent
		),
		
		
		public
		function locateAssert exceptionStr stacklevel:1 =
		(
			/*
				Searches through a stack report and returns the file and line number,
				where a snapshot of the stack was done.
				
				@param exceptionStr: an exception string with a possible stack report
				@type exceptionStr: String
				
				@keyword stacklevel: return the file and line number of a specific stacklevel
				@keyword stacklevel: Integer
				
				@return: returns file and line number, empty String if none found
				@rtype: String
			 */
			
			local ssException = StringStream exceptionStr
			seek ssException 0
			
			local searchStackStr = "[stack level: "+stacklevel as String+"]"			
			local fileLineInfo = ""
			
			local result = skipToString ssException searchStackStr
			
			if result != undefined then (
				skipToNextLine ssException
				fileLineInfo = readLine ssException
			)
			
			return fileLineInfo
		),
		
		
		public
		function formatResultDescription assertFnName message testVal compareOperator expectedVal fileLineInfo =
		(
			/*
				Formats the resultDescription
				
				@param assertFnName: The name of the assert function called, e.g. "assert2.equals"
				@param message: An additional message to be added to the result
				@param testVal: the value being tested
				@param compareOperator: something to be put between the test and expected value, e.g. "isn't"
				@param expectedVal: the expected value
				@param fileLineInfo: 
				
				@return: the formated assert result
				@rtype: StringStream
			 */
			
			local resultDescription = StringStream ""
			
			format "\nMaxscript % Failed:\t%\n" assertFnName message to:resultDescription
			
			-- Using print to retain doubleQuotes if testVal is of type String
			print testVal to:resultDescription 
			
			-- Previous print command adds newline, which gets removed here
			seek resultDescription ((filePos resultDescription)-1)
			
			format " % " compareOperator to:resultDescription
			
			-- Using print to retain doubleQuotes if testVal is of type String
			print expectedVal to:resultDescription
			
			format "\n%" fileLineInfo to:resultDescription
			
			return resultDescription
		)		
	)
	
	
	local MaxtestAssert
	struct MaxtestAssert
	(
		/*
			Assert class for custom asserts used inside the maxtest framework.
			This struct merly groups the functionality to not clutter the global scope with different asserts.
			
			Be aware that the assert functions collaborate with clearing the listener.
			Don't keep important information in your listener when using these asserts.
			
			@info: equals and notEquals doesn not compare item of two arrays, it only compares the memory address
		 */
		
		private _util = AssertUtil(),
		
		
		public
		function assertTrue expr message:"" =
		(
			/*
				Verifies that the expression is True.
				
				@param expr: the expression to test if true
				@type expr: bool
				
				@keyword message: custom message displayed when assert fails
				@type args: String
			 */
			
			clearListener()
			
			local assertState = assert expr showstack:true
			
			-- Assert failed, get stack
			if not assertState then (
				local exceptionStr = _util.getListenerContent()
				local fileLineInfo = _util.locateAssert exceptionStr
				local resultDescription = _util.formatResultDescription "assert2.assertTrue" message expr "isn't" True fileLineInfo
				
				throw resultDescription
			)
		),
		
		
		public
		function assertFalse expr message:"" =
		(
			/*
				Verifies that the expression is False.
				
				@param expr: the expression to test if false
				@type expr: bool
				
				@keyword message: custom message displayed when assert fails
				@type args: String
			 */
			
			clearListener()
			
			local assertState = assert (not expr) showstack:true
			
			-- Assert failed, get stack
			if not assertState then (
				local exceptionStr = _util.getListenerContent()
				local fileLineInfo = _util.locateAssert exceptionStr
				local resultDescription = _util.formatResultDescription "assert2.assertFalse" message expr "is" False fileLineInfo
				
				throw resultDescription
			)
		),
		
		
		public
		function equals testVal expectedVal message:"" =
		(
			/*
				Compares two values for equality and throws an exception if not equal.
				If not equal the stack gets printed to the listener and copied and parsed
				to locate the file and line, where the assert failed.
				
				@param testVal: the value to be compared with the expected value
				@type testVal: Value
				
				@param expectedVal: the value which test value has to equal
				@type expectedVal: Value
				
				@keyword message: custom message displayed when assert fails
				@type args: String
			 */
			
			clearListener()
			
			local assertState = assert (testVal == expectedVal) showstack:true
			
			-- Assert failed, get stack
			if not assertState then (
				local exceptionStr = _util.getListenerContent()
				local fileLineInfo = _util.locateAssert exceptionStr
				local resultDescription = _util.formatResultDescription "assert2.equals" message testVal "!=" expectedVal fileLineInfo
				
				throw resultDescription
			)
		),
		
		
		public
		function notEquals testVal expectedVal message:"" =
		(
			/*
				Asserts that testVal equals expectedVal
				
				@param testVal: the value not to match the expected value
				@type testVal: Value
				
				@param expectedVal: the value to be expected not to equal test value
				@type expectedVal: Value
				
				@keyword message: custom message displayed when assert fails
				@type args: String
			 */
			
			clearListener()
			
			local assertState = assert (testVal != expectedVal) showstack:true
			
			-- Assert failed, get stack
			if not assertState then (
				local exceptionStr = _util.getListenerContent()
				local fileLineInfo = _util.locateAssert exceptionStr
				local resultDescription = _util.formatResultDescription "assert2.notEquals" message testVal "==" expectedVal fileLineInfo
				
				throw resultDescription
			)
		),
		
		
		public
		function raises errorMsgPattern fnPointer args:#() keywords:#() message:"" =
		(
			/*
				Checks if function run with certain parameters raises an exception with a certain string.
				
				@param errorMsgPattern: the pattern of the error message, so the assert succeeds
				@type errorMsgPattern: String
				
				@param fnPointer: the function to be tested
				@type fnPointer: MAXScriptFunction
				
				@param args: the arguments for running the function
				@type args: #(Value)
				
				@keyword keywords: the keywords for running the function
				@type keywords: #(DataPair(String, Value))
				
				@keyword message: custom message displayed when assert fails
				@type args: String
			 */
			
			local expectedExceptionRaised = false
			local exceptionStr = ""
			
			clearListener()
			
			try (
				_util.raiseOnExceptionInAndOutOfConstructor fnPointer args keywords
			)
			catch (
				exceptionStr = getCurrentException()
				if matchPattern exceptionStr pattern:errorMsgPattern then
					expectedExceptionRaised = true
			)
			
			if not expectedExceptionRaised then (
				local exceptionStream = StringStream ""
				stack showLocals:True firstFrameOnly:false to:exceptionStream
				
				local fileLineInfo = _util.locateAssert (exceptionStream as String)
				local resultDescription = _util.formatResultDescription "assert2.raises" message errorMsgPattern "pattern doesn't match" exceptionStr fileLineInfo   
				
				throw resultDescription
			)
		),
		
		
		public
		function notRaises fnPointer args:#() keywords:#() message:"" =
		(
			/*
				Checks if function run with certain parameters doesn't raise any exception.
				@info: if no exception should be raised, make errorMsgPattern == ""
				
				@param fnPointer: the function to be tested
				@type fnPointer: MAXScriptFunction
				
				@keyword args: the arguments for running the function
				@type args: #(Value)
				
				@keyword keywords: the keywords for running the function
				@type keywords: #(DataPair(String, Value))
				
				@keyword message: custom message displayed when assert fails
				@type args: String
			 */
			
			local exceptionRaised = false
			
			try (
				_util.raiseOnExceptionInAndOutOfConstructor fnPointer args keywords
			)
			catch (
				local exceptionStr = getCurrentException()
				exceptionRaised = true
			)
			
			
			if exceptionRaised then (
				local exceptionStream = StringStream ""
				stack showLocals:True firstFrameOnly:false to:exceptionStream
				
				local fileLineInfo = _util.locateAssert (exceptionStream as String)
				local resultDescription = _util.formatResultDescription "assert2.notRaises" message "Exception was raised" ">>" exceptionStr fileLineInfo
				
				throw resultDescription
			)
		)
	)
	
	
	global assert2 = MaxtestAssert()
)