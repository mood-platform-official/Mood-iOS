import DesignSystem
import Base
import SwiftUI
import Entity

// MARK: SignupTermsView

struct SignupTermsView: IntentBindingType {
    @StateObject var container: Container<SignupTermsIntentType, SignupTermsModel.State>
    var intent: SignupTermsIntentType { self.container.intent }
    var state: SignupTermsModel.State { self.intent.state }
    
    @Environment(\.dismiss) private var dismiss
    
    @SwiftUI.State private var allAgreeBtnState: Entity.UI.CheckBoxState = .unchecked
    
    @SwiftUI.State private var ageAgreeBtnState: Entity.UI.CheckBoxState = .unchecked
    @SwiftUI.State private var serviceAgreeBtnState: Entity.UI.CheckBoxState = .unchecked
    @SwiftUI.State private var personalAgreeBtnState: Entity.UI.CheckBoxState = .unchecked
    @SwiftUI.State private var markettingAgreeBtnState: Entity.UI.CheckBoxState = .unchecked
}

// MARK: Body

extension SignupTermsView: View {
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            Text("서비스 이용 약관에\n동의해주세요")
                .headline7(.bold)
                .multilineTextAlignment(.leading)
            
            termsList()
            
            Spacer()
            
            SolidButton(
                text: "다음",
                disabled: false,
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

extension SignupTermsView {
    @ViewBuilder
    func termsList() -> some View {
        VStack(spacing: 16) {
            RoundCheckBoxRow(
                state: $allAgreeBtnState,
                text: "모두 동의",
                fontWeight: .bold,
                action: { state in
                    self.allAgree(state)
                }
            )
            
            Line()
                .frame(height: 1)
                .background(Color.gray100)
            
            RoundCheckBoxRow(
                state: $ageAgreeBtnState,
                text: "(필수) 만 14세 이상입니다.",
                fontWeight: .medium,
                action: { state in
                    ageAgreeBtnState = state == .checked ? .unchecked : .checked
                    self.checkAllAgree()
                }
            )
            
            RoundCheckBoxRow(
                state: $serviceAgreeBtnState,
                text: "(필수) 서비스 이용약관 동의",
                fontWeight: .medium,
                rightBtn: .init(
                    text: "보기",
                    textColor: Color.gray400,
                    action: { intent.send(action: .serviceTermsBtnDidTap) }
                ),
                action: { state in
                    serviceAgreeBtnState = state == .checked ? .unchecked : .checked
                    self.checkAllAgree()
                }
            )
            
            RoundCheckBoxRow(
                state: $personalAgreeBtnState,
                text: "(필수) 개인정보 수집 이용 동의",
                fontWeight: .medium,
                rightBtn: .init(
                    text: "보기",
                    textColor: Color.gray400,
                    action: { intent.send(action: .personalTermsBtnDidTap) }
                ),
                action: { state in
                    personalAgreeBtnState = state == .checked ? .unchecked : .checked
                    self.checkAllAgree()
                }
            )
            
            RoundCheckBoxRow(
                state: $markettingAgreeBtnState,
                text: "(선택) 마케팅 개인정보 제 3자 제공 동의",
                fontWeight: .medium,
                rightBtn: .init(
                    text: "보기",
                    textColor: Color.gray400,
                    action: { intent.send(action: .marketingTermsBtnDidTap) }
                ),
                action: { state in
                    markettingAgreeBtnState = state == .checked ? .unchecked : .checked
                    self.checkAllAgree()
                }
            )
        }
    }
    
    private func allAgree(_ state: Entity.UI.CheckBoxState) {
        if state == .unchecked {
            allAgreeBtnState = .partial
            ageAgreeBtnState = .checked
            serviceAgreeBtnState = .checked
            personalAgreeBtnState = .checked
            markettingAgreeBtnState = .checked
        } else {
            allAgreeBtnState = .unchecked
            ageAgreeBtnState = .unchecked
            serviceAgreeBtnState = .unchecked
            personalAgreeBtnState = .unchecked
            markettingAgreeBtnState = .unchecked
        }
    }
    
    private func checkAllAgree() {
        let isAllAgree = ageAgreeBtnState == .checked
        && serviceAgreeBtnState == .checked
        && personalAgreeBtnState == .checked
        && markettingAgreeBtnState == .checked
        
        if isAllAgree {
            allAgreeBtnState = .partial
        } else if allAgreeBtnState == .partial {
            allAgreeBtnState = .unchecked
        }
    }
}
