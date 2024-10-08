import Foundation
import Combine
import Base
import LinkNavigator
import Entity
import CoreKit
import Logger

protocol SignupETCIntentType {
    var state: SignupETCModel.State { get }
    var navigator: RootNavigatorType { get }

    func send(action: SignupETCModel.ViewAction)
}

// MARK: SignupETCIntent

final class SignupETCIntent: ObservableObject {

    // MARK: Internal

    typealias State = SignupETCModel.State
    typealias ViewAction = SignupETCModel.ViewAction

    @Published var state: State

    var cancellable: Set<AnyCancellable> = []
    var navigator: RootNavigatorType

    init(
        initialState: State,
        navigator: RootNavigatorType
    ) {
        self.state = initialState
        self.navigator = navigator
    }
}

extension SignupETCIntent: IntentType, SignupETCIntentType {
    func mutate(action: SignupETCModel.ViewAction, viewEffect: (() -> Void)?) {
        switch action {
        case .onAppear:
            self.viewOnAppear()
        case .changeName(let name):
            Log.debug("changeName", name ?? "")
            state.name = name ?? ""
        case .onSubmitName:
            Log.debug("onSubmitName")
            self.onSubmitFieldName()
        case .changeBirthDay(let birthDay):
            Log.debug("changeBirthDay", birthDay ?? "")
            state.birthDay = birthDay
        case .onSubmitBirthDay:
            Log.debug("onSubmitBirthDay")
            self.changeShowFields()
        case .changeNickname(let nickname):
            Log.debug("changeNickname", nickname ?? "")
            state.nickname = nickname ?? ""
        case .onSubmitNickname:
            Log.debug("onSubmitNickname")
            self.onSubmitFieldNickname()
        case .nextBtnDidTap:
            Log.debug("nextBtnDidTap")
            self.nextBtnDidTap()
        }
    }
}

// MARK: Custom Method

extension SignupETCIntent {
    private func viewOnAppear() {}

    private func changeShowFields() {
        state.isShowBirthDayField = !state.name.isEmpty
        state.isShowNicknameField = !state.name.isEmpty && state.birthDay != nil
        state.isEnabledNextBtn = !state.name.isEmpty && state.birthDay != nil && !state.nickname.isEmpty

        state.birthDay = state.isShowBirthDayField ? state.birthDay : nil
        state.nickname = state.isShowNicknameField ? state.nickname : ""
    }

    private func onSubmitFieldName() {
        self.changeShowFields()
        state.nameBottomText = state.name.isValidName()
        ? ""
        : "올바른 이름을 입력해주세요"
    }

    private func onSubmitFieldNickname() {
        self.changeShowFields()
        state.nickNameBottomText = state.nickname.isValidNickname()
        ? ""
        : "올바른 별명을 입력해주세요"
    }

    private func nextBtnDidTap() {
        guard state.name.isValidName() else {
            Log.debug("\(#function) - invalidated Name", state.name)
            state.nameBottomText = "올바른 이름을 입력해주세요"
            return
        }

        guard state.nickname.isValidNickname() else {
            Log.debug("\(#function) - invalidated Nickname", state.nickname)
            state.nickNameBottomText = "올바른 별명을 입력해주세요"
            return
        }

        navigator.next(linkItem: .init(path: Screen.Path.SignupPhoneAuth.rawValue), isAnimated: true)
    }
}
