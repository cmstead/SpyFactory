SpyMessageFactory := Object clone \
    do(
        buildArgumentKeyValueString := method(
            argumentNames,

            argumentKeyValueString := ""

            argumentNames foreach(
                name,
                (
                    delimeter := ", "

                    if(
                        argumentKeyValueString == "",
                        delimeter = ""
                    )

                    argumentKeyValueString = argumentKeyValueString .. delimeter .. (""""#{name}", #{name}""" interpolate)
                ))
        
            return argumentKeyValueString
        )
    )

SpyMessageFactory build := method(
    argumentNames,

    argumentKeyValueString := buildArgumentKeyValueString(argumentNames)
    
    """
    argumentMap := Map clone \
        with(#{argumentKeyValueString})
    captureSpyData(argumentMap)
    """ interpolate
)