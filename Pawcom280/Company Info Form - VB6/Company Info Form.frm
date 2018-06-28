VERSION 5.00
Begin VB.Form frmCompanyInfo 
   Appearance      =   0  'Flat
   BackColor       =   &H80000005&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Maintain Company Information"
   ClientHeight    =   5160
   ClientLeft      =   1905
   ClientTop       =   2505
   ClientWidth     =   6255
   DrawMode        =   16  'Merge Pen
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3.583
   ScaleMode       =   5  'Inch
   ScaleWidth      =   4.344
   Begin VB.ComboBox cboBusinessTypeCode 
      Height          =   315
      ItemData        =   "Company Info Form.frx":0000
      Left            =   1680
      List            =   "Company Info Form.frx":0013
      TabIndex        =   22
      Text            =   "cbo"
      ToolTipText     =   "Click down arrow and select BUSINESS TYPE from list."
      Top             =   3360
      Width           =   3015
   End
   Begin VB.TextBox txtZip 
      Height          =   315
      Left            =   4512
      TabIndex        =   8
      ToolTipText     =   "Enter the ZIP code for the company's address."
      Top             =   1800
      Width           =   1368
   End
   Begin VB.TextBox txtCity 
      Height          =   315
      Left            =   1680
      TabIndex        =   5
      ToolTipText     =   "Enter the CITY for the company's address."
      Top             =   1800
      Width           =   2088
   End
   Begin VB.TextBox txtAddress1 
      Height          =   315
      Left            =   1680
      TabIndex        =   3
      ToolTipText     =   "Enter the first line of the company's ADDRESS."
      Top             =   1140
      Width           =   4200
   End
   Begin VB.TextBox txtCompanyName 
      Height          =   315
      Left            =   1680
      TabIndex        =   1
      ToolTipText     =   "Enter the company's NAME."
      Top             =   780
      Width           =   4200
   End
   Begin VB.TextBox txtETAUnknown 
      Height          =   315
      Left            =   4512
      TabIndex        =   31
      Text            =   "txtETAUnknown"
      Top             =   5520
      Visible         =   0   'False
      Width           =   1365
   End
   Begin VB.ComboBox cboPostingMethod 
      Height          =   315
      ItemData        =   "Company Info Form.frx":0070
      Left            =   1680
      List            =   "Company Info Form.frx":007A
      TabIndex        =   24
      Text            =   "cboPostingMethod"
      ToolTipText     =   "Click down arrow and select POSTING METHOD from list."
      Top             =   3720
      Width           =   1320
   End
   Begin VB.TextBox txtETACompanyID 
      Height          =   315
      Left            =   4560
      TabIndex        =   29
      Text            =   "txtETACompanyID"
      Top             =   4680
      Width           =   1365
   End
   Begin VB.TextBox txtSUIN 
      Height          =   315
      Left            =   5160
      TabIndex        =   20
      ToolTipText     =   "Enter the company's STATE UNEMPLOYMENT ID."
      Top             =   2880
      Width           =   720
   End
   Begin VB.TextBox txtFax 
      Height          =   315
      Left            =   1680
      TabIndex        =   14
      ToolTipText     =   "Enter the company's FAX number."
      Top             =   2880
      Width           =   1368
   End
   Begin VB.TextBox txtSEIN 
      Height          =   315
      Left            =   4800
      TabIndex        =   18
      ToolTipText     =   "Enter the company's STATE EMPLOYER ID number."
      Top             =   2520
      Width           =   1080
   End
   Begin VB.TextBox txtTelephone 
      Height          =   315
      Left            =   1680
      TabIndex        =   12
      ToolTipText     =   "Enter the company's PHONE number."
      Top             =   2520
      Width           =   1368
   End
   Begin VB.TextBox txtFEIN 
      Height          =   315
      Left            =   4800
      TabIndex        =   16
      ToolTipText     =   "Enter the company's FEDERAL EMPLOYER ID number."
      Top             =   2160
      Width           =   1080
   End
   Begin VB.TextBox txtCountry 
      Height          =   315
      Left            =   1680
      TabIndex        =   10
      ToolTipText     =   "Enter the COUNTRY for the company's address."
      Top             =   2160
      Width           =   1368
   End
   Begin VB.ComboBox cboState 
      Appearance      =   0  'Flat
      Height          =   315
      ItemData        =   "Company Info Form.frx":0090
      Left            =   3832
      List            =   "Company Info Form.frx":013C
      TabIndex        =   6
      Text            =   "cboState"
      ToolTipText     =   "Click down arrow and select the STATE for the company's address."
      Top             =   1800
      Width           =   615
   End
   Begin VB.CheckBox chkETAFlag 
      BackColor       =   &H80000009&
      Caption         =   "Use Electronic &Time and Attendance"
      Height          =   195
      Left            =   1680
      TabIndex        =   27
      TabStop         =   0   'False
      Top             =   4320
      Width           =   3015
   End
   Begin VB.CheckBox chkUseAuditTrail 
      BackColor       =   &H80000009&
      Caption         =   "U&se Audit Trail"
      Height          =   195
      Left            =   1680
      TabIndex        =   26
      TabStop         =   0   'False
      Top             =   4080
      Width           =   1815
   End
   Begin VB.CommandButton cmdOK 
      Height          =   530
      Left            =   600
      Picture         =   "Company Info Form.frx":0220
      Style           =   1  'Graphical
      TabIndex        =   35
      TabStop         =   0   'False
      ToolTipText     =   "Close Form and SAVE all changes."
      Top             =   0
      Width           =   600
   End
   Begin VB.CommandButton cmdCancel 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Height          =   525
      Left            =   0
      MaskColor       =   &H00FFFFFF&
      Picture         =   "Company Info Form.frx":13EA
      Style           =   1  'Graphical
      TabIndex        =   34
      TabStop         =   0   'False
      ToolTipText     =   "Close Form WITHOUT saving changes."
      Top             =   0
      UseMaskColor    =   -1  'True
      Width           =   600
   End
   Begin VB.TextBox txtAddress2 
      Height          =   315
      Left            =   1680
      TabIndex        =   4
      ToolTipText     =   "Enter the second line of the company's ADDRESS."
      Top             =   1430
      Width           =   4200
   End
   Begin VB.Label lblPeachtreeVersionNo 
      BackColor       =   &H80000009&
      Height          =   194
      Left            =   5040
      TabIndex        =   37
      Top             =   240
      Width           =   855
   End
   Begin VB.Label lblCashBasis 
      BackColor       =   &H80000005&
      Height          =   195
      Left            =   4800
      TabIndex        =   36
      Top             =   3780
      Width           =   1095
   End
   Begin VB.Label lblCompanyName 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Company N&ame:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   360
      TabIndex        =   0
      Top             =   840
      Width           =   1170
   End
   Begin VB.Label lblPeachtreeVersion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Peachtree Version:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3495
      TabIndex        =   33
      Top             =   240
      Width           =   1350
   End
   Begin VB.Label lblETAUnknown 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "ETA Unknown:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3210
      TabIndex        =   30
      Top             =   5520
      Visible         =   0   'False
      Width           =   1230
   End
   Begin VB.Line Line 
      BorderWidth     =   2
      X1              =   1.167
      X2              =   4.083
      Y1              =   2.271
      Y2              =   2.271
   End
   Begin VB.Label lblETACompanyID 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Electronic Time and Attendance Co&mpany ID:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   1200
      TabIndex        =   28
      Top             =   4740
      Width           =   3240
   End
   Begin VB.Label lblCoOptions 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Company Options:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   240
      TabIndex        =   25
      Top             =   4080
      Width           =   1290
   End
   Begin VB.Label lblAccMethod 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Accounting Method:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3120
      TabIndex        =   32
      Top             =   3780
      Width           =   1440
   End
   Begin VB.Label lblPostMethod 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Posting Method:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   375
      TabIndex        =   23
      Top             =   3780
      Width           =   1155
   End
   Begin VB.Label lblFormOfBus 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Form of Business:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   285
      TabIndex        =   21
      Top             =   3420
      Width           =   1245
   End
   Begin VB.Label lblStateUnempID 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "State &Unemployment ID:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3360
      TabIndex        =   19
      Top             =   2940
      Width           =   1725
   End
   Begin VB.Label lblStateEmpID 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "State Employer &ID:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3360
      TabIndex        =   17
      Top             =   2580
      Width           =   1320
   End
   Begin VB.Label lblFedEmpID 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Fed Employer &ID:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   3360
      TabIndex        =   15
      Top             =   2220
      Width           =   1215
   End
   Begin VB.Label lblFax 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Fa&x:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   1230
      TabIndex        =   13
      Top             =   2940
      Width           =   300
   End
   Begin VB.Label lblTele 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Te&lephone:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   720
      TabIndex        =   11
      Top             =   2580
      Width           =   810
   End
   Begin VB.Label lblCountry 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "Country:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   945
      TabIndex        =   9
      Top             =   2220
      Width           =   585
   End
   Begin VB.Label lblCityStZip 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "City, ST &ZIP:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   600
      TabIndex        =   7
      Top             =   1860
      Width           =   900
   End
   Begin VB.Label lblAddress 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      Caption         =   "A&ddress:"
      ForeColor       =   &H80000008&
      Height          =   195
      Left            =   915
      TabIndex        =   2
      Top             =   1200
      Width           =   615
   End
End
Attribute VB_Name = "frmCompanyInfo"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'-------------------------------------------------------
' PawCOM example using Visual Basic to read and
' write to Peachtree data files using the PawCOM
' COM object.
'
' Version 1    1-29-00   By: Paul Hill
'--------------------------------------------------------

Option Explicit
    Public CompanyPath      As String  'Public so sub_cmdOK can see it.
'-----------------------------------------------------------------------

Private Sub Form_Load()
    Dim oBtrieve         As New PAW.Btrieve
    Dim myCompany        As New PAW.SelectCompany
    Dim oCompanyInfo     As New PAW.CompanyInformation
    Dim oPeachw          As New PAW.Peachw
    Dim Status           As Integer
    Dim PeachtreeVersion As Double

    myCompany.CompanyPath = oPeachw.Datapath & "bcs"
    Set oPeachw = Nothing
    myCompany.ShowOpen  'Displays Select Company from in PAWCOM
    CompanyPath = myCompany.CompanyPath 'Retrieves path selected from PAWCOM form
 
    Status = oBtrieve.Connect(CompanyPath) 'Try to connect to the company.
    If Status <> 0 Then
        MsgBox "Company not found."
        Unload frmCompanyInfo
        Exit Sub
    End If
                
    oBtrieve.CompanyPath = CompanyPath
    Status = oCompanyInfo.OpenFile

    If Status <> 0 Then
        MsgBox "Status = " & Status, vbCritical, "Open Company failed"
    Else
        Status = oCompanyInfo.StepFirst
        If Status <> 0 Then
            MsgBox "oCompanyInfo.Read returned status = " & Status, vbCritical, "Read failed"
        Else
            PeachtreeVersion = oCompanyInfo.Version
            Me.lblPeachtreeVersionNo.Caption = PeachtreeVersion
            Me.txtCompanyName = oCompanyInfo.CompanyName
            Me.txtAddress1 = oCompanyInfo.AddrLine1
            Me.txtAddress2 = oCompanyInfo.AddrLine2
            Me.txtCity = oCompanyInfo.AddrCity
            Me.cboState = oCompanyInfo.AddrState
            Me.txtZip = oCompanyInfo.AddrPostalCode
            Me.txtCountry = oCompanyInfo.AddrCountry
            Me.txtTelephone = oCompanyInfo.Telephone
            Me.txtFax = oCompanyInfo.Fax
            
            Me.cboBusinessTypeCode = oCompanyInfo.BusinessTypeCode
            Select Case oCompanyInfo.BusinessTypeCode
            Case 0
                Me.cboBusinessTypeCode = "Corporation"
            Case 1
                Me.cboBusinessTypeCode = "S Corporation"
            Case 2
                Me.cboBusinessTypeCode = "Partnership"
            Case 3
                Me.cboBusinessTypeCode = "Sole Proprietorship"
            Case 4
                Me.cboBusinessTypeCode = "Limited Liability Company"
            Case Else
                Me.cboBusinessTypeCode = ""
            End Select
            
            Me.txtFEIN = oCompanyInfo.FEIN
            Me.txtSEIN = oCompanyInfo.SEIN
            Me.txtSUIN = oCompanyInfo.SUIN
            
            Me.cboPostingMethod = oCompanyInfo.RealTime
            If oCompanyInfo.RealTime = True Then
                cboPostingMethod = "Real-Time"
            Else
                cboPostingMethod = "Batch"
            End If

            If oCompanyInfo.CashBasis = True Then
                Me.lblCashBasis.Caption = "Cash"
            Else
                Me.lblCashBasis.Caption = "Accrual"
            End If
            
            If Not (PeachtreeVersion = 7.02) Then
                Me.chkUseAuditTrail.Visible = False
            End If
            
            If oCompanyInfo.UseAuditTrail = True Then
                Me.chkUseAuditTrail.Value = vbChecked
            Else
                Me.chkUseAuditTrail.Value = vbUnchecked
            End If
            

            Me.chkETAFlag = oCompanyInfo.ETAFlag
            Me.txtETACompanyID = oCompanyInfo.ETACompanyID
            Me.txtETAUnknown = oCompanyInfo.ETAUnknown
            
'PAWCom does not seem to transfer oCompanyInfo.ETAFlag data always FALSE
   'Me.chkETAFlag.Value = vbChecked    'Test line
   'Me.chkETAFlag.Value = vbUnchecked  'Test line
   
           If Me.chkETAFlag.Value = vbChecked Then
                Me.lblETACompanyID.Visible = True
                Me.txtETACompanyID.Visible = True
                Me.lblETAUnknown.Visible = True
                Me.txtETAUnknown.Visible = True
            Else
                Me.lblETACompanyID.Visible = False
                Me.txtETACompanyID.Visible = False
                Me.lblETAUnknown.Visible = False
                Me.txtETAUnknown.Visible = False
            End If

            
        End If 'Status = 0 Read First If Else - End If
        Status = oCompanyInfo.CloseFile
        
        If Status <> 0 Then
            MsgBox "Status = " & Status, vbCritical, "CloseFile failed"
        End If
        
    End If 'Status = 0 Open File If Else - End If
    Set oCompanyInfo = Nothing

End Sub
'-----------------------------------------------------------------------

Private Sub chkETAFlag_Click()
        If Me.chkETAFlag.Value = vbChecked Then
            Me.lblETACompanyID.Visible = True
            Me.txtETACompanyID.Visible = True
            Me.lblETAUnknown.Visible = True
            Me.txtETAUnknown.Visible = True
        Else
            Me.lblETACompanyID.Visible = False
            Me.txtETACompanyID.Visible = False
            Me.lblETAUnknown.Visible = False
            Me.txtETAUnknown.Visible = False
        End If
End Sub
'-----------------------------------------------------------------------

Private Sub cmdOK_Click()
    Dim oBtrieve     As New PAW.Btrieve
    Dim oCompanyInfo As New PAW.CompanyInformation
    Dim Status           As Integer

    'Try to connect to the company.
    Status = oBtrieve.Connect(CompanyPath)
    If Status <> 0 Then
        MsgBox "Company not found."
    End If
        
    oBtrieve.CompanyPath = CompanyPath
    Status = oCompanyInfo.OpenFile

   ' Extra = True

    If Status <> 0 Then
        MsgBox "Status = " & Status, vbCritical, "Open Company failed"
    Else
        Status = oCompanyInfo.StepFirst
        If Status <> 0 Then
            MsgBox "oCompanyInfo.Read returned status = " & Status, vbCritical, "Read failed"
        Else
            oCompanyInfo.CompanyName = Me.txtCompanyName
            oCompanyInfo.AddrLine1 = Me.txtAddress1
            oCompanyInfo.AddrLine2 = IIf(IsNull(Me.txtAddress2), "", Me.txtAddress2)
            oCompanyInfo.AddrCity = Me.txtCity
            oCompanyInfo.AddrState = Me.cboState
            oCompanyInfo.AddrPostalCode = Me.txtZip
            oCompanyInfo.AddrCountry = Me.txtCountry
            oCompanyInfo.Telephone = Me.txtTelephone
            oCompanyInfo.Fax = Me.txtFax
            oCompanyInfo.FEIN = Me.txtFEIN
            oCompanyInfo.SEIN = Me.txtSEIN
            oCompanyInfo.SUIN = Me.txtSUIN
            
            Select Case Me.cboBusinessTypeCode
            
            Case "Corporation"
                oCompanyInfo.BusinessTypeCode = 0
            Case "S Corporation"
                oCompanyInfo.BusinessTypeCode = 1
            Case "Partnership"
                oCompanyInfo.BusinessTypeCode = 2
            Case "Sole Proprietorship"
                oCompanyInfo.BusinessTypeCode = 3
            Case "Limited Liability Company"
                oCompanyInfo.BusinessTypeCode = 4
            Case Else
                oCompanyInfo.BusinessTypeCode = 0
            End Select
            
            If Me.cboPostingMethod = "Real-Time" Then
                oCompanyInfo.RealTime = 1
            Else
                oCompanyInfo.RealTime = 0
            End If

            If Me.chkUseAuditTrail.Value = vbChecked Then
                oCompanyInfo.UseAuditTrail = True
            Else
                oCompanyInfo.UseAuditTrail = False
            End If
            
            If Me.chkETAFlag.Value = vbChecked Then
                oCompanyInfo.ETAFlag = True
                oCompanyInfo.ETACompanyID = Me.txtETACompanyID
            Else
                oCompanyInfo.ETAFlag = False
            End If
                  
            Status = oCompanyInfo.Update
            If Status <> 0 Then
                MsgBox "Status = " & Status, vbCritical, "Update failed"
            End If
        
            Status = oCompanyInfo.CloseFile
            If Status <> 0 Then
                MsgBox "Status = " & Status, vbCritical, "CloseFile failed"
            End If
        End If
    End If
            Status = oBtrieve.Reset
            If Status <> 0 Then
                MsgBox "Status = " & Status, vbInformation, "Btrieve Reset failed"
            End If
    
    Set oCompanyInfo = Nothing
    Set oBtrieve = Nothing
    
    Unload frmCompanyInfo
    Set frmCompanyInfo = Nothing
End Sub

'-----------------------------------------------------------------------
Private Sub cmdCancel_Click()
    Unload frmCompanyInfo
    Set frmCompanyInfo = Nothing
End Sub

'-----------------------------------------------------------------------
'-----------------------------------------------------------------------
' Note to programmers:
' The following is a list of how variable names map for Company
' Information Form between this Visal Basic program, The PawCOM Access
' Interface Tables and PawCOM object calls direct to Peachtree data files.
' As you test your program you can use the Access Tables to view your
' programs affects on Peachtree's data. You will have to refresh
' the Access Tables to see your changes if you leave PawCOM Access
' Interface open in the background.
'
'
' VISUAL BASIC            ACCESS                  PawCOM
'
'                         Index <---------------> oCompanyInfo.Index
' txtCompanyName <------> Name <----------------> oCompanyInfo.CompanyName
' txtAddress1 <---------> Address1 <------------> oCompanyInfo.AddrLine1
' txtAddress2 <---------> Address2 <------------> oCompanyInfo.AddrLine2
' txtCity <-------------> City <----------------> oCompanyInfo.AddrCity
' cboState <------------> State <---------------> oCompanyInfo.AddrState
' txtZip <--------------> Zip <-----------------> oCompanyInfo.AddrPostalCode
' txtCountry <----------> Country <-------------> oCompanyInfo.AddrCountry
' txtFEIN <-------------> FEIN <----------------> oCompanyInfo.FEIN
' txtSEIN <-------------> SEIN <----------------> oCompanyInfo.SEIN
' txtSUIN <-------------> SUIN <----------------> oCompanyInfo.SUIN
' lblCashBasis <--------> CashBasisFlag <-------> oCompanyInfo.CashBasis
' cboPostingMethod <----> RealTimeFlag <--------> oCompanyInfo.RealTime
' cboBusinessTypeCode <-> cboBusinessTypeCode <-> oCompanyInfo.BusinessTypeCode
'                         BusinessType <--------> oCompanyInfo.BusinessType
'                         SetupFlag1 <----------> oCompanyInfo.SetupFlag(1)
'                         SetupFlag2 <----------> oCompanyInfo.SetupFlag(2)
'                         SetupFlag3 <----------> oCompanyInfo.SetupFlag(3)
'                         SetupFlag4 <----------> oCompanyInfo.SetupFlag(4)
'                         SetupFlag5 <----------> oCompanyInfo.SetupFlag(5)
'                         SetupFlag6 <----------> oCompanyInfo.SetupFlag(6)
'                         SetupFlag7 <----------> oCompanyInfo.SetupFlag(7)
'                         SetupFlag8 <----------> oCompanyInfo.SetupFlag(8)
'                         SetupFlag9 <----------> oCompanyInfo.SetupFlag(9)
'                         SetupFlag10 <---------> oCompanyInfo.SetupFlag(10)
'                         SetupFlag11 <---------> oCompanyInfo.SetupFlag(11)
'                         SetupFlag12 <---------> oCompanyInfo.SetupFlag(12)
'                         SetupFlag13 <---------> oCompanyInfo.SetupFlag(13)
'                         SetupFlag14 <---------> oCompanyInfo.SetupFlag(14)
'                         SetupFlag15 <---------> oCompanyInfo.SetupFlag(15)
'                         SetupFlag16 <---------> oCompanyInfo.SetupFlag(16)
'                         SetupFlag17 <---------> oCompanyInfo.SetupFlag(17)
'                         SetupFlag18 <---------> oCompanyInfo.SetupFlag(18)
'                         SetupFlag19 <---------> oCompanyInfo.SetupFlag(19)
' txtTelephone <--------> Telephone <-----------> oCompanyInfo.Telephone
' txtFax <--------------> Fax <-----------------> oCompanyInfo.Fax
' chkUseAuditTrail <----> UseAuditTrail <-------> oCompanyInfo.UseAuditTrail
' chkETAFlag <----------> ETAFlag <-------------> oCompanyInfo.ETAFlag
' txtETACompanyID <-----> ETACompanyID <--------> oCompanyInfo.ETACompanyID
' txtETAUnknown <-------> ETAUnknown <----------> oCompanyInfo.ETAUnknown
'                         ActualLength <--------> oCompanyInfo.ActualLength
'                         ExpectedLength <------> oCompanyInfo.StructureLength

