LibPath addPathWithBaseByDirName("SpyFactory", "libs/ModuleConfig")

SpyFactoryPackage := ModuleConfig clone \
    do(
        setName("SpyFactory")
        setVersion("1.0.0")

        initializeModuleLoader()
    )

SpyFactoryPackage init := method(
    prodConfig(block(
        moduleLoader \
            addSearchPath("src") \
            configure()
    ))

    devConfig(block(

    ))
)