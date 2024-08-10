import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "CoreKit",
    organizationName: organizationName,
    product: .framework,
    bundleId: bundleID + "CoreKit",
    dependencies: [
        .core(module: .Network),
        .core(module: .Logger)
    ],
    settings: .core()
)
