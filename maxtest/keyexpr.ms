fileIn "model.ms"
fileIn "logger.ms"


/*
 *  KeyExpressionMatcher is a module that can select strings (in
 *  this case testnames) that match a given keyword expression.
 *
 *  Returns matching tests as objects the runner can use to execute the tests.
 */
struct KeyExpressionMatcher
(
    private _ignoredTokens =  #("and", "or", "not", ""),
    private _log = MAXTestLogger "maxtest.matcher",


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
         *  Note: Is not case-sensitive.
         */
        local space = " "
        local replaceThese = #("(", ")")

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
            for ignore in this._ignoredTokens do (
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
         * TODO: We need to protect ignored tokens from substitution
         *  e.g. to prevent turning expr 'not no' into 'falset false'.
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
         *  Note: An empty expression will evaluate to true.
         *  An invalid expression will evaluate to false.
         */
        expr = trimRight (trimLeft expr)
        if expr == "" do (
            return true
        )

        try (
            local val = (execute expr) as BooleanClass
            return val
        )
        catch()

        this._log.warn ("Expression is invalid: "  + expr as string)
        false
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
        expr = toLower expr
        local matches = #()

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
            local matched = this.asBoolean subsExpr
            if matched then (
                this._log.info ("Selecting " + testName)
                append matches testCase
            )
            else (
                this._log.info ("Deselecting " + testName)
            )
        )

        matches
    )
)



-- -- Testing:
-- (
-- --     local key_expr = "(clang and dang or (not foo) or zip)not(lol and kek)and bur "
-- --     local key_expr = "(foo or bar) and (not baz)"
-- --     local key_expr = "(not baz)"
--     local key_expr = "(not no)"
--     local tests = #(#("test_things", "TestFoo", "test_foo"),
--                     #("test_things", "TestFoo", "test_bar"),
--                     #("test_things", "TestBar", "test_foo"),
--                     #("test_things", "TestFoo", "test_baz"),
--                     #("test_things", "TestBaz", "test_foo"))

--     local testcases = #()
--     for test in tests do (
--         local testsuite = MAXTestSuite test[2] filePath:test[1]
--         local testcase = MAXTestCase test[3] testSuite:testSuite
--         append testcases testcase
--     )

--     local matcher = KeyExpressionMatcher()
--     local matches = matcher.matchTests testcases key_expr

--     for match in matches do
--         print match
-- )