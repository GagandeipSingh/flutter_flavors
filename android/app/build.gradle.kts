plugins {
    id("com.android.application")
    id("kotlin-android")
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.flutter_flavors"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // ── Product Flavors ────────────────────────────────────────────────────
    flavorDimensions += "client"

    productFlavors {
        create("clientA") {
            dimension = "client"
            applicationId = "com.example.clienta"
            versionNameSuffix = "-alpha"
            resValue("string", "app_name", "Alpha App")
        }
        create("clientB") {
            dimension = "client"
            applicationId = "com.example.clientb"
            versionNameSuffix = "-beta"
            resValue("string", "app_name", "Beta App")
        }
    }

    buildTypes {
        release {
            // Replace with real signing config before publishing.
            signingConfig = signingConfigs.getByName("debug")
            isMinifyEnabled = true
            isShrinkResources = true
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro",
            )
        }
        debug {
            isDebuggable = true
        }
    }
}

flutter {
    source = "../.."
}
