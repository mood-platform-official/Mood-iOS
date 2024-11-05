import LinkNavigator
import Base

public struct AuthRouterGroup<RootNavigator: RootNavigatorType> {
    public init() {}
    
    public var routers: [RouteBuilderOf<RootNavigator>] {
        [
            AuthRouteBuilder.generate(),
            TermsRouteBuilder.generate()
        ]
    }
}
