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
 *	Class for storing all test suites found inside a test file.
 *	Test runner uses these information for running the tests.
 *	@info: all finders must return MAXTestFile objects
 */
struct MAXTestFile
(
	public filename = undefined,

	-- <Array of MAXTestSuite>
	public testSuites = #()
)


/*
 *	Class for storing test suite information.
 *	Necessary for the runner to execute the test functions inside a struct.
 */
struct MAXTestSuite
(
	public structName = "",

	-- <Array of String>
	public testFnNames = #()
)


/*
 *	Class for storing result information of a unit test when run by the Runner.
 */
struct MAXTestResult
(
	public fileName = "",
	public structName = "",
	public testName = "",
	public state = undefined, -- -1 == error, 0 == passed, 1 == failed
	public resultStream = StringStream ""
)