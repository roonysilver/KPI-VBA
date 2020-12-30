Imports System.Net
Imports System.Web.Http

Public Class DetailQuanlityController
    Inherits ApiController

    ' GET api/<controller>
    'Public Function GetValues() As IEnumerable(Of String)
    '    Dim demo As New List(Of String)
    '    demo.Add("ok")
    '    demo.Add("ok1")
    '    Return demo
    'End Function

    ' GET api/<controller>/5
    Public Function GetValue(ByVal idProject As Integer, ByVal idTask As Integer) As String
        Return "value"
    End Function

    ' POST api/<controller>
    Public Sub PostValue(<FromBody()> ByVal value As String)

    End Sub

    ' PUT api/<controller>/5
    Public Sub PutValue(ByVal id As Integer, <FromBody()> ByVal value As String)

    End Sub

    ' DELETE api/<controller>/5
    Public Sub DeleteValue(ByVal id As Integer)

    End Sub
End Class
