ioTest testSuite("SpyFactory Spy") \
    test(
        "returns 0 when it has not been called",

        block(
            spy := SpyFactory build

            callCount := spy getCallCount
            failureMessage := "0-call count was not captured correctly, got #{callCount}" interpolate

            IoAssertion assertEqual(0, callCount, failureMessage)
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

            IoAssertion assertEqual(3, callCount, failureMessage)
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

            IoAssertion assertEqual(1, capturedArgs at("a"), "Argument 'a' was not captured")
            IoAssertion assertEqual(2, capturedArgs at("b"), "Argument 'b' was not captured")
            IoAssertion assertEqual(3, capturedArgs at("c"), "Argument 'c' was not captured")
        )
    ) \
    test(
        "calls provided block when spy is called",

        block(
            internalSpy := SpyFactory build
            spyUnderTest := SpyFactory build \
                withBlock(internalSpy)

            spyUnderTest call()
            spyUnderTest call()
            spyUnderTest call()
            spyUnderTest call()

            callCount := internalSpy getCallCount()

            IoAssertion assertEqual(4, callCount)
        )
    ) \
    test(
        "calls provided block with correct arguments",

        block(
            internalSpy := SpyFactory build \
                withArgs(list("a", "b", "c"))

            spyUnderTest := SpyFactory build \
                withBlock(internalSpy)

            expectedA := "argA"
            expectedB := "argB"
            expectedC := "argC"

            spyUnderTest call(expectedA, expectedB, expectedC)

            capturedArgs := internalSpy getArgsFromCall(0)

            IoAssertion assertEqual(expectedA, capturedArgs at("a"), "Argument 'a' was not passed through")
            IoAssertion assertEqual(expectedB, capturedArgs at("b"), "Argument 'b' was not passed through")
            IoAssertion assertEqual(expectedC, capturedArgs at("c"), "Argument 'c' was not passed through")
        )
    )
