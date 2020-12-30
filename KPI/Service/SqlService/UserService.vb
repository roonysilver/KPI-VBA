Imports System.Data.SqlClient

Public Class UserService
    Implements IUser
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    ''' <summary>
    ''' get user 
    ''' </summary>
    ''' <param name="user">user with user name and password</param>
    ''' <returns>info user</returns>
    Public Function GetUser(user As KPI_M_User) As UserInfo Implements IUser.GetUser
        Dim data As New UserInfo
        con.Open() 'open connect 
        Dim cmd As New SqlCommand()
        cmd.CommandText = "SP_GET_USER @password,@username"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@username", user.Username)
        cmd.Parameters.AddWithValue("@password", user.PassWord)
        Dim dbReader As SqlDataReader
        dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        'Do While dbReader.Read()
        '    Dim userObj As New UserAccount
        '    userObj.Email = dbReader("Email").ToString
        '    userObj.Password = dbReader("Password").ToString
        '    userObj.Role = dbReader("Role").ToString
        '    data = userObj
        'Loop
        dbReader.Read()
        Dim objUser As New UserInfo
        Try
            objUser.IdUser = dbReader("IdUser").ToString
            objUser.Username = dbReader("Username").ToString
            objUser.PassWord = dbReader("Password").ToString
            objUser.RoleName = dbReader("Name").ToString
            objUser.FirstName = dbReader("FirstName").ToString
            objUser.LastName = dbReader("LastName").ToString
            objUser.Phone = dbReader("Phone").ToString
            objUser.Address = dbReader("Address").ToString
            objUser.Dob = dbReader("Dob").ToString
            objUser.email = dbReader("Email").ToString
            objUser.LoginFail = dbReader("LoginFail").ToString
        Catch ex As Exception

        End Try
        data = objUser
        con.Close() 'đóng kết nối sau khi sử dụng
        Return data
    End Function

    Public Function GetUserList() As List(Of KPI_M_User) Implements IUser.GetUserList
        Throw New NotImplementedException()
    End Function

    Public Function DeleteUser(id As String) As Boolean Implements IUser.DeleteUser
        Throw New NotImplementedException()
    End Function

    Public Function UpdateUser(user As KPI_M_User) As KPI_M_User Implements IUser.UpdateUser
        Throw New NotImplementedException()
    End Function

    Public Function CreateUser(user As KPI_M_User) As KPI_M_User Implements IUser.CreateUser
        Throw New NotImplementedException()
    End Function
    ''' <summary>
    ''' update count number login fail for user
    ''' </summary>
    ''' <param name="CountFail">count number login fail</param>
    ''' <param name="userName">username</param>
    ''' <returns>return true if update sucsess or false if update fail</returns>
    Public Function UpdateLockUser(ByVal CountFail As Integer, ByVal userName As String) As Boolean Implements IUser.UpdateLockUser
        Try
            con.Open()
            Dim cmd = New SqlCommand()
            cmd.CommandText = "SP_UPDATE_LOCK_USER @CountFail, @userName"
            cmd.CommandType = CommandType.Text
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@CountFail", CountFail)
            cmd.Parameters.AddWithValue("@userName", userName)
            cmd.ExecuteNonQuery()
            con.Close()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    ''' <summary>
    ''' get number count login fail for user
    ''' </summary>
    ''' <param name="userName"></param>
    ''' <returns></returns>
    Public Function GetLockUser(userName As String) As Integer Implements IUser.GetLockUser
        con.Open() 'open connect 
        Dim cmd As New SqlCommand()
        cmd.CommandText = "SP_GET_LOCK_USER @username"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@username", userName)
        Dim dbReader As SqlDataReader
        dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        'Do While dbReader.Read()
        '    Dim userObj As New UserAccount
        '    userObj.Email = dbReader("Email").ToString
        '    userObj.Password = dbReader("Password").ToString
        '    userObj.Role = dbReader("Role").ToString
        '    data = userObj
        'Loop
        Dim countLoginFail As Integer
        dbReader.Read()
        Try
            countLoginFail = dbReader("LoginFail").ToString
        Catch ex As Exception

        End Try
        con.Close() 'đóng kết nối sau khi sử dụng
        Return countLoginFail
    End Function
    ''' <summary>
    ''' check email exist in database 
    ''' </summary>
    ''' <param name="email"></param>
    ''' <returns>if email exist return user info or if email is not exist return nothing</returns>
    Public Function CheckEmail(email As String) As KPI_M_User Implements IUser.CheckEmail
        con.Open() 'open connect 
        Dim cmd As New SqlCommand()
        cmd.CommandText = "SP_CHECK_EMAIL @email"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@email", email)
        Dim dbReader As SqlDataReader
        dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        'Do While dbReader.Read()
        '    Dim userObj As New UserAccount
        '    userObj.Email = dbReader("Email").ToString
        '    userObj.Password = dbReader("Password").ToString
        '    userObj.Role = dbReader("Role").ToString
        '    data = userObj
        'Loop
        dbReader.Read()
        Dim objUser As New KPI_M_User
        Try
            objUser.IdUser = dbReader("IdUser").ToString
            objUser.Username = dbReader("Username").ToString
            objUser.FirstName = dbReader("FirstName").ToString
            objUser.LastName = dbReader("LastName").ToString
            objUser.Phone = dbReader("Phone").ToString
            objUser.Address = dbReader("Address").ToString
            objUser.Dob = dbReader("Dob").ToString
            objUser.email = dbReader("Email").ToString
            objUser.LoginFail = dbReader("LoginFail").ToString
            objUser.Token = dbReader("Token").ToString
            objUser.TimeForget = DateTime.Parse(dbReader("TimeForget"))
            con.Close()
            Return objUser
        Catch ex As Exception
            Return Nothing
        End Try
    End Function
    ''' <summary>
    ''' set token and time for user (when send mail reset password) 
    ''' </summary>
    ''' <param name="email"></param>
    ''' <param name="code">token</param>
    ''' <param name="timeCreate">time when send email</param>
    ''' <returns>return true if set suscess or fail if set fail</returns>
    Public Function CreateCode(ByVal email As String, ByVal code As String, timeCreate As DateTime) As Boolean Implements IUser.CreateCode
        Try
            con.Open()
            Dim cmd = New SqlCommand()
            cmd.CommandText = "SP_CREATE_CODE @email, @code, @timeCreate"
            cmd.CommandType = CommandType.Text
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@email", email)
            cmd.Parameters.AddWithValue("@code", code)
            cmd.Parameters.AddWithValue("@timeCreate", timeCreate)
            cmd.ExecuteNonQuery()
            con.Close()
            Return True
        Catch ex As Exception
            Return False
        End Try
    End Function
    ''' <summary>
    ''' check user exist with token and email
    ''' </summary>
    ''' <param name="email"></param>
    ''' <param name="code">token</param>
    ''' <returns>return user if user exist or nothing if user is not exist</returns>
    Public Function CheckForgetPassword(email As String, code As String) As KPI_M_User Implements IUser.CheckForgetPassword
        Dim data As New KPI_M_User
        con.Open() 'open connect 
        Dim cmd As New SqlCommand()
        cmd.CommandText = "SP_CHECK_FORGET_PASS @email,@code"
        cmd.CommandType = CommandType.Text
        cmd.Connection = con
        cmd.Parameters.AddWithValue("@email", email)
        cmd.Parameters.AddWithValue("@code", code)
        Dim dbReader As SqlDataReader
        dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        'Do While dbReader.Read()
        '    Dim userObj As New UserAccount
        '    userObj.Email = dbReader("Email").ToString
        '    userObj.Password = dbReader("Password").ToString
        '    userObj.Role = dbReader("Role").ToString
        '    data = userObj
        'Loop
        dbReader.Read()
        Dim objUser As New KPI_M_User
        Try
            objUser.IdUser = dbReader("IdUser").ToString
            objUser.Username = dbReader("Username").ToString
            objUser.FirstName = dbReader("FirstName").ToString
            objUser.LastName = dbReader("LastName").ToString
            objUser.Phone = dbReader("Phone").ToString
            objUser.Address = dbReader("Address").ToString
            objUser.Dob = dbReader("Dob").ToString
            objUser.email = dbReader("Email").ToString
            objUser.LoginFail = dbReader("LoginFail").ToString
            objUser.Token = dbReader("Token").ToString
            objUser.TimeForget = DateTime.Parse(dbReader("TimeForget"))
            data = objUser
            con.Close() 'đóng kết nối sau khi sử dụng
            Return data
        Catch ex As Exception
            con.Close()
            Return Nothing
        End Try
    End Function
    ''' <summary>
    ''' update new password
    ''' </summary>
    ''' <param name="username"></param>
    ''' <param name="password"></param>
    ''' <returns>return true if update sucess false if update fail</returns>
    Public Function UpdatePassword(username As String, password As String) As Boolean Implements IUser.UpdatePassword
        Try
            con.Open()
            Dim cmd = New SqlCommand()
            cmd.CommandText = "SP_UPDATE_PASSWORD @username, @password"
            cmd.CommandType = CommandType.Text
            cmd.Connection = con
            cmd.Parameters.AddWithValue("@username", username)
            cmd.Parameters.AddWithValue("@password", password)
            cmd.ExecuteNonQuery()
            con.Close()
            Return True
        Catch ex As Exception
            con.Close()
            Return False
        End Try
    End Function
End Class
