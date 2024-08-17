import XCTest
import Combine
import Dependencies
import LinkNavigator

@testable import Auth

final class AuthUnitTest: XCTestCase {
    struct AppDependency: DependencyType {}
    var cancellable: Set<AnyCancellable> = []
    var state: AuthModel.State?
    var intent: AuthIntent?
    var navigator: SingleLinkNavigator?
    
    override class func setUp() {
        super.setUp()
    }
    
    private func initialize() {
        let initState: AuthModel.State = .init()
        let initNavigator: SingleLinkNavigator = .init(
            routeBuilderItemList: [AuthRouteBuilder.generate()],
            dependency: AppDependency()
        )
        navigator = initNavigator
        state = initState
        intent = withDependencies {
            $0.authClient = .testValue
        } operation: {
            AuthIntent(initialState: initState, navigator: initNavigator)
        }
    }
    
    override func tearDownWithError() throws {
        self.cancellable = []
    }
    
    func test_changeEmail() {
        // Given
        let intent = self.intent
        
        let email = "chicazic@gmail.com"
        
        // When
        intent?.send(action: .changeEmail(email))
        
        // Then
        intent?.$state
            .sink { state in
                XCTAssert(state.email == email, "email: \(email)")
                XCTAssert(state.isEnabledEmailBtn, "isEnabledEmailBtn: \(state.isEnabledEmailBtn)")
            }
            .store(in: &cancellable)
    }
    
    func test_emailBtnDidTap_이메일형식X() {
        // Given
        var state = self.state
        state?.email = "chicazicail.com"
        let intent = self.intent

        let bottomText = "올바른 이메일 형식으로 입력해주세요."
        
        // When
        intent?.send(action: .emailBtnDidTap)
        
        // Then
        intent?.$state
            .sink { state in
                XCTAssert(state.bottomText == bottomText, "bottomText: \(state.bottomText)")
            }
            .store(in: &cancellable)
    }
}
