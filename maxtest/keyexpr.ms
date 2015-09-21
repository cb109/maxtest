/*
 *  KeyExpressionParser is a module that can select strings (in
 *  this case testnames) that match a given keyword expression.
 *
 *  Returns the matching tests as objects the runner can use to execute the tests.
 */
struct KeyExpressionParser
(
    public
    function getCombinedTestName testCase =
    (
        /*
         *  <String>getCombinedTestName <MAXTestCase>testCase
         *  Returns a combination of file, struct and function name.
         */
        local testSuite = testCase.testSuite
        local suiteName = testSuite.structName
        local fileName = getFileNameFile testSuite.filePath
        local testName = testCase.testFnName
        local combinedName = fileName + "." + suiteName + "." + testName
        combinedName
    ),


    public
    function getTokens expr =
    (
        /*
         *  <Array of String>getTokens <String>expr
         *  Gets a keyword expression and returns all valid keywords.
         */
        local nothing = ""
        local space = " "
        local replaceThese = #("(", ")")
        local ignored = #("and", "or", "not", nothing)

        -- Replace all parentheses by spaces and split by that.
        expr = toLower expr
        for replaceThis in replaceThese do (
            expr = substituteString expr replaceThis space
        )
        local rawTokens = filterString expr space
        local tokens = #()

        -- Capture tokens that are neither empty nor reserved.
        for rawToken in rawTokens do (
            local skip = false
            local token = rawToken
            for ignore in ignored do (
                if ignore == token do (
                    skip = true
                    continue
                )
            )
            if not skip do (
                appendIfUnique tokens token
            )
        )

        tokens
    ),


    public
    function substituteTokens expr tokenValuePairs = (
        /*
         *  <String>substituteTokens <String>expr <Array of Arrays>tokenValuePairs
         *  Substitutes tokens in the expressions by their boolean values.
         *
         *  The input list contains pairs of #(<token>, <bool>) which is
         *  used for substitution. Returns the complete substituted
         *  expression, ready for evaluation.
         *
         */
        for pair in tokenValuePairs do (
            local token = pair[1]
            local val = pair[2]
            expr = substituteString expr token (val as string)
        )
        expr
    ),


    public
    function asBoolean expr = (
        /*
         *  <BooleanClass>asBoolean <String>expr
         *  Returns the boolean value of the expression.
         */
        (execute expr) as BooleanClass
    ),


    public
    function matchTests testCases expr =
    (
        /*  <Array of MAXTestCase>matchTests <Array of MAXTestCase>testCases <String>expr
         *  Matches the given testCases against the expression and returns those
         *  that match it. A match is determined by by testing the tokens of the
         *  expression for string-inclusion in the combined name of the testCase
         *  and evaluating the result of the substituted expression.
         */
        for testCase in testCases do (
            local testName = this.getCombinedTestName testCase
            local testName = toLower testName

            local tokens = this.getTokens expr
            local tokenValuePairs = #()

            for token in tokens do (
                local val = (findString testName token) != undefined
                local pair = #(token, val)
                append tokenValuePairs pair
            )
            local subsExpr = this.substituteTokens expr tokenValuePairs
            local result = this.asBoolean subsExpr

            format "orig. expr: %\n" expr
            format "subs. expr: %\n" subsExpr
            format "% : %\n" testName result
            format "\n"
        )
    )
)



-- Testing:
(
--     local key_expr = "(clang and dang or (not foo) or zip)not(lol and kek)and bur "
    local key_expr = "(foo or bar) and (not baz)"
    local tests = #(#("test_things", "TestFoo", "test_foo"),
                    #("test_things", "TestFoo", "test_bar"),
                    #("test_things", "TestBar", "test_foo"),
                    #("test_things", "TestFoo", "test_baz"),
                    #("test_things", "TestBaz", "test_foo"))

    local testcases = #()
    for test in tests do (
        local testsuite = MAXTestSuite test[2] filePath:test[1]
        local testcase = MAXTestCase test[3] testSuite:testSuite
        append testcases testcase
    )

    local parser = KeyExpressionParser()
    parser.matchTests testcases key_expr
)