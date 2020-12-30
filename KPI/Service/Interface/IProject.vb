Public Interface IProject
    Function GetListProject(ByVal idUser As String, ByVal roleName As String, pageSize As Integer, curentPage As Integer, Optional ByVal search As String = "") As List(Of ProjectInfo)
    Function GetProject(ByVal idUser As String, ByVal idProject As Integer) As ProjectInfo
    Function DeleteProject(idProject As Integer) As Boolean
    Function UpdateProject(Project As ProjectInfo) As Boolean
    Function AddProject(Project As ProjectInfo) As Integer
    Function AddMember(ByVal idProject As Integer, ByVal idMember As String) As Integer
    Function GetMemberProject(ByVal idProject As Integer) As List(Of ProjectInfo)
    Function GetProjectForRole(ByVal idUser As String, ByVal roleName As String) As KPI_T_ProjectUser
    Function GetCountProject(idUser As String, rolename As String, search As String) As Integer
End Interface
