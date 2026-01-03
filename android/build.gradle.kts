allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

// Ensure subprojects evaluate :app first
subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    afterEvaluate {
        if (project.hasProperty("android")) {
            try {
                project.extensions.getByName("android").let { androidExt ->
                    val ndkVersionField = androidExt::class.java.getDeclaredField("ndkVersion")
                    ndkVersionField.isAccessible = true
                    ndkVersionField.set(androidExt, "29.0.14206865")
                }
            } catch (e: Exception) {
                println("Warning: Failed to override NDK version: ${e.message}")
            }
        }
    }
}


tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
