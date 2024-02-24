// swift-tools-version: 5.8

// WARNING:
// This file is automatically generated.
// Do not edit it by hand because the contents will be replaced.

import PackageDescription
import AppleProductTypes

let package = Package(
    name: "CryptOh?",
    platforms: [
        .iOS("16.0")
    ],
    products: [
        .iOSApplication(
            name: "CryptOh?",
            targets: ["AppModule"],
            bundleIdentifier: "com.ajnettles.CryptOh-",
            teamIdentifier: "ZV4QQQ56Z3",
            displayVersion: "1.0",
            bundleVersion: "1",
            appIcon: .placeholder(icon: .box),
            accentColor: .presetColor(.green),
            supportedDeviceFamilies: [
                .pad,
                .phone
            ],
            supportedInterfaceOrientations: [
                .portrait,
                .landscapeRight,
                .landscapeLeft,
                .portraitUpsideDown(.when(deviceFamilies: [.pad]))
            ],
            capabilities: [
                .faceID(purposeString: "Face ID will be used to unlock your CryptOh Password Manager.")
            ],
            appCategory: .utilities
        )
    ],
    targets: [
        .executableTarget(
            name: "AppModule",
            path: ".",
            resources: [
                .process("Resources")
            ]
        )
    ]
)