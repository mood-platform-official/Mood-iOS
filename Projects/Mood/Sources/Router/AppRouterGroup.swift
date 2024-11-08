import LinkNavigator
import Auth
import Main
import Base

struct AppRouterGroup<RootNavigator: RootNavigatorType> {
    var routers: [RouteBuilderOf<RootNavigator>] {
        AuthRouterGroup().routers
        + MainRouterGroup().routers
    }
}
