import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "Entity",
    organizationName: organizationName,
    product: .framework,
    bundleId: bundleID + "Entity",
    dependencies: [
        
    ],
    settings: .core()
)
