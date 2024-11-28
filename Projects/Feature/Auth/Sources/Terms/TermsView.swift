import SwiftUI
import Base
import DesignSystem

// MARK: TermsView

struct TermsView: IntentBindingType {
    @StateObject var container: Container<TermsIntentType, TermsModel.State>
    var intent: TermsIntentType { self.container.intent }
    var state: TermsModel.State { self.intent.state }
}

// MARK: Body

extension TermsView: View {

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            OverlayLine(divideBy: 4)

            termsSection()
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

extension TermsView {
    @ViewBuilder
    private func termsSection() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("서비스 이용 약관에 동의해주세요")
                .headline9(.bold)
                .foregroundStyle(Color.textHeading)

            TermsRow(title: "모두 동의", isAgreed: state.isAllAgreed) {
                self.intent.send(action: .allSelected)
            }
            Line()
                .frame(height: 1)
                .background(Color.dividerGrey)
            TermsRow(
                title: "(필수) 만 14세 이상입니다.",
                isAgreed: state.isCorrectAgeSelected,
                tapAction: { self.intent.send(action: .selectedRadio(.correctAge)) }
            )
            TermsRow(
                title: "(필수) 서비스 이용약관 동의",
                isAgreed: state.isServiceSelected,
                tapAction: { self.intent.send(action: .selectedRadio(.service)) },
                arrowAction: { self.intent.send(action: .selectedArrow(.service)) }
            )
            TermsRow(
                title: "(필수) 개인정보 수집 이용 동의",
                isAgreed: state.isPersonalSelected,
                tapAction: { self.intent.send(action: .selectedRadio(.personal)) },
                arrowAction: { self.intent.send(action: .selectedArrow(.personal)) }
            )
            TermsRow(
                title: "(선택) 마케팅 개인정보 제 3자 제공 동의",
                isAgreed: state.isMarketingSelected,
                tapAction: { self.intent.send(action: .selectedRadio(.marketing)) },
                arrowAction: { self.intent.send(action: .selectedArrow(.marketing)) }
            )
        }
        .padding(.horizontal, 16)
    }

    private struct TermsRow: View {
        var title: String
        var isAgreed: Bool
        var tapAction: () -> Void
        var arrowAction: (() -> Void)?

        var body: some View {
            HStack(alignment: .center, spacing: 8) {
                DefaultRadio(isChecked: isAgreed, action: tapAction)

                Text(title)
                    .body3()
                    .foregroundStyle(Color.textHeading)

                Spacer()

                if let arrowAction {
                    Button {
                        arrowAction()
                    } label: {
                        Image.chevronRight
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                }
            }
        }
    }
}
