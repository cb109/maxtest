/*
 *	PresenterListener is a presenter which prints results returned by the MAXTest Runner to the listener.
 */
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