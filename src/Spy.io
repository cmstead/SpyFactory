Spy := Block clone \
    do(
        callArgs := nil

        captureSpyData := method(
            argumentData,

            callArgs append(argumentData)
        )

        setSpyMessage := method(
            messageString,

            spyMessage := Compiler messageForString(messageString)

            setMessage(spyMessage)

            self setScope(self)
        )
    )

Spy init := method(
        callArgs = list()

        setSpyMessage("captureSpyData")
)

Spy getCallCount := method(callArgs size)

Spy withArgs := method(
    argumentNames,

    spyMessage := SpyMessageFactory build(argumentNames)

    setArgumentNames(argumentNames)
    setSpyMessage(spyMessage)

    return self
)

Spy getArgsFromCall := method(
    callOffset,

    return callArgs at(callOffset)
)