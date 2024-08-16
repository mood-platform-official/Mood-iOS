import XCTest
import Combine

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
    
    func test_emailBtnDidTap_failure() {
        // Given
        let state = AuthModel.State()
        let intent = AuthIntent(initialState: state)
        
        let email = "chicazic@gmail.com"
        
        // When
        intent.send(action: .emailBtnDidTap)
        
        // Then
        intent.$state
            .sink { state in
                
            }
            .store(in: &cancellable)
    }
    
    func test_emailBtnDidTap_success() {
        // Given
        let state = AuthModel.State()
        let intent = AuthIntent(initialState: state)
        
        let email = "chicazic@gmail.com"
        
        // When
        intent.send(action: .emailBtnDidTap)
        
        // Then
        intent.$state
            .sink { state in
                
            }
            .store(in: &cancellable)
    }
}
