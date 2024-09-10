import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "NetworkKit",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "NetworkKit",
    dependencies: [
        .core(module: .Entity),
        .core(module: .ThirdPartyLibrary)
    ],
    settings: .core()
)
