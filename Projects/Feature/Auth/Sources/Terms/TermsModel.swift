import Foundation
import SwiftUI
import Dependencies
import Entity

enum TermsModel {
    struct State: Equatable, Codable {
        var registerInfo: RegisterInfo?

        var isAllAgreed: Bool = false

        var isCorrectAgeSelected: Bool = false
        var isServiceSelected: Bool = false
        var isPersonalSelected: Bool = false
        var isMarketingSelected: Bool = false
    }

    enum ViewAction: Equatable {
        case onAppear
        case allSelected
        case back
        case selectedRadio(Term)
        case selectedArrow(Term)
    }
}

extension TermsModel {
    enum Term {
        case correctAge
        case service
        case personal
        case marketing
    }
}
