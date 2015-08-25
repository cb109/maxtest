struct TestPassedExamples
(
	function test_equals =
	(
		assert2.equals 1 1
	),


	function test_notEquals =
	(
		assert2.notEquals 1 0
	),


	function test_assertTrue =
	(
		assert2.assertTrue (1 == 1)
	),


	function test_assertFalse =
	(
		assert2.assertFalse (1 == 0)
	),


	function test_raises =
	(
		function dummyFn =
		(
			throw "error"
		)

		local exceptionPattern = "*error*"
		assert2.raises exceptionPattern dummyFn
	),


	function test_notRaises =
	(
		function dummyFn = ()

		assert2.notRaises dummyFn
	)
)


struct TestFailureExamples
(
	function test_equals =
	(
		assert2.equals 1 0
	),


	function test_notEquals =
	(
		assert2.notEquals 1 1
	),


	function test_assertTrue =
	(
		assert2.assertTrue (1 == 0)
	),


	function test_assertFalse =
	(
		assert2.assertFalse (1 == 1)
	),


	function test_raises =
	(
		function dummyFn =
		(
			throw "error"
		)

		local exceptionPattern = "*failure*"
		assert2.raises exceptionPattern dummyFn
	),


	function test_notRaises =
	(
		function dummyFn =
		(
			throw "error"
		)

		assert2.notRaises dummyFn
	)
)


struct TestErrorExamples
(
	function test_error =
	(
		throw "error"
	)
)