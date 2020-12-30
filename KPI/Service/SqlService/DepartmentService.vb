Imports System.Data.SqlClient

Public Class DepartmentService
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    Public Function ListDpm() As List(Of KPI_M_Department)
        Dim data As New List(Of KPI_M_Department)
        Dim con As New SqlConnection(connectionString)
        con.Open()
        Dim cmd As New SqlCommand("dbo.SP_LIST_DEPARTMENT", con)
        cmd.CommandType = CommandType.Text
        Dim da As SqlDataReader
        da = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While da.Read()
            Dim dpm As New KPI_M_Department
            dpm.IdDepartment = da("IdDerpartment").ToString
            dpm.NameDepartment = da("NameDepartment").ToString
            data.Add(dpm)
        Loop
        con.Close()
        Return data
    End Function
    Public Function ListPL(ByVal idProject As Integer) As List(Of UserInfo)
        Dim data As New List(Of UserInfo)
        Dim con As New SqlConnection(connectionString)
        con.Open()
        Dim cmd As New SqlCommand("dbo.SP_LIST_PL @idproject", con)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@idproject", idProject)
        Dim da As SqlDataReader
        da = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While da.Read()
            Dim pl As New UserInfo
            pl.IdUser = da("IdUser").ToString
            pl.FirstName = da("FirstName").ToString
            pl.LastName = da("LastName").ToString
            pl.FullName = da("FirstName").ToString + " " + da("LastName").ToString
            data.Add(pl)
        Loop
        con.Close()
        Return data
    End Function

    Public Function ListUser(idProject As Integer) As List(Of UserInfo)
        Dim data As New List(Of UserInfo)
        Dim con As New SqlConnection(connectionString)
        con.Open()
        Dim cmd As New SqlCommand("dbo.SP_LIST_User @idproject", con)
        cmd.CommandType = CommandType.Text
        cmd.Parameters.AddWithValue("@idproject", idProject)
        Dim da As SqlDataReader
        da = cmd.ExecuteReader(CommandBehavior.CloseConnection)
        Do While da.Read()
            Dim pl As New UserInfo
            pl.IdUser = da("IdUser").ToString
            pl.FirstName = da("FirstName").ToString
            pl.LastName = da("LastName").ToString
            pl.FullName = da("FirstName").ToString + " " + da("LastName").ToString
            data.Add(pl)
        Loop
        con.Close()
        Return data
    End Function
End Class
