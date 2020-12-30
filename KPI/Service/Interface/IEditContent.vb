Public Interface IEditContent
    Function GetEditContent(ByVal page As Integer, ByVal pageSize As Integer, ByVal sortColumn As String, ByVal sortOrder As String, ByVal search As String, ByVal role As String, ByVal idUser As String, ByVal idProject As Integer) As List(Of EditContentInfo)
    Function GetCountEditContent(ByVal search As String, ByVal role As String, ByVal idUser As String, ByVal idProject As Integer) As Integer
    Function GetListAnalysisContent(ByVal idUser As String, ByVal idProject As Integer, ByVal idTask As Integer, ByVal role As String) As List(Of QualityAnalysis)
    Function GetReasonOfTask(ByVal idTask As Integer, ByVal role As String, ByVal idUser As String, ByVal idProject As Integer) As KPI_T_Task
    Function UpdateReasonHour(ByVal idUser As String, ByVal role As String, ByVal idProject As Integer, ByVal idTask As Integer, ByVal hourDesign As String, ByVal hourCode As String, ByVal hourTest As String, ByVal Reason As String) As Boolean
End Interface
