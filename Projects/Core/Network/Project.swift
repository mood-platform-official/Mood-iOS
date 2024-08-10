import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "Network",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "Network",
    dependencies: [
        .core(module: .Entity),
        .core(module: .ThirdPartyLibrary)
    ],
    settings: .core()
)
