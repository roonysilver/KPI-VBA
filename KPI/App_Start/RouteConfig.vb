Imports System.Web.Http
Imports System.Web.Routing
Imports Microsoft.AspNet.FriendlyUrls

Public Module RouteConfig
    Sub RegisterRoutes(ByVal routes As RouteCollection)
        Dim settings As FriendlyUrlSettings = New FriendlyUrlSettings() With {
            .AutoRedirectMode = RedirectMode.Permanent
        }
        routes.EnableFriendlyUrls(settings)
        RouteTable.Routes.MapHttpRoute(name:="DefaultApi", routeTemplate:="api/{controller}/{id}", defaults:=New With {Key .id = System.Web.Http.RouteParameter.[Optional]
})
    End Sub
End Module
'.AutoRedirectMode = RedirectMode.Permanent
