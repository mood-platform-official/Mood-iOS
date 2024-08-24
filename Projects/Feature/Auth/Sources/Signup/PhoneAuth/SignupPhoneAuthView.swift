import DesignSystem
import Base
import SwiftUI
import Entity

// MARK: SignupPhoneAuthView

struct SignupPhoneAuthView: IntentBindingType {
    @StateObject var container: Container<SignupPhoneAuthIntentType, SignupPhoneAuthModel.State>
    var intent: SignupPhoneAuthIntentType { self.container.intent }
    var state: SignupPhoneAuthModel.State { self.intent.state }
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState var focusField: SignupPhoneAuthModel.FocusField?
    
    @SwiftUI.State private var timeRemaining: Int = 0
    @SwiftUI.State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
}

// MARK: Body

extension SignupPhoneAuthView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            titleRow()
                .padding(.top, 16)
            
            VStack(spacing: 8) {
                phoneNumberTextFieldRow()
                
                if state.isShowAuthCodeField {
                    authCodeTextFieldRow()
                }
            }
            
            Spacer()
            
            SolidButton(
                text: "다음",
                disabled: !state.isEnabledNextBtn,
                action: { intent.send(action: .nextBtnDidTap) }
            )
        }
        .padding(.horizontal, 16)
        .backTopBar(title: "회원가입", backAction: { self.dismiss() })
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}

extension SignupPhoneAuthView {
    @ViewBuilder
    func titleRow() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("전화번호를 인증해주세요")
                .headline7(.bold)
                .multilineTextAlignment(.leading)
            
            Text("더 안전한 커뮤니티를 위해 본인 인증이 필요해요.")
                .body2()
                .foregroundStyle(Color.gray600)
                .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    func phoneNumberTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("휴대폰 번호")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "01012345678",
                text: .init(
                    get: { state.phoneNumber },
                    set: { intent.send(action: .changePhoneNumber($0)) }
                ),
                focusedField: ($focusField, SignupPhoneAuthModel.FocusField.phoneNumber),
                rightBtn: .init(
                    text: state.isShowAuthCodeField ? "재전송" : "인증",
                    textColor: !state.isEnabledSendBtn ? .gray700 : .primary500,
                    isEnabled: state.isEnabledSendBtn,
                    action: {
                        intent.send(action: .sendAuthCodeBtnDidTap)
                        timeRemaining = 180
                        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    }
                )
            )
            .keyboardType(.numberPad)
        }
    }
    
    @ViewBuilder
    func authCodeTextFieldRow() -> some View {
        DefaultTextField(
            placeholder: "인증번호를 입력해주세요",
            text: .init(
                get: { state.authCode },
                set: { intent.send(action: .changeAuthCode($0)) }
            ),
            focusedField: ($focusField, SignupPhoneAuthModel.FocusField.authCode),
            disabled: timeRemaining == 0 || !state.isEnabledAuthCodeField,
            rightBottom: authCodeRightBottomText(),
            rightBtn: authCodeRightBtn()
        )
        .keyboardType(.numberPad)
        .onReceive(timer) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
    }
    
    private func authCodeRightBottomText() -> Entity.UI.BottomText {
        return .init(
            text: timeFormatter(timeRemaining),
            textColor: .gray600
        )
    }
    
    private func authCodeRightBtn() -> Entity.UI.RightButton {
        let isAuthcodeEmpty = state.authCode.isEmpty
        return .init(
            text: "인증하기",
            textColor: isAuthcodeEmpty ? .gray400 : .primary500,
            isEnabled: !isAuthcodeEmpty,
            action: {
                intent.send(action: .validAuthCodeBtnDidTap)
                timer.upstream.connect().cancel()
            }
        )
    }
    
    private func timeFormatter(_ value: Int) -> String {
        let timeInterval = TimeInterval(value)
        let date = Date(timeIntervalSince1970: timeInterval)
        let fmt = DateFormatter()
        fmt.dateFormat = "mm:ss"
        fmt.locale = Locale(identifier: "ko_KR")
        return fmt.string(from: date)
    }
}
