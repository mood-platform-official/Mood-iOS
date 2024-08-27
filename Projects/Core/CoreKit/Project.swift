import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "CoreKit",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "CoreKit",
    dependencies: [
        .core(module: .NetworkKit),
        .core(module: .Logger)
    ],
    settings: .core()
)
