Option Strict Off
Option Explicit On
Friend Class frmCompanyInfo
	Inherits System.Windows.Forms.Form
#Region "Windows Form Designer generated code "
	Public Sub New()
		MyBase.New()
		If m_vb6FormDefInstance Is Nothing Then
			If m_InitializingDefInstance Then
				m_vb6FormDefInstance = Me
			Else
				Try 
					'For the start-up form, the first instance created is the default instance.
					If System.Reflection.Assembly.GetExecutingAssembly.EntryPoint.DeclaringType Is Me.GetType Then
						m_vb6FormDefInstance = Me
					End If
				Catch
				End Try
			End If
		End If
		'This call is required by the Windows Form Designer.
		InitializeComponent()
	End Sub
	'Form overrides dispose to clean up the component list.
	Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
		If Disposing Then
			If Not components Is Nothing Then
				components.Dispose()
			End If
		End If
		MyBase.Dispose(Disposing)
	End Sub
	'Required by the Windows Form Designer
	Private components As System.ComponentModel.IContainer
	Public ToolTip1 As System.Windows.Forms.ToolTip
	Public WithEvents cboBusinessTypeCode As System.Windows.Forms.ComboBox
	Public WithEvents txtZip As System.Windows.Forms.TextBox
	Public WithEvents txtCity As System.Windows.Forms.TextBox
	Public WithEvents txtAddress1 As System.Windows.Forms.TextBox
	Public WithEvents txtCompanyName As System.Windows.Forms.TextBox
	Public WithEvents txtETAUnknown As System.Windows.Forms.TextBox
	Public WithEvents cboPostingMethod As System.Windows.Forms.ComboBox
	Public WithEvents txtETACompanyID As System.Windows.Forms.TextBox
	Public WithEvents txtSUIN As System.Windows.Forms.TextBox
	Public WithEvents txtFax As System.Windows.Forms.TextBox
	Public WithEvents txtSEIN As System.Windows.Forms.TextBox
	Public WithEvents txtTelephone As System.Windows.Forms.TextBox
	Public WithEvents txtFEIN As System.Windows.Forms.TextBox
	Public WithEvents txtCountry As System.Windows.Forms.TextBox
	Public WithEvents cboState As System.Windows.Forms.ComboBox
	Public WithEvents chkETAFlag As System.Windows.Forms.CheckBox
	Public WithEvents chkUseAuditTrail As System.Windows.Forms.CheckBox
	Public WithEvents cmdOK As System.Windows.Forms.Button
	Public WithEvents cmdCancel As System.Windows.Forms.Button
	Public WithEvents txtAddress2 As System.Windows.Forms.TextBox
	Public WithEvents lblPeachtreeVersionNo As System.Windows.Forms.Label
	Public WithEvents lblCashBasis As System.Windows.Forms.Label
	Public WithEvents lblCompanyName As System.Windows.Forms.Label
	Public WithEvents lblPeachtreeVersion As System.Windows.Forms.Label
	Public WithEvents lblETAUnknown As System.Windows.Forms.Label
	Public WithEvents Line As System.Windows.Forms.Label
	Public WithEvents lblETACompanyID As System.Windows.Forms.Label
	Public WithEvents lblCoOptions As System.Windows.Forms.Label
	Public WithEvents lblAccMethod As System.Windows.Forms.Label
	Public WithEvents lblPostMethod As System.Windows.Forms.Label
	Public WithEvents lblFormOfBus As System.Windows.Forms.Label
	Public WithEvents lblStateUnempID As System.Windows.Forms.Label
	Public WithEvents lblStateEmpID As System.Windows.Forms.Label
	Public WithEvents lblFedEmpID As System.Windows.Forms.Label
	Public WithEvents lblFax As System.Windows.Forms.Label
	Public WithEvents lblTele As System.Windows.Forms.Label
	Public WithEvents lblCountry As System.Windows.Forms.Label
	Public WithEvents lblCityStZip As System.Windows.Forms.Label
	Public WithEvents lblAddress As System.Windows.Forms.Label
	'NOTE: The following procedure is required by the Windows Form Designer
	'It can be modified using the Windows Form Designer.
	'Do not modify it using the code editor.
	<System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Me.components = New System.ComponentModel.Container()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(frmCompanyInfo))
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(Me.components)
        Me.cboBusinessTypeCode = New System.Windows.Forms.ComboBox()
        Me.txtZip = New System.Windows.Forms.TextBox()
        Me.txtCity = New System.Windows.Forms.TextBox()
        Me.txtAddress1 = New System.Windows.Forms.TextBox()
        Me.txtCompanyName = New System.Windows.Forms.TextBox()
        Me.cboPostingMethod = New System.Windows.Forms.ComboBox()
        Me.txtSUIN = New System.Windows.Forms.TextBox()
        Me.txtFax = New System.Windows.Forms.TextBox()
        Me.txtSEIN = New System.Windows.Forms.TextBox()
        Me.txtTelephone = New System.Windows.Forms.TextBox()
        Me.txtFEIN = New System.Windows.Forms.TextBox()
        Me.txtCountry = New System.Windows.Forms.TextBox()
        Me.cboState = New System.Windows.Forms.ComboBox()
        Me.cmdOK = New System.Windows.Forms.Button()
        Me.cmdCancel = New System.Windows.Forms.Button()
        Me.txtAddress2 = New System.Windows.Forms.TextBox()
        Me.txtETAUnknown = New System.Windows.Forms.TextBox()
        Me.txtETACompanyID = New System.Windows.Forms.TextBox()
        Me.chkETAFlag = New System.Windows.Forms.CheckBox()
        Me.chkUseAuditTrail = New System.Windows.Forms.CheckBox()
        Me.lblPeachtreeVersionNo = New System.Windows.Forms.Label()
        Me.lblCashBasis = New System.Windows.Forms.Label()
        Me.lblCompanyName = New System.Windows.Forms.Label()
        Me.lblPeachtreeVersion = New System.Windows.Forms.Label()
        Me.lblETAUnknown = New System.Windows.Forms.Label()
        Me.Line = New System.Windows.Forms.Label()
        Me.lblETACompanyID = New System.Windows.Forms.Label()
        Me.lblCoOptions = New System.Windows.Forms.Label()
        Me.lblAccMethod = New System.Windows.Forms.Label()
        Me.lblPostMethod = New System.Windows.Forms.Label()
        Me.lblFormOfBus = New System.Windows.Forms.Label()
        Me.lblStateUnempID = New System.Windows.Forms.Label()
        Me.lblStateEmpID = New System.Windows.Forms.Label()
        Me.lblFedEmpID = New System.Windows.Forms.Label()
        Me.lblFax = New System.Windows.Forms.Label()
        Me.lblTele = New System.Windows.Forms.Label()
        Me.lblCountry = New System.Windows.Forms.Label()
        Me.lblCityStZip = New System.Windows.Forms.Label()
        Me.lblAddress = New System.Windows.Forms.Label()
        Me.SuspendLayout()
        '
        'cboBusinessTypeCode
        '
        Me.cboBusinessTypeCode.BackColor = System.Drawing.SystemColors.Window
        Me.cboBusinessTypeCode.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboBusinessTypeCode.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboBusinessTypeCode.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboBusinessTypeCode.Items.AddRange(New Object() {"Corporation", "S Corporation", "Partnership", "Sole Proprietorship", "Limited Liability Company"})
        Me.cboBusinessTypeCode.Location = New System.Drawing.Point(112, 224)
        Me.cboBusinessTypeCode.Name = "cboBusinessTypeCode"
        Me.cboBusinessTypeCode.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboBusinessTypeCode.Size = New System.Drawing.Size(201, 22)
        Me.cboBusinessTypeCode.TabIndex = 22
        Me.cboBusinessTypeCode.Text = "cbo"
        Me.ToolTip1.SetToolTip(Me.cboBusinessTypeCode, "Click down arrow and select BUSINESS TYPE from list.")
        '
        'txtZip
        '
        Me.txtZip.AcceptsReturn = True
        Me.txtZip.AutoSize = False
        Me.txtZip.BackColor = System.Drawing.SystemColors.Window
        Me.txtZip.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtZip.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtZip.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtZip.Location = New System.Drawing.Point(301, 120)
        Me.txtZip.MaxLength = 0
        Me.txtZip.Name = "txtZip"
        Me.txtZip.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtZip.Size = New System.Drawing.Size(92, 21)
        Me.txtZip.TabIndex = 8
        Me.txtZip.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtZip, "Enter the ZIP code for the company's address.")
        '
        'txtCity
        '
        Me.txtCity.AcceptsReturn = True
        Me.txtCity.AutoSize = False
        Me.txtCity.BackColor = System.Drawing.SystemColors.Window
        Me.txtCity.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCity.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCity.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtCity.Location = New System.Drawing.Point(112, 120)
        Me.txtCity.MaxLength = 0
        Me.txtCity.Name = "txtCity"
        Me.txtCity.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCity.Size = New System.Drawing.Size(140, 21)
        Me.txtCity.TabIndex = 5
        Me.txtCity.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtCity, "Enter the CITY for the company's address.")
        '
        'txtAddress1
        '
        Me.txtAddress1.AcceptsReturn = True
        Me.txtAddress1.AutoSize = False
        Me.txtAddress1.BackColor = System.Drawing.SystemColors.Window
        Me.txtAddress1.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtAddress1.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtAddress1.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtAddress1.Location = New System.Drawing.Point(112, 76)
        Me.txtAddress1.MaxLength = 0
        Me.txtAddress1.Name = "txtAddress1"
        Me.txtAddress1.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtAddress1.Size = New System.Drawing.Size(280, 21)
        Me.txtAddress1.TabIndex = 3
        Me.txtAddress1.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtAddress1, "Enter the first line of the company's ADDRESS.")
        '
        'txtCompanyName
        '
        Me.txtCompanyName.AcceptsReturn = True
        Me.txtCompanyName.AutoSize = False
        Me.txtCompanyName.BackColor = System.Drawing.SystemColors.Window
        Me.txtCompanyName.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCompanyName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCompanyName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtCompanyName.Location = New System.Drawing.Point(112, 52)
        Me.txtCompanyName.MaxLength = 0
        Me.txtCompanyName.Name = "txtCompanyName"
        Me.txtCompanyName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCompanyName.Size = New System.Drawing.Size(280, 21)
        Me.txtCompanyName.TabIndex = 1
        Me.txtCompanyName.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtCompanyName, "Enter the company's NAME.")
        '
        'cboPostingMethod
        '
        Me.cboPostingMethod.BackColor = System.Drawing.SystemColors.Window
        Me.cboPostingMethod.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboPostingMethod.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboPostingMethod.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboPostingMethod.Items.AddRange(New Object() {"Batch", "Real-Time"})
        Me.cboPostingMethod.Location = New System.Drawing.Point(112, 248)
        Me.cboPostingMethod.Name = "cboPostingMethod"
        Me.cboPostingMethod.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboPostingMethod.Size = New System.Drawing.Size(88, 22)
        Me.cboPostingMethod.TabIndex = 24
        Me.cboPostingMethod.Text = "cboPostingMethod"
        Me.ToolTip1.SetToolTip(Me.cboPostingMethod, "Click down arrow and select POSTING METHOD from list.")
        '
        'txtSUIN
        '
        Me.txtSUIN.AcceptsReturn = True
        Me.txtSUIN.AutoSize = False
        Me.txtSUIN.BackColor = System.Drawing.SystemColors.Window
        Me.txtSUIN.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtSUIN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtSUIN.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtSUIN.Location = New System.Drawing.Point(344, 192)
        Me.txtSUIN.MaxLength = 0
        Me.txtSUIN.Name = "txtSUIN"
        Me.txtSUIN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtSUIN.Size = New System.Drawing.Size(48, 21)
        Me.txtSUIN.TabIndex = 20
        Me.txtSUIN.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtSUIN, "Enter the company's STATE UNEMPLOYMENT ID.")
        '
        'txtFax
        '
        Me.txtFax.AcceptsReturn = True
        Me.txtFax.AutoSize = False
        Me.txtFax.BackColor = System.Drawing.SystemColors.Window
        Me.txtFax.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFax.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFax.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFax.Location = New System.Drawing.Point(112, 192)
        Me.txtFax.MaxLength = 0
        Me.txtFax.Name = "txtFax"
        Me.txtFax.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFax.Size = New System.Drawing.Size(92, 21)
        Me.txtFax.TabIndex = 14
        Me.txtFax.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtFax, "Enter the company's FAX number.")
        '
        'txtSEIN
        '
        Me.txtSEIN.AcceptsReturn = True
        Me.txtSEIN.AutoSize = False
        Me.txtSEIN.BackColor = System.Drawing.SystemColors.Window
        Me.txtSEIN.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtSEIN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtSEIN.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtSEIN.Location = New System.Drawing.Point(320, 168)
        Me.txtSEIN.MaxLength = 0
        Me.txtSEIN.Name = "txtSEIN"
        Me.txtSEIN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtSEIN.Size = New System.Drawing.Size(72, 21)
        Me.txtSEIN.TabIndex = 18
        Me.txtSEIN.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtSEIN, "Enter the company's STATE EMPLOYER ID number.")
        '
        'txtTelephone
        '
        Me.txtTelephone.AcceptsReturn = True
        Me.txtTelephone.AutoSize = False
        Me.txtTelephone.BackColor = System.Drawing.SystemColors.Window
        Me.txtTelephone.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtTelephone.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtTelephone.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtTelephone.Location = New System.Drawing.Point(112, 168)
        Me.txtTelephone.MaxLength = 0
        Me.txtTelephone.Name = "txtTelephone"
        Me.txtTelephone.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtTelephone.Size = New System.Drawing.Size(92, 21)
        Me.txtTelephone.TabIndex = 12
        Me.txtTelephone.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtTelephone, "Enter the company's PHONE number.")
        '
        'txtFEIN
        '
        Me.txtFEIN.AcceptsReturn = True
        Me.txtFEIN.AutoSize = False
        Me.txtFEIN.BackColor = System.Drawing.SystemColors.Window
        Me.txtFEIN.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtFEIN.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtFEIN.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtFEIN.Location = New System.Drawing.Point(320, 144)
        Me.txtFEIN.MaxLength = 0
        Me.txtFEIN.Name = "txtFEIN"
        Me.txtFEIN.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtFEIN.Size = New System.Drawing.Size(72, 21)
        Me.txtFEIN.TabIndex = 16
        Me.txtFEIN.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtFEIN, "Enter the company's FEDERAL EMPLOYER ID number.")
        '
        'txtCountry
        '
        Me.txtCountry.AcceptsReturn = True
        Me.txtCountry.AutoSize = False
        Me.txtCountry.BackColor = System.Drawing.SystemColors.Window
        Me.txtCountry.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtCountry.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtCountry.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtCountry.Location = New System.Drawing.Point(112, 144)
        Me.txtCountry.MaxLength = 0
        Me.txtCountry.Name = "txtCountry"
        Me.txtCountry.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtCountry.Size = New System.Drawing.Size(92, 21)
        Me.txtCountry.TabIndex = 10
        Me.txtCountry.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtCountry, "Enter the COUNTRY for the company's address.")
        '
        'cboState
        '
        Me.cboState.BackColor = System.Drawing.SystemColors.Window
        Me.cboState.Cursor = System.Windows.Forms.Cursors.Default
        Me.cboState.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cboState.ForeColor = System.Drawing.SystemColors.WindowText
        Me.cboState.Items.AddRange(New Object() {"AA", "AE", "AK", "AL", "AP", "AR", "AZ", "CA", "CO", "CT", "DC", "DE", "FL", "GA", "HI", "IA", "ID", "IL", "IN", "KS", "KY", "LA", "MA", "MD", "ME", "MI", "MN", "MO", "MS", "MT", "NC", "ND", "NE", "NH", "NJ", "NM", "NV", "NY", "OH", "OK", "OR", "PA", "PR", "RI", "SC", "SD", "TN", "TX", "UT", "VA", "VI", "VT", "WA", "WI", "WV", "WY"})
        Me.cboState.Location = New System.Drawing.Point(256, 120)
        Me.cboState.Name = "cboState"
        Me.cboState.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cboState.Size = New System.Drawing.Size(41, 22)
        Me.cboState.TabIndex = 6
        Me.cboState.Text = "cboState"
        Me.ToolTip1.SetToolTip(Me.cboState, "Click down arrow and select the STATE for the company's address.")
        '
        'cmdOK
        '
        Me.cmdOK.BackColor = System.Drawing.SystemColors.Control
        Me.cmdOK.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdOK.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdOK.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdOK.Image = CType(resources.GetObject("cmdOK.Image"), System.Drawing.Bitmap)
        Me.cmdOK.Location = New System.Drawing.Point(40, 0)
        Me.cmdOK.Name = "cmdOK"
        Me.cmdOK.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdOK.Size = New System.Drawing.Size(40, 35)
        Me.cmdOK.TabIndex = 35
        Me.cmdOK.TabStop = False
        Me.cmdOK.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.ToolTip1.SetToolTip(Me.cmdOK, "Close Form and SAVE all changes.")
        '
        'cmdCancel
        '
        Me.cmdCancel.BackColor = System.Drawing.Color.FromArgb(CType(192, Byte), CType(192, Byte), CType(192, Byte))
        Me.cmdCancel.Cursor = System.Windows.Forms.Cursors.Default
        Me.cmdCancel.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.cmdCancel.ForeColor = System.Drawing.SystemColors.ControlText
        Me.cmdCancel.Image = CType(resources.GetObject("cmdCancel.Image"), System.Drawing.Bitmap)
        Me.cmdCancel.Name = "cmdCancel"
        Me.cmdCancel.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.cmdCancel.Size = New System.Drawing.Size(40, 35)
        Me.cmdCancel.TabIndex = 34
        Me.cmdCancel.TabStop = False
        Me.cmdCancel.TextAlign = System.Drawing.ContentAlignment.BottomCenter
        Me.ToolTip1.SetToolTip(Me.cmdCancel, "Close Form WITHOUT saving changes.")
        '
        'txtAddress2
        '
        Me.txtAddress2.AcceptsReturn = True
        Me.txtAddress2.AutoSize = False
        Me.txtAddress2.BackColor = System.Drawing.SystemColors.Window
        Me.txtAddress2.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtAddress2.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtAddress2.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtAddress2.Location = New System.Drawing.Point(112, 96)
        Me.txtAddress2.MaxLength = 0
        Me.txtAddress2.Name = "txtAddress2"
        Me.txtAddress2.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtAddress2.Size = New System.Drawing.Size(280, 21)
        Me.txtAddress2.TabIndex = 4
        Me.txtAddress2.Text = ""
        Me.ToolTip1.SetToolTip(Me.txtAddress2, "Enter the second line of the company's ADDRESS.")
        '
        'txtETAUnknown
        '
        Me.txtETAUnknown.AcceptsReturn = True
        Me.txtETAUnknown.AutoSize = False
        Me.txtETAUnknown.BackColor = System.Drawing.SystemColors.Window
        Me.txtETAUnknown.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtETAUnknown.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtETAUnknown.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtETAUnknown.Location = New System.Drawing.Point(301, 368)
        Me.txtETAUnknown.MaxLength = 0
        Me.txtETAUnknown.Name = "txtETAUnknown"
        Me.txtETAUnknown.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtETAUnknown.Size = New System.Drawing.Size(91, 21)
        Me.txtETAUnknown.TabIndex = 31
        Me.txtETAUnknown.Text = "txtETAUnknown"
        Me.txtETAUnknown.Visible = False
        '
        'txtETACompanyID
        '
        Me.txtETACompanyID.AcceptsReturn = True
        Me.txtETACompanyID.AutoSize = False
        Me.txtETACompanyID.BackColor = System.Drawing.SystemColors.Window
        Me.txtETACompanyID.Cursor = System.Windows.Forms.Cursors.IBeam
        Me.txtETACompanyID.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.txtETACompanyID.ForeColor = System.Drawing.SystemColors.WindowText
        Me.txtETACompanyID.Location = New System.Drawing.Point(304, 312)
        Me.txtETACompanyID.MaxLength = 0
        Me.txtETACompanyID.Name = "txtETACompanyID"
        Me.txtETACompanyID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.txtETACompanyID.Size = New System.Drawing.Size(91, 21)
        Me.txtETACompanyID.TabIndex = 29
        Me.txtETACompanyID.Text = "txtETACompanyID"
        '
        'chkETAFlag
        '
        Me.chkETAFlag.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.chkETAFlag.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkETAFlag.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkETAFlag.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkETAFlag.Location = New System.Drawing.Point(112, 288)
        Me.chkETAFlag.Name = "chkETAFlag"
        Me.chkETAFlag.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkETAFlag.Size = New System.Drawing.Size(201, 13)
        Me.chkETAFlag.TabIndex = 27
        Me.chkETAFlag.TabStop = False
        Me.chkETAFlag.Text = "Use Electronic &Time and Attendance"
        '
        'chkUseAuditTrail
        '
        Me.chkUseAuditTrail.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.chkUseAuditTrail.Cursor = System.Windows.Forms.Cursors.Default
        Me.chkUseAuditTrail.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.chkUseAuditTrail.ForeColor = System.Drawing.SystemColors.ControlText
        Me.chkUseAuditTrail.Location = New System.Drawing.Point(112, 272)
        Me.chkUseAuditTrail.Name = "chkUseAuditTrail"
        Me.chkUseAuditTrail.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.chkUseAuditTrail.Size = New System.Drawing.Size(121, 13)
        Me.chkUseAuditTrail.TabIndex = 26
        Me.chkUseAuditTrail.TabStop = False
        Me.chkUseAuditTrail.Text = "U&se Audit Trail"
        '
        'lblPeachtreeVersionNo
        '
        Me.lblPeachtreeVersionNo.BackColor = System.Drawing.SystemColors.ActiveCaptionText
        Me.lblPeachtreeVersionNo.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblPeachtreeVersionNo.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPeachtreeVersionNo.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblPeachtreeVersionNo.Location = New System.Drawing.Point(336, 16)
        Me.lblPeachtreeVersionNo.Name = "lblPeachtreeVersionNo"
        Me.lblPeachtreeVersionNo.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblPeachtreeVersionNo.Size = New System.Drawing.Size(57, 13)
        Me.lblPeachtreeVersionNo.TabIndex = 37
        '
        'lblCashBasis
        '
        Me.lblCashBasis.BackColor = System.Drawing.SystemColors.Window
        Me.lblCashBasis.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCashBasis.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCashBasis.ForeColor = System.Drawing.SystemColors.ControlText
        Me.lblCashBasis.Location = New System.Drawing.Point(320, 252)
        Me.lblCashBasis.Name = "lblCashBasis"
        Me.lblCashBasis.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCashBasis.Size = New System.Drawing.Size(73, 13)
        Me.lblCashBasis.TabIndex = 36
        '
        'lblCompanyName
        '
        Me.lblCompanyName.AutoSize = True
        Me.lblCompanyName.BackColor = System.Drawing.SystemColors.Window
        Me.lblCompanyName.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCompanyName.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCompanyName.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblCompanyName.Location = New System.Drawing.Point(24, 56)
        Me.lblCompanyName.Name = "lblCompanyName"
        Me.lblCompanyName.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCompanyName.Size = New System.Drawing.Size(86, 13)
        Me.lblCompanyName.TabIndex = 0
        Me.lblCompanyName.Text = "Company N&ame:"
        Me.lblCompanyName.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblPeachtreeVersion
        '
        Me.lblPeachtreeVersion.AutoSize = True
        Me.lblPeachtreeVersion.BackColor = System.Drawing.SystemColors.Window
        Me.lblPeachtreeVersion.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblPeachtreeVersion.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPeachtreeVersion.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblPeachtreeVersion.Location = New System.Drawing.Point(233, 16)
        Me.lblPeachtreeVersion.Name = "lblPeachtreeVersion"
        Me.lblPeachtreeVersion.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblPeachtreeVersion.Size = New System.Drawing.Size(97, 13)
        Me.lblPeachtreeVersion.TabIndex = 33
        Me.lblPeachtreeVersion.Text = "Peachtree Version:"
        Me.lblPeachtreeVersion.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblETAUnknown
        '
        Me.lblETAUnknown.AutoSize = True
        Me.lblETAUnknown.BackColor = System.Drawing.SystemColors.Window
        Me.lblETAUnknown.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblETAUnknown.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblETAUnknown.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblETAUnknown.Location = New System.Drawing.Point(214, 368)
        Me.lblETAUnknown.Name = "lblETAUnknown"
        Me.lblETAUnknown.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblETAUnknown.Size = New System.Drawing.Size(77, 13)
        Me.lblETAUnknown.TabIndex = 30
        Me.lblETAUnknown.Text = "ETA Unknown:"
        Me.lblETAUnknown.TextAlign = System.Drawing.ContentAlignment.TopRight
        Me.lblETAUnknown.Visible = False
        '
        'Line
        '
        Me.Line.BackColor = System.Drawing.SystemColors.WindowText
        Me.Line.Location = New System.Drawing.Point(112, 218)
        Me.Line.Name = "Line"
        Me.Line.Size = New System.Drawing.Size(280, 1)
        Me.Line.TabIndex = 38
        '
        'lblETACompanyID
        '
        Me.lblETACompanyID.AutoSize = True
        Me.lblETACompanyID.BackColor = System.Drawing.SystemColors.Window
        Me.lblETACompanyID.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblETACompanyID.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblETACompanyID.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblETACompanyID.Location = New System.Drawing.Point(80, 316)
        Me.lblETACompanyID.Name = "lblETACompanyID"
        Me.lblETACompanyID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblETACompanyID.Size = New System.Drawing.Size(227, 13)
        Me.lblETACompanyID.TabIndex = 28
        Me.lblETACompanyID.Text = "Electronic Time and Attendance Co&mpany ID:"
        Me.lblETACompanyID.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblCoOptions
        '
        Me.lblCoOptions.AutoSize = True
        Me.lblCoOptions.BackColor = System.Drawing.SystemColors.Window
        Me.lblCoOptions.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCoOptions.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCoOptions.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblCoOptions.Location = New System.Drawing.Point(16, 272)
        Me.lblCoOptions.Name = "lblCoOptions"
        Me.lblCoOptions.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCoOptions.Size = New System.Drawing.Size(95, 13)
        Me.lblCoOptions.TabIndex = 25
        Me.lblCoOptions.Text = "Company Options:"
        Me.lblCoOptions.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblAccMethod
        '
        Me.lblAccMethod.AutoSize = True
        Me.lblAccMethod.BackColor = System.Drawing.SystemColors.Window
        Me.lblAccMethod.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblAccMethod.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblAccMethod.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblAccMethod.Location = New System.Drawing.Point(208, 252)
        Me.lblAccMethod.Name = "lblAccMethod"
        Me.lblAccMethod.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblAccMethod.Size = New System.Drawing.Size(101, 13)
        Me.lblAccMethod.TabIndex = 32
        Me.lblAccMethod.Text = "Accounting Method:"
        Me.lblAccMethod.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblPostMethod
        '
        Me.lblPostMethod.AutoSize = True
        Me.lblPostMethod.BackColor = System.Drawing.SystemColors.Window
        Me.lblPostMethod.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblPostMethod.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblPostMethod.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblPostMethod.Location = New System.Drawing.Point(25, 252)
        Me.lblPostMethod.Name = "lblPostMethod"
        Me.lblPostMethod.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblPostMethod.Size = New System.Drawing.Size(83, 13)
        Me.lblPostMethod.TabIndex = 23
        Me.lblPostMethod.Text = "Posting Method:"
        Me.lblPostMethod.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblFormOfBus
        '
        Me.lblFormOfBus.AutoSize = True
        Me.lblFormOfBus.BackColor = System.Drawing.SystemColors.Window
        Me.lblFormOfBus.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFormOfBus.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFormOfBus.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblFormOfBus.Location = New System.Drawing.Point(19, 228)
        Me.lblFormOfBus.Name = "lblFormOfBus"
        Me.lblFormOfBus.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFormOfBus.Size = New System.Drawing.Size(93, 13)
        Me.lblFormOfBus.TabIndex = 21
        Me.lblFormOfBus.Text = "Form of Business:"
        Me.lblFormOfBus.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblStateUnempID
        '
        Me.lblStateUnempID.AutoSize = True
        Me.lblStateUnempID.BackColor = System.Drawing.SystemColors.Window
        Me.lblStateUnempID.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblStateUnempID.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblStateUnempID.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblStateUnempID.Location = New System.Drawing.Point(224, 196)
        Me.lblStateUnempID.Name = "lblStateUnempID"
        Me.lblStateUnempID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblStateUnempID.Size = New System.Drawing.Size(124, 13)
        Me.lblStateUnempID.TabIndex = 19
        Me.lblStateUnempID.Text = "State &Unemployment ID:"
        Me.lblStateUnempID.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblStateEmpID
        '
        Me.lblStateEmpID.AutoSize = True
        Me.lblStateEmpID.BackColor = System.Drawing.SystemColors.Window
        Me.lblStateEmpID.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblStateEmpID.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblStateEmpID.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblStateEmpID.Location = New System.Drawing.Point(224, 172)
        Me.lblStateEmpID.Name = "lblStateEmpID"
        Me.lblStateEmpID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblStateEmpID.Size = New System.Drawing.Size(96, 13)
        Me.lblStateEmpID.TabIndex = 17
        Me.lblStateEmpID.Text = "State Employer &ID:"
        Me.lblStateEmpID.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblFedEmpID
        '
        Me.lblFedEmpID.AutoSize = True
        Me.lblFedEmpID.BackColor = System.Drawing.SystemColors.Window
        Me.lblFedEmpID.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFedEmpID.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFedEmpID.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblFedEmpID.Location = New System.Drawing.Point(224, 148)
        Me.lblFedEmpID.Name = "lblFedEmpID"
        Me.lblFedEmpID.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFedEmpID.Size = New System.Drawing.Size(90, 13)
        Me.lblFedEmpID.TabIndex = 15
        Me.lblFedEmpID.Text = "Fed Employer &ID:"
        Me.lblFedEmpID.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblFax
        '
        Me.lblFax.AutoSize = True
        Me.lblFax.BackColor = System.Drawing.SystemColors.Window
        Me.lblFax.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblFax.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblFax.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblFax.Location = New System.Drawing.Point(82, 196)
        Me.lblFax.Name = "lblFax"
        Me.lblFax.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblFax.Size = New System.Drawing.Size(25, 13)
        Me.lblFax.TabIndex = 13
        Me.lblFax.Text = "Fa&x:"
        Me.lblFax.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblTele
        '
        Me.lblTele.AutoSize = True
        Me.lblTele.BackColor = System.Drawing.SystemColors.Window
        Me.lblTele.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblTele.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblTele.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblTele.Location = New System.Drawing.Point(48, 172)
        Me.lblTele.Name = "lblTele"
        Me.lblTele.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblTele.Size = New System.Drawing.Size(59, 13)
        Me.lblTele.TabIndex = 11
        Me.lblTele.Text = "Te&lephone:"
        Me.lblTele.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblCountry
        '
        Me.lblCountry.AutoSize = True
        Me.lblCountry.BackColor = System.Drawing.SystemColors.Window
        Me.lblCountry.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCountry.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCountry.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblCountry.Location = New System.Drawing.Point(63, 148)
        Me.lblCountry.Name = "lblCountry"
        Me.lblCountry.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCountry.Size = New System.Drawing.Size(46, 13)
        Me.lblCountry.TabIndex = 9
        Me.lblCountry.Text = "Country:"
        Me.lblCountry.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblCityStZip
        '
        Me.lblCityStZip.AutoSize = True
        Me.lblCityStZip.BackColor = System.Drawing.SystemColors.Window
        Me.lblCityStZip.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblCityStZip.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblCityStZip.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblCityStZip.Location = New System.Drawing.Point(40, 124)
        Me.lblCityStZip.Name = "lblCityStZip"
        Me.lblCityStZip.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblCityStZip.Size = New System.Drawing.Size(66, 13)
        Me.lblCityStZip.TabIndex = 7
        Me.lblCityStZip.Text = "City, ST &ZIP:"
        Me.lblCityStZip.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'lblAddress
        '
        Me.lblAddress.AutoSize = True
        Me.lblAddress.BackColor = System.Drawing.SystemColors.Window
        Me.lblAddress.Cursor = System.Windows.Forms.Cursors.Default
        Me.lblAddress.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.lblAddress.ForeColor = System.Drawing.SystemColors.WindowText
        Me.lblAddress.Location = New System.Drawing.Point(61, 80)
        Me.lblAddress.Name = "lblAddress"
        Me.lblAddress.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.lblAddress.Size = New System.Drawing.Size(47, 13)
        Me.lblAddress.TabIndex = 2
        Me.lblAddress.Text = "A&ddress:"
        Me.lblAddress.TextAlign = System.Drawing.ContentAlignment.TopRight
        '
        'frmCompanyInfo
        '
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackColor = System.Drawing.SystemColors.Window
        Me.ClientSize = New System.Drawing.Size(417, 344)
        Me.Controls.AddRange(New System.Windows.Forms.Control() {Me.cboBusinessTypeCode, Me.txtZip, Me.txtCity, Me.txtAddress1, Me.txtCompanyName, Me.txtETAUnknown, Me.cboPostingMethod, Me.txtETACompanyID, Me.txtSUIN, Me.txtFax, Me.txtSEIN, Me.txtTelephone, Me.txtFEIN, Me.txtCountry, Me.cboState, Me.chkETAFlag, Me.chkUseAuditTrail, Me.cmdOK, Me.cmdCancel, Me.txtAddress2, Me.lblPeachtreeVersionNo, Me.lblCashBasis, Me.lblCompanyName, Me.lblPeachtreeVersion, Me.lblETAUnknown, Me.Line, Me.lblETACompanyID, Me.lblCoOptions, Me.lblAccMethod, Me.lblPostMethod, Me.lblFormOfBus, Me.lblStateUnempID, Me.lblStateEmpID, Me.lblFedEmpID, Me.lblFax, Me.lblTele, Me.lblCountry, Me.lblCityStZip, Me.lblAddress})
        Me.Font = New System.Drawing.Font("Arial", 8.0!, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, CType(0, Byte))
        Me.ForeColor = System.Drawing.Color.White
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle
        Me.Location = New System.Drawing.Point(127, 167)
        Me.MaximizeBox = False
        Me.MinimizeBox = False
        Me.Name = "frmCompanyInfo"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.Manual
        Me.Text = "Maintain Company Information"
        Me.ResumeLayout(False)

    End Sub
#End Region 
#Region "Upgrade Support "
	Private Shared m_vb6FormDefInstance As frmCompanyInfo
	Private Shared m_InitializingDefInstance As Boolean
	Public Shared Property DefInstance() As frmCompanyInfo
		Get
			If m_vb6FormDefInstance Is Nothing OrElse m_vb6FormDefInstance.IsDisposed Then
				m_InitializingDefInstance = True
				m_vb6FormDefInstance = New frmCompanyInfo()
				m_InitializingDefInstance = False
			End If
			DefInstance = m_vb6FormDefInstance
		End Get
		Set
			m_vb6FormDefInstance = Value
		End Set
	End Property
#End Region 
	'-------------------------------------------------------
	' PawCOM example using Visual Basic to read and
	' write to Peachtree data files using the PawCOM
	' COM object.
	'
	' Version 1    1-29-00   By: Paul Hill
	'--------------------------------------------------------
	
	Public CompanyPath As String 'Public so sub_cmdOK can see it.
	'-----------------------------------------------------------------------
	
	Private Sub frmCompanyInfo_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
		Dim oBtrieve As New PAW.Btrieve
		Dim myCompany As New PAW.SelectCompany
        Dim oCompanyInfo As New PAW.CompanyInformation()
        Dim oPeachw As New PAW.Peachw()

		Dim Status As Short
		Dim PeachtreeVersion As Double

        myCompany.CompanyPath = oPeachw.Datapath
        oPeachw = Nothing
        myCompany.ShowOpen() 'Displays Select Company from in PAWCOM
        CompanyPath = myCompany.CompanyPath 'Retrieves path selected from PAWCOM form
        Status = oBtrieve.Connect(CompanyPath) 'Try to connect to the company.
        If Status <> 0 Then
            MsgBox("Company not found.")
        End If

        oBtrieve.CompanyPath = CompanyPath
        Status = oCompanyInfo.OpenFile

        If Status <> 0 Then
            MsgBox("Status = " & Status, MsgBoxStyle.Critical, "Open Company failed")
        Else
            Status = oCompanyInfo.StepFirst
            If Status <> 0 Then
                MsgBox("oCompanyInfo.Read returned status = " & Status, MsgBoxStyle.Critical, "Read failed")
            Else
                PeachtreeVersion = oCompanyInfo.Version
                Me.lblPeachtreeVersionNo.Text = CStr(PeachtreeVersion)
                Me.txtCompanyName.Text = oCompanyInfo.CompanyName
                Me.txtAddress1.Text = oCompanyInfo.AddrLine1
                Me.txtAddress2.Text = oCompanyInfo.AddrLine2
                Me.txtCity.Text = oCompanyInfo.AddrCity
                Me.cboState.Text = oCompanyInfo.AddrState
                Me.txtZip.Text = oCompanyInfo.AddrPostalCode
                Me.txtCountry.Text = oCompanyInfo.AddrCountry
                Me.txtTelephone.Text = oCompanyInfo.Telephone
                Me.txtFax.Text = oCompanyInfo.Fax

                Me.cboBusinessTypeCode.Text = CStr(oCompanyInfo.BusinessTypeCode)
                Select Case oCompanyInfo.BusinessTypeCode
                    Case 0
                        Me.cboBusinessTypeCode.Text = "Corporation"
                    Case 1
                        Me.cboBusinessTypeCode.Text = "S Corporation"
                    Case 2
                        Me.cboBusinessTypeCode.Text = "Partnership"
                    Case 3
                        Me.cboBusinessTypeCode.Text = "Sole Proprietorship"
                    Case 4
                        Me.cboBusinessTypeCode.Text = "Limited Liability Company"
                    Case Else
                        Me.cboBusinessTypeCode.Text = ""
                End Select

                Me.txtFEIN.Text = oCompanyInfo.FEIN
                Me.txtSEIN.Text = oCompanyInfo.SEIN
                Me.txtSUIN.Text = oCompanyInfo.SUIN

                Me.cboPostingMethod.Text = CStr(oCompanyInfo.RealTime)
                If oCompanyInfo.RealTime = True Then
                    cboPostingMethod.Text = "Real-Time"
                Else
                    cboPostingMethod.Text = "Batch"
                End If

                If oCompanyInfo.CashBasis = True Then
                    Me.lblCashBasis.Text = "Cash"
                Else
                    Me.lblCashBasis.Text = "Accrual"
                End If

                If Not (PeachtreeVersion = 7.02) Then
                    Me.chkUseAuditTrail.Visible = False
                End If

                If oCompanyInfo.UseAuditTrail = True Then
                    Me.chkUseAuditTrail.CheckState = System.Windows.Forms.CheckState.Checked
                Else
                    Me.chkUseAuditTrail.CheckState = System.Windows.Forms.CheckState.Unchecked
                End If


                Me.chkETAFlag.CheckState = oCompanyInfo.ETAFlag
                Me.txtETACompanyID.Text = oCompanyInfo.ETACompanyID
                Me.txtETAUnknown.Text = oCompanyInfo.ETAUnknown

                'PAWCom does not seem to transfer oCompanyInfo.ETAFlag data always FALSE
                'Me.chkETAFlag.Value = vbChecked    'Test line
                'Me.chkETAFlag.Value = vbUnchecked  'Test line

                If Me.chkETAFlag.CheckState = System.Windows.Forms.CheckState.Checked Then
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
            'UPGRADE_WARNING: Couldn't resolve default property of object oCompanyInfo.CloseFile. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup1037"'
            Status = oCompanyInfo.CloseFile

            If Status <> 0 Then
                MsgBox("Status = " & Status, MsgBoxStyle.Critical, "CloseFile failed")
            End If

        End If 'Status = 0 Open File If Else - End If
        'UPGRADE_NOTE: Object oCompanyInfo may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup1029"'
        oCompanyInfo = Nothing
		
	End Sub
	'-----------------------------------------------------------------------
	
	'UPGRADE_WARNING: Event chkETAFlag.CheckStateChanged may fire when form is intialized. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup2075"'
	Private Sub chkETAFlag_CheckStateChanged(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles chkETAFlag.CheckStateChanged
		If Me.chkETAFlag.CheckState = System.Windows.Forms.CheckState.Checked Then
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
	
	Private Sub cmdOK_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdOK.Click
		Dim oBtrieve As New PAW.Btrieve
		Dim oCompanyInfo As New PAW.CompanyInformation
		Dim Status As Short
		
		'Try to connect to the company.
		Status = oBtrieve.Connect(CompanyPath)
		If Status <> 0 Then
			MsgBox("Company not found.")
		End If
		
		oBtrieve.CompanyPath = CompanyPath
		Status = oCompanyInfo.OpenFile
		
		' Extra = True
		
		If Status <> 0 Then
			MsgBox("Status = " & Status, MsgBoxStyle.Critical, "Open Company failed")
		Else
			Status = oCompanyInfo.StepFirst
			If Status <> 0 Then
				MsgBox("oCompanyInfo.Read returned status = " & Status, MsgBoxStyle.Critical, "Read failed")
			Else
				oCompanyInfo.CompanyName = Me.txtCompanyName.Text
				oCompanyInfo.AddrLine1 = Me.txtAddress1.Text
				'UPGRADE_WARNING: Use of Null/IsNull() detected. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup1049"'
				oCompanyInfo.AddrLine2 = IIf(IsDbNull(Me.txtAddress2.Text), "", Me.txtAddress2.Text)
				oCompanyInfo.AddrCity = Me.txtCity.Text
				oCompanyInfo.AddrState = Me.cboState.Text
				oCompanyInfo.AddrPostalCode = Me.txtZip.Text
				oCompanyInfo.AddrCountry = Me.txtCountry.Text
				oCompanyInfo.Telephone = Me.txtTelephone.Text
				oCompanyInfo.Fax = Me.txtFax.Text
				oCompanyInfo.FEIN = Me.txtFEIN.Text
				oCompanyInfo.SEIN = Me.txtSEIN.Text
				oCompanyInfo.SUIN = Me.txtSUIN.Text
				
				Select Case Me.cboBusinessTypeCode.Text
					
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
				
				If Me.cboPostingMethod.Text = "Real-Time" Then
					oCompanyInfo.RealTime = 1
				Else
					oCompanyInfo.RealTime = 0
				End If
				
				If Me.chkUseAuditTrail.CheckState = System.Windows.Forms.CheckState.Checked Then
					oCompanyInfo.UseAuditTrail = True
				Else
					oCompanyInfo.UseAuditTrail = False
				End If
				
				If Me.chkETAFlag.CheckState = System.Windows.Forms.CheckState.Checked Then
					oCompanyInfo.ETAFlag = True
					oCompanyInfo.ETACompanyID = Me.txtETACompanyID.Text
				Else
					oCompanyInfo.ETAFlag = False
				End If
				
				Status = oCompanyInfo.Update
				If Status <> 0 Then
					MsgBox("Status = " & Status, MsgBoxStyle.Critical, "Update failed")
				End If
				
				'UPGRADE_WARNING: Couldn't resolve default property of object oCompanyInfo.CloseFile. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup1037"'
				Status = oCompanyInfo.CloseFile
				If Status <> 0 Then
					MsgBox("Status = " & Status, MsgBoxStyle.Critical, "CloseFile failed")
				End If
			End If
		End If
		Status = oBtrieve.Reset
		If Status <> 0 Then
			MsgBox("Status = " & Status, MsgBoxStyle.Information, "Btrieve Reset failed")
		End If
		
		'UPGRADE_NOTE: Object oCompanyInfo may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup1029"'
		oCompanyInfo = Nothing
		'UPGRADE_NOTE: Object oBtrieve may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup1029"'
		oBtrieve = Nothing
		
		frmCompanyInfo.DefInstance.Close()
		'UPGRADE_NOTE: Object frmCompanyInfo may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup1029"'
		frmCompanyInfo.DefInstance = Nothing
	End Sub
	
	'-----------------------------------------------------------------------
	Private Sub cmdCancel_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles cmdCancel.Click
		frmCompanyInfo.DefInstance.Close()
		'UPGRADE_NOTE: Object frmCompanyInfo may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup1029"'
		frmCompanyInfo.DefInstance = Nothing
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
End Class