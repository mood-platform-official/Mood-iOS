import XCTest
import Combine
import Dependencies

@testable import Auth

final class AuthUnitTest: XCTestCase {
    var cancellable: Set<AnyCancellable> = []
    
    override func tearDownWithError() throws {
        self.cancellable = []
    }
    
    func test_changeEmail() {
        // Given
        let state = AuthModel.State()
        let intent = AuthIntent(initialState: state)
        
        let email = "chicazic@gmail.com"
        
        // When
        intent.send(action: .changeEmail(email))
        
        // Then
        intent.$state
            .sink { state in
                XCTAssert(state.email == email, "email: \(email)")
                XCTAssert(state.isEnabledEmailBtn, "isEnabledEmailBtn: \(state.isEnabledEmailBtn)")
            }
            .store(in: &cancellable)
    }
    
    func test_emailBtnDidTap_이메일형식X() {
        // Given
        var state = AuthModel.State()
        state.email = "chicazicail.com"
        let intent = withDependencies {
            $0.authClient = .testValue
        } operation: {
            AuthIntent(initialState: state)
        }

        let bottomText = "올바른 이메일 형식으로 입력해주세요."
        
        // When
        intent.send(action: .emailBtnDidTap)
        
        // Then
        intent.$state
            .sink { state in
                XCTAssert(state.bottomText == bottomText, "bottomText: \(state.bottomText)")
            }
            .store(in: &cancellable)
    }
}
