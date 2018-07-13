ioTest testSuite("SpyFactory build") \
    test(
        "returns a callable spy",

        block(
            spy := SpyFactory build()

            IoAssertion assertDoesNotRaiseException(block(spy()), "Spy threw exception or was not callable")
        )
    )