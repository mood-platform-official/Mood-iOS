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
        VStack(spacing: 160) {
            Text("Mood")
                .headline1(.bold)
                .frame(height: 160)
                .frame(maxWidth: .infinity)
                .background(Color.grey100)

            socialButtonRows()
        }
        .frame(maxHeight: .infinity)
        .padding(.horizontal, 16)
    }
}

extension AuthView {

    @ViewBuilder
    func socialButtonRows() -> some View {
        VStack(spacing: 16) {
            Button {
                self.intent.send(action: .kakaoBtnDidTap)
            } label: {
                HStack(spacing: 8) {
                    Image.icKakaoLogo
                        .resizable()
                        .frame(width: 18, height: 18)

                    Text("카카오로 계속하기")
                        .subtitle3(.bold)
                        .foregroundStyle(.black)
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(.yellow)
            }
            .clipShape(.rect(cornerRadius: 16))

            Button {
                self.intent.send(action: .naverBtnDidTap)
            } label: {
                HStack(spacing: 8) {
                    Image.icNaverLogo
                        .resizable()
                        .frame(width: 18, height: 18)

                    Text("네이버로 계속하기")
                        .subtitle3(.bold)
                        .foregroundStyle(.white)
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(.green)
            }
            .clipShape(.rect(cornerRadius: 16))

            Button {
    //                self.intent.send(action: )
            } label: {
                HStack(spacing: 8) {
                    Image.icAppleLogo
                        .resizable()
                        .frame(width: 18, height: 18)

                    Text("애플로 계속하기")
                        .subtitle3(.bold)
                        .foregroundStyle(.white)
                }
                .padding(.vertical, 16)
                .frame(maxWidth: .infinity)
                .background(.black)
            }
            .clipShape(.rect(cornerRadius: 16))
        }
    }
}
