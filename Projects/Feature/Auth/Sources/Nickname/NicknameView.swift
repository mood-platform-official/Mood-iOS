import Foundation
import SwiftUI
import Base
import DesignSystem
import Logger

// MARK: NicknameView

struct NicknameView: IntentBindingType {
    @StateObject var container: Container<NicknameIntentType, NicknameModel.State>
    var intent: NicknameIntentType { self.container.intent }
    var state: NicknameModel.State { self.intent.state }

    init(container: Container<NicknameIntentType, NicknameModel.State>) {
        self._container = StateObject(wrappedValue: container)

        Log.debug("NicknameView init")
    }

    @FocusState private var focusField: NicknameModel.FocusField?
}

// MARK: Body

extension NicknameView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OverlayLine(divideBy: 2)

            nicknameSection()

            Spacer()

            SolidButton(
                text: "다음",
                disabled: !state.isEnabledNextBtn,
                action: { intent.send(action: .nextBtnDidTap) }
            )
            .padding(16)
        }
        .backTopBar(
            title: "회원가입",
            backAction: { self.intent.send(action: .back) }
        )
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}

extension NicknameView {
    @ViewBuilder
    private func nicknameSection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("닉네임을 입력해주세요")
                .headline9(.bold)
                .foregroundStyle(Color.textHeading)
            DefaultTextField(
                placeholder: "닉네임을 입력해주세요",
                text: .init(
                    get: { state.nickname },
                    set: { intent.send(action: .changeNickname($0)) }
                ),
                focusedField: ($focusField, NicknameModel.FocusField.nickname),
                isError: .init(get: { state.isError }, set: { _ in }),
                leftBottom: .init(
                    text: state.errorText,
                    defaultColor: state.isError ? Color.errorText : Color.textTertiary
                )
            )
        }
        .padding(.horizontal, 16)
    }
}
