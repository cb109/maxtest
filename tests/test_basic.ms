-- These are the TestPassedExamples testcases from examples/ modified so
-- that every assertion is actually valid.


struct TestBasic
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