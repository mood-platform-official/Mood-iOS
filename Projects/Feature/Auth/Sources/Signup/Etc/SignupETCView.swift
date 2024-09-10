import DesignSystem
import Base
import SwiftUI

// MARK: SignupETCView

struct SignupETCView: IntentBindingType {
    @StateObject var container: Container<SignupETCIntentType, SignupETCModel.State>
    var intent: SignupETCIntentType { self.container.intent }
    var state: SignupETCModel.State { self.intent.state }

    @Environment(\.dismiss) private var dismiss

    @FocusState var focusField: SignupETCModel.FocusField?
}

// MARK: Body

extension SignupETCView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            titleRow()
                .padding(.top, 16)
            
            if state.isShowNicknameField {
                nicknameTextFieldRow()
                    .frame(height: state.isShowNicknameField ? nil : 0, alignment: .top)
            }
            
            if state.isShowBirthDayField {
                birthDayTextFieldRow()
                    .frame(height: state.isShowBirthDayField ? nil : 0, alignment: .top)
            }
            
            nameTextFieldRow()
            
            Spacer()
            
            SolidButton(
                text: "다음",
                disabled: !state.isEnabledNextBtn,
                action: { intent.send(action: .nextBtnDidTap) }
            )
        }
        .animation(.easeInOut, value: state.isShowBirthDayField)
        .animation(.easeInOut, value: state.isShowNicknameField)
        .padding(.horizontal, 16)
        .backTopBar(title: "회원가입", backAction: { self.dismiss() })
        .task {
            self.intent.send(action: .onAppear)
        }
    }
}

extension SignupETCView {
    @ViewBuilder
    func titleRow() -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(titleText())
                .headline7(.bold)
                .multilineTextAlignment(.leading)
            
            Text(subTitleText())
                .body2()
                .foregroundStyle(Color.gray600)
                .multilineTextAlignment(.leading)
        }
    }
    
    @ViewBuilder
    func nameTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("이름")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "실명을 입력해주세요",
                text: .init(
                    get: { state.name },
                    set: { intent.send(action: .changeName($0)) }
                ),
                focusedField: ($focusField, SignupETCModel.FocusField.name),
                leftBottom: .init(text: state.nameBottomText, textColor: Color.rubyRed)
            )
            .keyboardType(.numberPad)
            .onSubmit {
                self.intent.send(action: .onSubmitName)
            }
        }
    }
    
    @ViewBuilder
    func birthDayTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("생년월일")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DatePickerRow(
                date: .init(
                    get: { state.birthDay },
                    set: { intent.send(action: .changeBirthDay($0)) }
                ),
                placeholder: "YYYY.MM.DD",
                format: "yyyy.MM.dd"
            )
            .onChange(of: state.birthDay) { oldValue, newValue in
                intent.send(action: .onSubmitBirthDay)
            }
        }
    }
    
    @ViewBuilder
    func nicknameTextFieldRow() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("닉네임")
                .subtitle5(.medium)
                .foregroundStyle(Color.gray600)
            
            DefaultTextField(
                placeholder: "별명을 입력해주세요",
                text: .init(
                    get: { state.nickname },
                    set: { intent.send(action: .changeNickname($0)) }
                ),
                focusedField: ($focusField, SignupETCModel.FocusField.nickname),
                leftBottom: .init(text: state.nickNameBottomText, textColor: Color.rubyRed)
            )
            .onSubmit {
                self.intent.send(action: .onSubmitNickname)
            }
        }
    }
    
    func titleText() -> String {
        if state.name.isEmpty || focusField == .name {
            return "이름을 입력해주세요"
        } else if state.birthDay == nil {
            return "생년월일을 입력해주세요"
        } else {
            return "사용할 닉네임을 입력해주세요"
        }
    }
    
    func subTitleText() -> String {
        return state.name.isEmpty || focusField == .name ? "본인 인증을 위해 실명으로 입력해주세요." : ""
    }
}
