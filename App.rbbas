#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  Dim url As URIHelpers.URI = "https://user:pass@192.168.1.4:7878/digest-auth/:qop/:test user/:seekrit?arg1=1&arg2=2#frag"
		  If url.Host.IsLiteral Then Break
		  'Dim h As New HTTPSecureSocket
		  'h.Secure = True
		  'Dim s As String = h.Get(url, 10)
		  'Do Until h.IsConnected
		  'DoEvents
		  'Loop
		  '
		  'Do Until Not h.IsConnected
		  'DoEvents
		  'Loop
		  '
		  'Dim e As InternetHeaders = h.PageHeaders
		  MsgBox(url)
		  Break
		End Sub
	#tag EndEvent


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
