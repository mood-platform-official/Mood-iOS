import LinkNavigator
import Base

public struct MainRouterGroup<RootNavigator: RootNavigatorType> {
    public init() {}
    
    public var routers: [RouteBuilderOf<RootNavigator>] {
        [
            HomeRouteBuilder.generate()
        ]
    }
}
