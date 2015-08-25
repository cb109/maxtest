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
	 *	PresenterListener is a presenter which prints results returned by the MAXTest Runner to the listener.
	 */
	global PresenterListener
	struct PresenterListener
	(
		-- Members
		public results = #(),


		-- Methods
		private
		function didAllPass =
		(
			/*
			 *	<Integer>didAllPass
			 *	Returns 0 if all tests passed, other wise 1.
			 */

			local allPass = 0
			for resultOn in this.results while allPass == 0 do
			(
				if resultOn.state != #Ok then
				(
					allPass = 1
				)
			)
			allPass
		),


		private
		function getNumOfState state =
		(
			/*
			 *	<Integer>getNumOfState <Integer>state
			 *	Returns the number of results with a certain state.
			 */

			local num = 0
			for resultOn in this.results where resultOn.state == state do num += 1
			num
		),


		private
		function createStatistics =
		(
			/*
			 *	<String>createStatistics
			 *	Create a statistic of how the tests passed.
			 */

			local statisticStr = stringstream ""

			local numError = this.getNumOfState #Error
			local numFailure = this.getNumOfState #Failure
			local numPassed = this.getNumOfState #Ok

			if numError > 0 then format "error(%) " numError to:statisticStr
			if numFailure > 0 then format "failure(%) " numFailure to:statisticStr
			if numPassed > 0 then format "passed(%)" numPassed to:statisticStr

			statisticStr as String
		),


		private
		function addCharPerStreamLine stream char:"\t" =
		(
			/*
			 *	<StringStream>addCharPerStreamLine <StringStream>stream <String>char:
			 *	Prepends to each line of a stream a char and returns the new stream.
			 */

			local newStream = StringStream ""

			seek stream 0

			while not eof stream do
			(
				local ln = readLine stream
				format "\n%%" char ln to:newStream
			)

			newStream
		),


		private
		function createTestsTotal =
		(
			/*
			 *	<String>createTestsTotal
			 *	Creates a string, which shows the total amount of tests being run.
			 */

			local totalTestStream = stringstream ""
			format "Total tests run: %" this.results.count to:totalTestStream
			totalTestStream as String
		),


		public
		function show =
		(
			/*
			 *	<Integer>show
			 *	Prints the results to the listener.
			 */
			local resultStream = stringstream ""

			clearListener()

			-- Short overview
			for resultOn in results do
			(
				format "%.% ... %\n" resultOn.structName resultOn.testName resultOn.state to:resultStream
			)

			-- Error and Failure report
			if this.didAllPass() == 1 then
			(
				format "\n\n ---- \n" to:resultStream

				for resultOn in results where resultOn.state != #Ok do
				(
					format "%.% (%)\n" resultOn.structName resultOn.testName resultOn.state to:resultStream
					format "%\n" ((this.addCharPerStreamLine resultOn.resultStream) as String) to:resultStream
					format "\n\n" to:resultStream
				)
			)

			-- Total and Statistics report
			format "\n ---- \n%\n%\n\n" (this.createTestsTotal()) (this.createStatistics()) to:resultStream

			-- Output to listener.
			format "%" (resultStream as String)

			-- Return Error Code
			didAllPass()
		)
	)
)