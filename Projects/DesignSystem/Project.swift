import Foundation
import ProjectDescription
import MoodPlugin

let project = Project.makeModule(
    name: "DesignSystem",
    organizationName: organizationName,
    product: .framework,
    bundleId: bundleID + "DesignSystem",
    infoPlist: .extendingDefault(with: [
        "UIAppFonts": [
            "Pretendard-Bold.otf",
            "Pretendard-Medium.otf",
            "Pretendard-Regular.otf"
        ]
    ]),
    resources: ["Resources/**"],
    dependencies: [
        .core(module: .Entity),
        .core(module: .ThirdPartyLibrary)
    ],
    settings: .core(),
    hasDemo: true
)
