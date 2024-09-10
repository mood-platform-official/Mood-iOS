import Foundation
import ProjectDescription
import MoodPlugin

private let infoPlist: [String: Plist.Value] = [
    "UISupportedInterfaceOrientations": ["UIInterfaceOrientationPortrait"],
    "UILaunchScreen": [:],
    "UIUserInterfaceStyle": "Light",
    "BASE_URL": "${BASE_URL}",
    "CFBundleURLTypes": [[
        "CFBundleTypeRole": "Editor",
        "CFBundleURLSchemes": ["com.mood.Mood"]
    ]]
]

let project = Project.makeModule(
    name: "Main",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "Main",
    infoPlist: .extendingDefault(with: infoPlist),
    dependencies: [
        .feature(module: .Base)
    ],
    settings: .base("Main"),
    hasTest: true,
    hasDemo: true
)
