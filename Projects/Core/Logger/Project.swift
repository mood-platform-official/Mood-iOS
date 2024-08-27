import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "Logger",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "Logger",
    dependencies: [],
    settings: .core()
)
