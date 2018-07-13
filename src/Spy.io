Spy := Block clone \
    do(
        blockToCall := nil
        callArgs := nil

        buildArgumentList := method(
            argumentData, argumentNames,

            return argumentNames \
                map(
                    name,
                    argumentData at(name)
                )
        )

        captureSpyData := method(
            argumentData,

            callArgs append(argumentData)

            argumentNames := blockToCall argumentNames
            argumentList := buildArgumentList(argumentData, argumentNames)

            blockToCall callWithArgList(argumentList)
        )

        setSpyMessage := method(
            messageString,

            spyMessage := Compiler messageForString(messageString)

            setMessage(spyMessage)

            self setScope(self)
        )
    )

Spy init := method(
        blockToCall = block()
        callArgs = list()

        setSpyMessage("captureSpyData")
)

Spy getCallCount := method(callArgs size)

Spy withBlock := method(
    blockUnderSpy,

    blockToCall = blockUnderSpy

    argumentNames := blockUnderSpy argumentNames

    self withArgs(argumentNames)

    return self
)

Spy updateBlockMessage := method(
    argumentNames,

    spyMessage := SpyMessageFactory build(argumentNames)
    setSpyMessage(spyMessage)
)

Spy updateArguments := method(
    argumentNames,
    
    setArgumentNames(argumentNames)
)

Spy withArgs := method(
    argumentNames,

    if(
        argumentNames size > 0,

        (
            updateBlockMessage(argumentNames)
            updateArguments(argumentNames)
        )
    )

    return self
)

Spy getArgsFromCall := method(
    callOffset,

    return callArgs at(callOffset)
)