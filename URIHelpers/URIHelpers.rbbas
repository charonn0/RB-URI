#tag Module
Protected Module URIHelpers
	#tag Method, Flags = &h1
		Protected Function AuthenticateDigest(User As URIHelpers.Credentials, WWWAuthHeader As String, URL As String, Method As String) As String
		  'WWW-Authenticate: Digest nonce="37f351b46880aef1c97170fc0b2a4ee1", opaque="99ae35c4e6fb2c6ff4ab9d90b221a5d6", realm="me@kennethreitz.com", qop=auth
		  If NthField(WWWAuthHeader, " ", 1) <> "Digest" Then Return ""
		  Dim Realm, Nonce As String
		  WWWAuthHeader = Replace(WWWAuthHeader, "Digest ", "")
		  Dim fields() As String = Split(WWWAuthHeader, ", ")
		  For Each f As String In fields
		    Select Case NthField(f, "=", 1)
		    Case "nonce"
		      Nonce = ReplaceAll(NthField(f, "=", 2), """", "")
		      
		    Case "realm"
		      Realm = ReplaceAll(NthField(f, "=", 2), """", "")
		      
		    End Select
		  Next
		  Return User.Digest(Realm, Nonce, Method, URL)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsLiteral(Hostname As String) As Boolean
		  Return IsLiteralV4(Hostname) Or IsLiteralV6(Hostname)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsLiteralV4(Hostname As String) As Boolean
		  Dim s() As String = Split(Hostname, ".")
		  Return _
		  UBound(s) = 3 And _
		  IsNumeric(s(0)) And Val(s(0)) >= 0 And Val(s(0)) <= 255 And _
		  IsNumeric(s(1)) And Val(s(1)) >= 0 And Val(s(1)) <= 255 And _
		  IsNumeric(s(2)) And Val(s(2)) >= 0 And Val(s(2)) <= 255 And _
		  IsNumeric(s(3)) And Val(s(3)) >= 0 And Val(s(3)) <= 255
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsLiteralV6(Hostname As String) As Boolean
		  Return Left(Hostname, 1) = "[" And Right(Hostname, 1) = "]"
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SchemeToPort(Scheme As String) As Integer
		  Static mPorts As Dictionary
		  If mPorts = Nil Then
		    mPorts = New Dictionary( _
		    "http":80, _
		    "https":443, _
		    "ftp":21, _
		    "ssh":22, _
		    "telnet":23, _
		    "smtp":25, _
		    "smtps":25, _
		    "pop2":109, _
		    "pop3":110, _
		    "ident":113, _
		    "auth":113, _
		    "sftp":115, _
		    "nntp":119, _
		    "ntp":123, _
		    "irc":6667)
		  End If
		  
		  Return mPorts.Lookup(Scheme, -1)
		End Function
	#tag EndMethod


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InheritedFrom="Object"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			InheritedFrom="Object"
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
