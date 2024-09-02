import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "Base",
    organizationName: organizationName,
    product: .staticLibrary,
    bundleId: bundleID + "Base",
    dependencies: [
        .CoreKit,
        .design(module: .DesignSystem),
    ],
    settings: .base("Base"),
    hasTest: false
)
