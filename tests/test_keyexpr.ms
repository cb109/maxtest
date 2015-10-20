struct TestKeyExpressionMatcher (
    matcher,

    tests,
    testcases,

    fn setup = (
        this.tests = #(#("test_things", "TestFoo", "test_foo"),
                       #("test_things", "TestFoo", "test_bar"),
                       #("test_things", "TestBar", "test_foo"),
                       #("test_things", "TestFoo", "test_baz"),
                       #("test_things", "TestBaz", "test_foo"),
                       #("test_clangdang", "TestBaz", "test_bur"))
        this.testcases = #()

        for test in tests do
        (
            local testsuite = MAXTestSuite test[2] filePath:test[1]
            local testcase = MAXTestCase test[3] testSuite:testsuite
            append this.testcases testcase
        )

        this.matcher = KeyExpressionMatcher()
    ),

    fn test_empty_expression = (
        local key_expr = ""
        local matches = this.matcher.matchTests this.testcases key_expr
        assert2.equals matches.count 6
    ),

    fn test_invalid_expression = (
        local key_expr = "!&%§)§/?$=)§(?="
        local matches = this.matcher.matchTests this.testcases key_expr
        assert2.equals matches.count 0
    ),

    fn test_match_all = (
        local key_expr = "not non_existing_token"
        local matches = this.matcher.matchTests this.testcases key_expr
        assert2.equals matches.count 6
    ),

    fn test_match_none = (
        local key_expr = "non_existing_token"
        local matches = this.matcher.matchTests this.testcases key_expr
        assert2.equals matches.count 0
    ),

    fn test_match_not_baz = (
        local key_expr = "(not baz)"
        local matches = this.matcher.matchTests this.testcases key_expr
        assert2.equals matches.count 3
    ),

    fn test_match_or_and = (
        local key_expr = "(foo or bar) and (not baz)"
        local matches = this.matcher.matchTests this.testcases key_expr
        assert2.equals matches.count 3
    ),

    fn test_match_complex = (
        local key_expr = "(clang and dang or (not foo) or zip)not(lol and kek)and bur "
        local matches = this.matcher.matchTests this.testcases key_expr
        assert2.equals matches.count 1
    )
)