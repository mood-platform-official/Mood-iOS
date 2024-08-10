import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "DesignSystem",
    organizationName: organizationName,
    product: .framework,
    bundleId: bundleID + "DesignSystem",
    resources: ["Resources/**"],
    dependencies: [
        .core(module: .Entity),
        .core(module: .ThirdPartyLibrary)
    ],
    settings: .core(),
    hasDemo: true
)
