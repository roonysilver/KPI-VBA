Imports System.Data.SqlClient

Public Class PhaseService
    Implements IPhase
    Dim connectionString As String = ConfigurationManager.ConnectionStrings("myConnectionString").ConnectionString
    Dim con As New SqlConnection(connectionString)
    ''' <summary>
    ''' get list phase
    ''' </summary>
    ''' <returns>list phase from db</returns>
    Public Function GetListPhase() As List(Of KPI_M_Phase) Implements IPhase.GetListPhase
        Dim lstPhase As New List(Of KPI_M_Phase)
        con.Open()
        Try
            Dim cmd = New SqlCommand()
            cmd.CommandText = "SP_GET_LIST_PHASE"
            cmd.CommandType = CommandType.Text
            cmd.Connection = con
            Dim dbReader As SqlDataReader
            dbReader = cmd.ExecuteReader(CommandBehavior.CloseConnection)
            Do While dbReader.Read()
                Dim objPhase As New KPI_M_Phase
                objPhase.IdPhase = dbReader("IdPhase").ToString
                objPhase.NamePhase = dbReader("NamePhase").ToString
                objPhase.NamePhaseJP = dbReader("NamePhaseJP").ToString
                objPhase.Target = dbReader("Target").ToString
                objPhase.TargetJP = dbReader("TargetJP").ToString
                lstPhase.Add(objPhase)
            Loop
            con.Close()
            Return lstPhase
        Catch ex As Exception
            con.Close()
            Return Nothing
        End Try
    End Function
End Class
