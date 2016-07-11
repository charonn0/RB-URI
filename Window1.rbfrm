#tag Window
Begin Window Window1
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   259
   ImplicitInstance=   True
   LiveResize      =   True
   MacProcID       =   0
   MaxHeight       =   32000
   MaximizeButton  =   False
   MaxWidth        =   32000
   MenuBar         =   ""
   MenuBarVisible  =   True
   MinHeight       =   64
   MinimizeButton  =   True
   MinWidth        =   64
   Placement       =   2
   Resizeable      =   True
   Title           =   "URI Parser Test"
   Visible         =   True
   Width           =   613
   Begin TextField TextField1
      AcceptTabs      =   ""
      Alignment       =   0
      AutoDeactivate  =   True
      AutomaticallyCheckSpelling=   False
      BackColor       =   16777215
      Bold            =   ""
      Border          =   True
      CueText         =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Format          =   ""
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      Italic          =   ""
      Left            =   0
      LimitText       =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Mask            =   ""
      Password        =   ""
      ReadOnly        =   ""
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "PROTOCOL://USER:PASS@SUB.DOMAIN.TLD:65535/DIR/SERVER FILE.EXT?arg1=1&arg2=2#Fragment"
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   613
   End
   Begin Listbox Listbox1
      AutoDeactivate  =   True
      AutoHideScrollbars=   True
      Bold            =   ""
      Border          =   True
      ColumnCount     =   2
      ColumnsResizable=   True
      ColumnWidths    =   "20%,*"
      DataField       =   ""
      DataSource      =   ""
      DefaultRowHeight=   -1
      Enabled         =   True
      EnableDrag      =   ""
      EnableDragReorder=   ""
      GridLinesHorizontal=   1
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   213
      HelpTag         =   ""
      Hierarchical    =   True
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "URI Part	Value"
      Italic          =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      RequiresSelection=   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   26
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   613
      _ScrollWidth    =   -1
   End
   Begin Label Status
      AutoDeactivate  =   True
      Bold            =   ""
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      Height          =   20
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   0
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   False
      Multiline       =   ""
      Scope           =   0
      Selectable      =   False
      TabIndex        =   3
      TabPanelIndex   =   0
      Text            =   "Awaiting input"
      TextAlign       =   0
      TextColor       =   &h000000
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   239
      Transparent     =   False
      Underline       =   ""
      Visible         =   True
      Width           =   613
   End
End
#tag EndWindow

#tag WindowCode
	#tag Method, Flags = &h1
		Protected Sub Parse(URL As String)
		  Listbox1.DeleteAllRows
		  If URL.Trim = "" Then
		    mResult = Nil
		    Return
		  End If
		  
		  mResult = URL
		  If mResult.Scheme <> "" Then
		    Listbox1.AddRow("Scheme", mResult.Scheme)
		    Listbox1.CellType(Listbox1.LastIndex, 1) = Listbox.TypeEditable
		  End If
		  
		  If mResult.Username <> "" Then
		    Listbox1.AddRow("Username", mResult.Username)
		    Listbox1.CellType(Listbox1.LastIndex, 1) = Listbox.TypeEditable
		  End If
		  
		  If mResult.Password <> "" Then
		    Listbox1.AddRow("Password", mResult.Password)
		    Listbox1.CellType(Listbox1.LastIndex, 1) = Listbox.TypeEditable
		  End If
		  
		  If mResult.Host <> Nil Then
		    If mResult.Host.IsLiteral Then
		      Listbox1.AddRow("IP", mResult.Host.ToString)
		    Else
		      Listbox1.AddRow("Host", mResult.Host.ToString)
		    End If
		    Listbox1.CellType(Listbox1.LastIndex, 1) = Listbox.TypeEditable
		  End If
		  
		  If mResult.Port > 0 Then
		    Listbox1.AddRow("Port", Format(mResult.Port, "######"))
		  ElseIf mResult.Scheme <> "" And URIHelpers.SchemeToPort(mResult.Scheme) > 0 Then
		    Listbox1.AddRow("Port", Format(URIHelpers.SchemeToPort(mResult.Scheme), "######"))
		  Else
		    Listbox1.AddRow("Port", "")
		  End If
		  Listbox1.CellType(Listbox1.LastIndex, 1) = Listbox.TypeEditable
		  
		  If mResult.Path <> Nil Then
		    Listbox1.AddRow("Path", mResult.Path.ToString(False))
		    Listbox1.CellType(Listbox1.LastIndex, 1) = Listbox.TypeEditable
		  End If
		  
		  If mResult.Arguments <> Nil Then
		    Listbox1.AddFolder("Arguments")
		    Listbox1.Cell(Listbox1.LastIndex, 1) = mResult.Arguments.ToString
		    Listbox1.CellType(Listbox1.LastIndex, 1) = Listbox.TypeEditable
		    Listbox1.RowTag(Listbox1.LastIndex) = mResult.Arguments
		  End If
		  
		  If mResult.Fragment <> "" Then
		    Listbox1.AddRow("Fragment", mResult.Fragment)
		    Listbox1.CellType(Listbox1.LastIndex, 1) = Listbox.TypeEditable
		  End If
		  
		  Listbox1.AddRow("Link value", mResult)
		  
		  Select Case URIHelpers.ValidateURL(URL)
		  Case 0
		    Status.Text = "This URI is legally formatted."
		  Case URIHelpers.PARSE_ERR_MISSING_SCHEME
		    Status.Text = "This URI does not have a scheme"
		  Case URIHelpers.PARSE_ERR_MISSING_DOMAIN
		    Status.Text = "This URI does not have a domain or IP address"
		  Case URIHelpers.PARSE_ERR_MISSING_PATH
		    Status.Text = "This URI does not have a path"
		  Case URIHelpers.PARSE_ERR_INVALID_PORT
		    Status.Text = "This URI does not have port"
		  Case URIHelpers.PARSE_ERR_INVALID_SCHEME
		    Status.Text = "This URI has an invalid scheme"
		  Case URIHelpers.PARSE_ERR_INVALID_DOMAIN
		    Status.Text = "This URI has an invalid domain or IP address"
		  Case URIHelpers.PARSE_ERR_INVALID_USERNAME
		    Status.Text = "This URI has an invalid username"
		  Case URIHelpers.PARSE_ERR_INVALID_PASSWORD
		    Status.Text = "This URI has an invalid password"
		  Else
		    Status.Text = "This URI illegally formatted"
		  End Select
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mResult As URIHelpers.URI
	#tag EndProperty


#tag EndWindowCode

#tag Events TextField1
	#tag Event
		Sub TextChange()
		  Parse(Me.Text)
		End Sub
	#tag EndEvent
	#tag Event
		Sub Open()
		  Parse(Me.Text)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events Listbox1
	#tag Event
		Function CellTextPaint(g As Graphics, row As Integer, column As Integer, x as Integer, y as Integer) As Boolean
		  If column = 1 And row = Me.ListCount - 1 Then
		    g.ForeColor = &c0000FF
		    g.Underline = True
		    g.DrawString(Me.Cell(row, column), x, y)
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Function CellClick(row as Integer, column as Integer, x as Integer, y as Integer) As Boolean
		  #pragma Unused x
		  #pragma Unused y
		  If column = 1 And row = Me.ListCount - 1 Then
		    ShowURL(Me.Cell(row, column))
		    Return True
		  End If
		  
		End Function
	#tag EndEvent
	#tag Event
		Sub MouseMove(X As Integer, Y As Integer)
		  Dim row, column As Integer
		  row = Me.RowFromXY(X, Y)
		  column = Me.ColumnFromXY(X, Y)
		  
		  If column = 1 And row = Me.ListCount - 1 Then
		    Me.MouseCursor = System.Cursors.FingerPointer
		  Else
		    Me.MouseCursor = System.Cursors.StandardPointer
		  End If
		  
		End Sub
	#tag EndEvent
	#tag Event
		Sub CellAction(row As Integer, column As Integer)
		  If mResult = Nil Then Return
		  
		  If column = 1 Then
		    Dim u As URI = mResult
		    Select Case Me.Cell(row, 0)
		    Case "Scheme"
		      u.Scheme = Me.Cell(row, column)
		    Case "Username"
		      u.Username = Me.Cell(row, column)
		    Case "Password"
		      u.Password = Me.Cell(row, column)
		    Case "IP", "Host"
		      u.Host = Me.Cell(row, column)
		    Case "Port"
		      If Me.Cell(row, column).Trim = "" Then
		        u.Port = -1
		      Else
		        u.Port = Val(Me.Cell(row, column))
		      End If
		    Case "Path"
		      u.Path = Me.Cell(row, column)
		    Case "Arguments"
		      Dim args As String = Me.Cell(row, column)
		      If Left(args, 1) = "?" Then args = Replace(args, "?", "")
		      u.Arguments = args
		    Case "Fragment"
		      u.Fragment = Me.Cell(row, column)
		    End Select
		    TextField1.Text = u
		  End If
		End Sub
	#tag EndEvent
	#tag Event
		Sub ExpandRow(row As Integer)
		  Select Case Me.Cell(row, 0)
		  Case "Arguments"
		    Dim a As URIHelpers.Arguments = Me.RowTag(row)
		    If a = Nil Then Return
		    Dim c As Integer = a.Count - 1
		    For i As Integer = c DownTo 0
		      Dim n, v As String
		      n = a.Name(i)
		      v = a.Value(i)
		      Me.InsertRow(row + 1, n, 1)
		      Me.CellType(Me.LastIndex, 0) = Listbox.TypeEditable
		      If v.Trim <> "" Then Me.Cell(Me.LastIndex, 1) = v
		      Me.CellType(Me.LastIndex, 1) = Listbox.TypeEditable
		      
		    Next
		  End Select
		End Sub
	#tag EndEvent
#tag EndEvents
