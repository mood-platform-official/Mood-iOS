import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "Main",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "Main",
    dependencies: [
        
    ],
    settings: .base("Main"),
    hasTest: true,
    hasDemo: true
)
