ioTest testSuite("SpyFactory Spy") \
    test(
        "returns 0 when it has not been called",

        block(
            spy := SpyFactory build

            callCount := spy getCallCount
            failureMessage := "0-call count was not captured correctly, got #{callCount}" interpolate

            IoAssertion assertEqual(callCount, 0, failureMessage)
        )
    ) \
    test(
        "counts the number of times it is called",

        block(
            spy := SpyFactory build

            spy call()
            spy call()
            spy call()

            callCount := spy getCallCount
            failureMessage := "Expected call count of 3, got #{callCount}" interpolate

            IoAssertion assertEqual(callCount, 3, failureMessage)
        )
    ) \
    test(
        "captures predefined arguments",

        block(
            spy := SpyFactory build \
                withArgs(list("a", "b", "c"))
            
            spy call(3, 4, 5)
            spy call(1, 2, 3)

            capturedArgs := spy getArgsFromCall(1)

            IoAssertion assertEqual(capturedArgs at("a"), 1, "Argument 'a' was not captured")
            IoAssertion assertEqual(capturedArgs at("b"), 2, "Argument 'b' was not captured")
            IoAssertion assertEqual(capturedArgs at("c"), 3, "Argument 'c' was not captured")
        )
    )