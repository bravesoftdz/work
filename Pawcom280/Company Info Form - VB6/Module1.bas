Attribute VB_Name = "Module1"
Option Explicit

' Status codes
Global Const btStatusOK = 0
Global Const btKeyNotFound = 4
Global Const btDuplicateKey = 5
Global Const btInvalidKeyNo = 6
Global Const btEOF = 9
Global Const btInvalidFileName = 11
Global Const btFileNotFound = 12
Global Const btDataBufLength = 22
Global Const btFileInUse = 85

Sub BtrieveConnect()
    Dim CompanyPath As String
    Dim Status      As Integer
    CompanyPath = DLookup("Path", "Current Company")
    Status = oBtrieve.Connect(CompanyPath)
    If Status <> btStatusOK Then
        DoCmd.OpenForm "Open Company"
    End If
End Sub
Sub BtrieveDisconnect()
    Dim Status As Integer
    oBtrieve.Disconnect
    If oBtrieve.ConnectCount = 0 Then Set oBtrieve = Nothing
End Sub
