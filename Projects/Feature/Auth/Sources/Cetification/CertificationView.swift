import SwiftUI
import DesignSystem
import Base
import Logger

// MARK: CertificationView

struct CertificationView: IntentBindingType {
    @StateObject var container: Container<CertificationIntentType, CertificationModel.State>
    var intent: CertificationIntentType { self.container.intent }
    var state: CertificationModel.State { self.intent.state }

    @FocusState private var focusField: CertificationModel.FocusField?
}

// MARK: Body

extension CertificationView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OverlayLine(divideBy: 1.25)

            phoneAuthSection()

            Spacer()

            SolidButton(
                text: "회원가입 완료",
                disabled: !state.isEnabledDoneBtn,
                action: { intent.send(action: .doneBtnDidTap) }
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

extension CertificationView {
    @ViewBuilder
    private func phoneAuthSection() -> some View {
        let rightBtnColor: Color = {
            if state.isError {
                return .errorText
            } else if focusField == .phoneAuth {
                return .primary500
            } else {
                return .textTertiary
            }
        }()
        let leftBtmColor: Color = state.isError ? .errorText : .textTertiary
        VStack(alignment: .leading, spacing: 16) {
            Text("마지막 단계예요! 더 안전한 서비스를 위해 휴대폰 인증을 진행할게요.")
                .headline9(.bold)
                .foregroundStyle(Color.textHeading)

            DefaultTextField(
                placeholder: "010-0000-0000",
                text: .init(
                    get: { state.phone },
                    set: { intent.send(action: .changePhoneNumber($0)) }
                ),
                focusedField: ($focusField, CertificationModel.FocusField.phoneAuth),
                isError: .init(get: { state.isError }, set: { _ in }),
                leftBottom: .init(
                    text: state.errorText,
                    defaultColor: leftBtmColor
                ),
                rightButton: .init(
                    text: "인증",
                    defaultColor: rightBtnColor,
                    action: { intent.send(action: .authBtnDidTap) }
                )
            )
        }
        .padding(.horizontal, 16)
    }
}
