#tag Window
Begin Window Window1
   BackColor       =   16777215
   Backdrop        =   ""
   CloseButton     =   True
   Composite       =   False
   Frame           =   0
   FullScreen      =   False
   HasBackColor    =   False
   Height          =   239
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
   Resizeable      =   False
   Title           =   "URI Parser Test"
   Visible         =   True
   Width           =   813
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
      LockRight       =   ""
      LockTop         =   True
      Mask            =   ""
      Password        =   ""
      ReadOnly        =   ""
      Scope           =   0
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "PROTOCOL://USER:PASS@SUB.DOMAIN.TLD:65535/DIR/SERVERFILE.EXT?arg1=1&arg2=2#Fragment"
      TextColor       =   0
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   0
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   757
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
      Height          =   212
      HelpTag         =   ""
      Hierarchical    =   ""
      Index           =   -2147483648
      InitialParent   =   ""
      InitialValue    =   "URI Part	Value"
      Italic          =   ""
      Left            =   0
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      RequiresSelection=   ""
      Scope           =   0
      ScrollbarHorizontal=   ""
      ScrollBarVertical=   True
      SelectionType   =   0
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   27
      Underline       =   ""
      UseFocusRing    =   True
      Visible         =   True
      Width           =   813
      _ScrollWidth    =   -1
   End
   Begin PushButton PushButton1
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
      Left            =   762
      LockBottom      =   ""
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   ""
      LockTop         =   True
      Scope           =   0
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      TextFont        =   "System"
      TextSize        =   0
      TextUnit        =   0
      Top             =   1
      Underline       =   ""
      Visible         =   True
      Width           =   48
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  ''Dim URL As New URI("http://www.example.net")
		  ''If URL.Username = "" Then
		  ''URL.Username = "bobbytables"
		  ''URL.Password = "secret123"
		  ''End If
		  ''URL.ServerFile = "/sections.html"
		  ''URL.Fragment = "Section31"
		  '
		  '
		  ''
		  'For i As Integer = 0 To 999
		  'Dim URL As New URI("http://bobbytables:secret123@www.example.net")
		  'Next
		  
		  'Dim URL2 As New URI("httP://bobbytables:secret123@www.example.net")
		  'URL2.CaseSensitive = True
		  'If URL = URL2 Then
		  'Break
		  'Else
		  'Break
		  'End If
		  
		  
		  ''URL = "http://bobbytables:secret123@www.example.net/sections.html#Section31"
		  ''Dim s As String = URL   
		  ''//s is now "http://bobbytables:secret123@www.example.net/sections.html#Section31"
		  ''Break
		  '
		  'Dim url As New URI("sftp://crashreports.mycompany.net#newreports")
		  'url.Username = "bob"
		  'url.Password = "157458"
		  'url.ServerFile = "/reports/report34234.rpt"
		  'url.Fragment = "oldreports"
		  'url.Arguments = Split("date=635481654&hostid=123456789", "&")
		  'url.Fragment = "oldreports"
		  'url.FQDN = "arch.mycompany.net"
		  'url.Port = 8080
		  'Dim s As String = URL
		  'Break
		End Sub
	#tag EndEvent


#tag EndWindowCode

#tag Events PushButton1
	#tag Event
		Sub Action()
		  Dim url As New URI(TextField1.Text)
		  Listbox1.DeleteAllRows
		  Listbox1.AddRow("Protocol", URL.Protocol)
		  Listbox1.AddRow("Username", URL.Username)
		  Listbox1.AddRow("Password", URL.Password)
		  Listbox1.AddRow("Domain", URL.FQDN)
		  Listbox1.AddRow("Port", Format(URL.Port, "######"))
		  Listbox1.AddRow("Server File", URL.ServerFile)
		  Listbox1.AddRow("Arguments", Join(URL.Arguments, "&"))
		  Listbox1.AddRow("Fragment", URL.Fragment)
		  Listbox1.AddRow("Covert Back", URL)
		End Sub
	#tag EndEvent
#tag EndEvents
