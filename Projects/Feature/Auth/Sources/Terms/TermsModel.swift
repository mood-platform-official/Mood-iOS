//
//  TermsModel.swift
//  Auth
//
//  Created by 송형욱 on 11/5/24.
//  Copyright © 2024 com.mood. All rights reserved.
//

import Foundation
import SwiftUI
import Dependencies

enum TermsModel {
    struct State: Equatable {
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
