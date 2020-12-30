Imports System.Security.Principal

Public Class UserCookieData
    Public Shared Function GetUserData() As UserInfo
        Dim genericPrincipal As System.Security.Principal.GenericPrincipal = CType(HttpContext.Current.User, System.Security.Principal.GenericPrincipal)
        Dim user As New UserInfo
        Dim id As FormsIdentity = DirectCast(HttpContext.Current.User.Identity, FormsIdentity)
        Dim ticket As FormsAuthenticationTicket = id.Ticket
        Dim userData As String = ticket.UserData
        user = CookieStringToUser(userData)
        Return user
    End Function
    Public Shared Function UserToCookieString(ByVal user As UserInfo) As String
        Return String.Format($"{user.IdUser}|{user.FirstName}|{user.LastName}|{user.Phone}|{user.Address}|{user.Dob}|{user.RoleName}|{user.email}")
    End Function
    Public Shared Function CookieStringToUser(ByVal cookieString As String) As UserInfo
        Dim infos As String() = cookieString.Split("|")
        Dim user As New UserInfo
        user.IdUser = infos(0)
        user.FirstName = infos(1)
        user.LastName = infos(2)
        user.Phone = infos(3)
        user.Address = infos(4)
        user.Dob = infos(5)
        user.RoleName = infos(6)
        user.email = infos(7)
        Return user
    End Function
End Class
