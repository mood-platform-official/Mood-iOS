import SwiftUI
import DesignSystem
import Base

// MARK: AccountSleepView

struct AuthView: IntentBindingType {
    @StateObject public var container: Container<AuthIntentType, AuthModel.State>
    var intent: AuthIntentType { self.container.intent }
    var state: AuthModel.State { self.intent.state }
    
    init(container: Container<AuthIntentType, AuthModel.State>) {
        self._container = StateObject(wrappedValue: container)
    }
    
    @FocusState var focusField: AuthModel.FocusField?
}

extension AuthView: View {
    var body: some View {
        VStack(spacing: 72) {
            Text("Mood")
                .headline1(.bold)
                .frame(height: 50)
                .frame(maxWidth: .infinity)
                .background(Color.gray100)
                
            VStack(spacing: 36) {
                VStack(spacing: 12) {
                    emailTextFieldRow()
                    
                    SolidButton(
                        text: "이메일로 계속하기",
                        disabled: !self.state.isEnabledEmailBtn,
                        action: { self.intent.send(action: .emailBtnDidTap) }
                    )
                }
                
                socialIconButtonRow()
                findButtonRow()
            }
        }
        .padding(.horizontal, 16)
    }
}

extension AuthView {
    @ViewBuilder
    func emailTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("이메일")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "이메일을 입력해주세요",
                text: .init(
                    get: { state.email },
                    set: { intent.send(action: .changeEmail($0)) }
                ),
                focusedField: ($focusField, AuthModel.FocusField.email),
                disabled: false,
                isError: .init(
                    get: { state.isErrorEmailBtn },
                    set: { _ in }
                ),
                leftBottom: .init(
                    text: state.bottomText,
                    textColor: .rubyRed
                )
            )
        }
    }
    
    @ViewBuilder
    func socialIconButtonRow() -> some View {
        HStack(alignment: .center, spacing: 20) {
            Button {
//                self.intent.send(action: )
            } label: {
                Image.icKakaoSocialButton
                    .resizable()
                    .frame(width: 52, height: 52)
            }
            
            Button {
//                self.intent.send(action: )
            } label: {
                Image.icNaverSocialButton
                    .resizable()
                    .frame(width: 52, height: 52)
            }
            
            Button {
//                self.intent.send(action: )
            } label: {
                Image.icAppleSocialButton
                    .resizable()
                    .frame(width: 52, height: 52)
            }
        }
    }
    
    @ViewBuilder
    func findButtonRow() -> some View {
        HStack(alignment: .center, spacing: 12) {
            Button {
                
            } label: {
                Text("이메일 찾기")
                    .caption1()
                    .foregroundStyle(Color.gray600)
            }
            
            Line()
                .frame(width: 1, height: 12)
                .background(Color.gray200)
            
            Button {
                
            } label: {
                Text("비밀번호 찾기")
                    .caption1()
                    .foregroundStyle(Color.gray600)
            }
        }
    }
}
