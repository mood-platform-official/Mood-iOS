import ProjectDescription
import Foundation
import MoodPlugin

private let name = Template.Attribute.required("name")

private var basePath: String { "Projects/Feature/\(name)" }

private let template = Template(
    description: "Feature Module Template",
    attributes: [name],
    items: [
        ModuleTemplate.feature(path: basePath).item,
        ModuleTemplate.baseView(path: basePath).item,
        ModuleTemplate.test(path: basePath).item,
        ModuleTemplate.demo(path: basePath).item,
    ].flatMap { $0 }
)

