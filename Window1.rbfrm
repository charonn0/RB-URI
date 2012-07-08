#tag Window
Begin Window Window1
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   2.59e+2
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
   Width           =   9.11e+2
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
      Width           =   552
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
      GridLinesHorizontal=   2
      GridLinesVertical=   0
      HasHeading      =   True
      HeadingIndex    =   -1
      Height          =   232
      HelpTag         =   ""
      Hierarchical    =   ""
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
      TabIndex        =   4
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   27
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   911
      _ScrollWidth    =   -1
   End
   Begin PushButton PushButton1
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Validate"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   634
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   12
      TextUnit        =   0
      Top             =   1
      Underline       =   ""
      Visible         =   True
      Width           =   65
   End
   Begin PushButton PushButton2
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Parse"
      Default         =   True
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   564
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   12
      TextUnit        =   0
      Top             =   1
      Underline       =   ""
      Visible         =   True
      Width           =   65
   End
   Begin PushButton PushButton3
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Speed"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   704
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   3
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   12
      TextUnit        =   0
      Top             =   1
      Underline       =   ""
      Visible         =   True
      Width           =   65
   End
   Begin PushButton PushButton4
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Encode"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   774
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   5
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   12
      TextUnit        =   0
      Top             =   1
      Underline       =   ""
      Visible         =   True
      Width           =   65
   End
   Begin PushButton PushButton5
      AutoDeactivate  =   True
      Bold            =   ""
      ButtonStyle     =   0
      Cancel          =   ""
      Caption         =   "Decode"
      Default         =   False
      Enabled         =   True
      Height          =   22
      HelpTag         =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   ""
      Left            =   844
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   True
      Scope           =   0
      TabIndex        =   6
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   12
      TextUnit        =   0
      Top             =   1
      Underline       =   ""
      Visible         =   True
      Width           =   65
   End
End
#tag EndWindow

#tag WindowCode
#tag EndWindowCode

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
#tag EndEvents
#tag Events PushButton1
	#tag Event
		Sub Action()
		  If URI.Validate(TextField1.Text) Then
		    MsgBox("URI is valid")
		  Else
		    Select Case URI.ValidationError
		    Case 1
		      MsgBox("Conversion is not safe since you won't get the same data back again")
		    Case 2
		      MsgBox("Missing Protocol")
		    Case 3
		      MsgBox("Username was expected but not found")
		    Case 4
		      MsgBox("Password was expected but not found")
		    Case 5
		      MsgBox("Port exceeded the allowed range (0-65535)")
		    Case 6
		      MsgBox("The domain name is malformed")
		    Case 7
		      MsgBox("'@' was not found")
		    Else
		      MsgBox(Str(URI.ValidationError))
		    End Select
		  End If
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton2
	#tag Event
		Sub Action()
		  Dim url As New URI(TextField1.Text)
		  Listbox1.DeleteAllRows
		  Listbox1.AddRow("Protocol", URL.Protocol)
		  Listbox1.AddRow("Username", URL.Username)
		  Listbox1.AddRow("Password", URL.Password)
		  Listbox1.AddRow("Domain", URL.FQDN)
		  Listbox1.AddRow("Port", Format(URL.Port, "######"))
		  Listbox1.AddRow("Server File", Join(URL.ServerFile, "/"))
		  Listbox1.AddRow("Arguments", Join(URL.Arguments, "&"))
		  Listbox1.AddRow("Fragment", URL.Fragment)
		  Listbox1.AddRow("Convert Back", URL)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton3
	#tag Event
		Sub Action()
		  Dim url As New URI("random://stuff.here:123/that/validates?a=b&c=d#42")
		  Dim atotals(), btotals(), ctotals() As UInt64
		  
		  For i As Integer = 0 To 99
		    Dim starting, ending As UInt64
		    Dim b As Boolean
		    Dim urlstring As String = TextField1.Text
		    
		    starting = Microseconds
		    url = urlstring  //Convert a string to a URI
		    ending = Microseconds
		    atotals.Append(ending - starting)
		    
		    starting = Microseconds
		    b = URI.Validate(urlstring)  //Validate a string
		    ending = Microseconds
		    btotals.Append(ending - starting)
		    
		    starting = Microseconds
		    urlstring = url  //Convert a URI to a String
		    ending = Microseconds
		    ctotals.Append(ending - starting)
		    
		  Next
		  
		  Dim averageconvertin, averageconvertout, averagevalidate As Integer
		  For i As Integer = 0 To UBound(btotals)
		    averageconvertin = averageconvertin + atotals(i)
		    averagevalidate = averagevalidate + btotals(i)
		    averageconvertout = averageconvertout + ctotals(i)
		  Next
		  averageconvertin = averageconvertin / (UBound(atotals) + 1)
		  averagevalidate = averagevalidate / (UBound(atotals) + 1)
		  averageconvertout = averageconvertout / (UBound(atotals) + 1)
		  
		  Call MsgBox("Parsing the URL: " + Str(averageconvertin) + "μs" + EndOfLine + _
		  "Validating the URL: " + Str(averagevalidate) + "μs" + EndOfLine + _
		  "Converting back to a string: " + Str(averageconvertout) + "μs", 0, "Average Completion Times")
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton4
	#tag Event
		Sub Action()
		  TextField1.Text = URI.Encode(TextField1.Text)
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButton5
	#tag Event
		Sub Action()
		  TextField1.Text = URI.Decode(TextField1.Text)
		End Sub
	#tag EndEvent
#tag EndEvents
