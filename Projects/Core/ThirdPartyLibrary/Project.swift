import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "ThirdPartyLibrary",
    organizationName: organizationName,
    product: .framework,
    bundleId: bundleID + "ThirdPartyLibrary",
    dependencies: [
        .SPM.Dependencies,
        .SPM.LinkNavigator,
        .SPM.NukeUI
    ],
    settings: .core()
)
