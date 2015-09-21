-- key_expr = "(clang and dang or (not foo) or zip)not(lol and kek)and bur "
key_expr = "(foo or bar) and (not baz)"
tests = #("test_things.TestFoo.test_foo",
          "test_things.TestFoo.test_bar",
          "test_things.TestBar.test_foo",
          "test_things.TestFoo.test_baz",
          "test_things.TestBaz.test_foo")


fn get_tokens expr = (
    /***Gets a keyword expression and returns all valid keywords.***/
    local nothing = ""
    local space = " "
    local replacethese = #("(", ")")
    local ignored = #("and", "or", "not", nothing)

    -- Replace all parentheses by spaces and split by that.
    expr = toLower expr
    for replacethis in replacethese do (
        expr = substituteString expr replacethis space
    )
    local rawtokens = filterString expr space
    local tokens = #()

    -- Capture tokens that are neither empty nor reserved.
    for rawtoken in rawtokens do (
        local skip = false
        local token = rawtoken
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
)


fn substitute_tokens expr token_value_pairs = (
    /***Substitutes tokens in the expressions by their boolean values.

    The input list contains pairs of #(<token>, <bool>) which is
    used for substitution. Returns the complete substituted expression,
    ready for evaluation.

    ***/
    for pair in token_value_pairs do (
        local token = pair[1]
        local val = pair[2]
        expr = substituteString expr token (val as string)
    )
    expr
)


fn as_boolean expr = (
    (execute expr) as BooleanClass
)



(
    for test in tests do (
        local test = toLower test

        local tokens = get_tokens key_expr
        local token_value_pairs = #()

        for token in tokens do (
            local val = (findString test token) != undefined
            local pair = #(token, val)
            append token_value_pairs pair
        )
        local expr = substitute_tokens key_expr token_value_pairs
        local result = as_boolean expr

        format "orig. expr: %\n" key_expr
        format "subs. expr: %\n" expr
        format "% : %\n" test result
        format "\n"
    )

)