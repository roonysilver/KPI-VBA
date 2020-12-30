Public Interface IUser
    Function GetUser(ByVal user As KPI_M_User) As UserInfo
    Function GetUserList() As List(Of KPI_M_User)
    Function DeleteUser(id As String) As Boolean
    Function UpdateUser(user As KPI_M_User) As KPI_M_User
    Function CreateUser(user As KPI_M_User) As KPI_M_User
    Function UpdateLockUser(ByVal CountFail As Integer, ByVal userName As String) As Boolean
    Function GetLockUser(ByVal userName As String) As Integer
    Function CheckEmail(ByVal email As String) As KPI_M_User
    Function CreateCode(ByVal email As String, ByVal code As String, timeCreate As DateTime) As Boolean
    Function CheckForgetPassword(ByVal email As String, ByVal code As String) As KPI_M_User
    Function UpdatePassword(ByVal username As String, ByVal password As String) As Boolean
End Interface
