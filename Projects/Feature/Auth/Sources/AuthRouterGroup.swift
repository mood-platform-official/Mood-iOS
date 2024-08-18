import LinkNavigator
import Base

public struct AuthRouterGroup<RootNavigator: RootNavigatorType> {
    public init() {}
    
    public var routers: [RouteBuilderOf<RootNavigator>] {
        [
            AuthRouteBuilder.generate(),
            LoginRouteBuilder.generate(),
            FindEmailRouter.generate(),
            FindPasswordRouter.generate(),
            SignupPasswordRouter.generate(),
            SignupETCRouter.generate(),
            SignupPhoneAuthRouter.generate(),
            SignupTermsRouter.generate()
        ]
    }
}
