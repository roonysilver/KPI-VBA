Public Interface IContent
    Function GetContent(ByVal Content As KPI_T_Task) As KPI_T_Task
    Function GetContentList(IdProject As String, PageNumber As Integer, PageSize As Integer, search As String, sortColumn As String, sortOrder As String, idUser As String) As List(Of KPI_T_Task)
    Function DeleteContent(id As Integer) As Boolean
    Function UpdateContent(Content As KPI_T_Task, UserId As KPI_T_ProjectUser) As KPI_T_Task
    Function CreateContent(Content As KPI_T_Task) As KPI_T_Task
End Interface
