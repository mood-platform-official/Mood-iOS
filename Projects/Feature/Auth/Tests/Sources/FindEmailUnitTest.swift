import XCTest
import Combine
import Dependencies
import LinkNavigator

@testable import Auth

final class FindEmailUnitTest: XCTestCase {
    struct AppDependency: DependencyType {}
    var cancellable: Set<AnyCancellable> = []
    var state: FindEmailModel.State!
    var intent: FindEmailIntent!
    
    override class func setUp() {
        super.setUp()
        
        self.initialize()
    }
    
    private func intialize() {
        state = .init()
        let navigator: SingleLinkNavigator = .init(
            routeBuilderItemList: [AuthRouteBuilder.generate()],
            dependency: AppDependency()
        )
        intent = .init(initialState: state, navigator: navigator)
        
        intent.navigator = navigator
    }
    
    override func tearDownWithError() throws {
        self.cancellable = []
    }
    
    func test_폰번호입력_에러없음() {
        // Given
        let intent = self.intent
        
        let phoneNumber = "01056705622"
        
        // When
        intent?.send(action: .changePhoneNumber(phoneNumber))
        
        // Then
        intent?.$state
            .sink { state in
                XCTAssert(state.phoneNumber == phoneNumber, "phoneNumber: \(phoneNumber)")
                XCTAssert(state.isEnabledFindEmailBtn, "isEnabledEmailBtn: \(state.isEnabledFindEmailBtn)")
            }
            .store(in: &cancellable)
    }
    
    func test_이메일찾기버튼_유효성검사실패() {
        // Given
        var state = self.state
        state?.phoneNumber = "01056701234"
        let intent = self.intent
        
        let bottomText = ""
        
        // When
        intent?.send(action: .findEmailBtnDidTap)
        
        // Then
        intent?.$state
            .sink { state in
//                XCTAssert(<#T##expression: Bool##Bool#>, <#T##message: String##String#>)
            }
            .store(in: &cancellable)
    }
}
