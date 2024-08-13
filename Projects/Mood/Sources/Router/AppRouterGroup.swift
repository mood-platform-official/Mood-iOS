import LinkNavigator
import Auth

public typealias RootNavigatorType = LinkNavigatorFindLocationUsable & LinkNavigatorProtocol

struct AppRouterGroup<RootNavigator: RootNavigatorType> {
    var routers: [RouteBuilderOf<RootNavigator>] {
        [AuthRouteBuilder.generate()]
    }
}
