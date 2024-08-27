import LinkNavigator
import Auth
import Base

struct AppRouterGroup<RootNavigator: RootNavigatorType> {
    var routers: [RouteBuilderOf<RootNavigator>] {
        [
            
        ]
        + AuthRouterGroup().routers
    }
}
