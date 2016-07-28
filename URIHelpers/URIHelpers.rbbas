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
		Protected Function IsLegalURL(URL As String) As Boolean
		  Dim u As URI = URL
		  If u.Scheme <> "file" And u.Host = "" Then Return False
		  If u.Port > 65536 Or u.Port < -1 Then Return False
		  If IsNumeric(u.Scheme.Left(1)) Then Return False
		  If u <> URL Then Return False
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsLiteral(Hostname As String) As Boolean
		  ' Returns True if the Hostname string is (probably) a legal IPv4 or IPv6 address literal
		  Return IsLiteralV4(Hostname) Or IsLiteralV6(Hostname)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function IsLiteralV4(Hostname As String) As Boolean
		  ' Returns True if the Hostname string is a legal IPv4 address literal
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
		  ' Returns True if the Hostname string is (probably) a legal IPv6 address literal
		  
		  If Left(Hostname, 1) <> "[" Or Right(Hostname, 1) <> "]" Then Return False
		  If Mid(Hostname, 2, 2) = "::" Then
		    Dim tmp As String = NthField(Hostname, ":", CountFields(Hostname, ":"))
		    If IsLiteralV4(Left(tmp, tmp.Len - 1)) Then Return True ' embedded IPv4 address.
		  End If
		  
		  Static valid() As String = Split("ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789", "")
		  Dim lastchar As String
		  Dim squished As Boolean
		  For i As Integer = 2 To Hostname.Len - 1
		    Dim char As String = Mid(Hostname, i, 1)
		    Select Case True
		    Case char = ":"
		      If char = lastchar Then
		        If squished Then Return False ' more than one "::" present
		        squished = True
		      End If
		    Case valid.IndexOf(char) = -1
		      Return False
		    End Select
		    lastchar = char
		  Next
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function MailTo(Address As String, Subject As String = "", MessageBody As String = "") As URIHelpers.URI
		  Dim e As EmailAddress = Address
		  Dim u As URI = ""
		  u.Scheme = "mailto"
		  u.Username = e.Username
		  u.Host = e.Host
		  If Subject <> "" Then u.Arguments.Append("Subject", Subject)
		  If MessageBody <> "" Then u.Arguments.Append("body", MessageBody)
		  Return u
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function SanityTests() As String()
		  Dim failures() As String = URIHelpers.Tests.RunTests()
		  
		  Dim url1 As URIHelpers.URI = "https://www.google.co.uk:444/search?q=hello, world!"
		  Dim url2 As URIHelpers.URI = "https://www.google.co.uk:444/search?q=hello, world!"
		  Dim url3 As URIHelpers.URI = "https://www.google.co.uk:444/search?q=hello, world!"
		  Dim url4 As URIHelpers.URI = "http://[FEDC:BA98:7654:3210:FEDC:BA98:7654:3211]:80"
		  Dim url5 As URIHelpers.URI = "https://www.google.co.uk:444/search?q=hello, world!/index.html?foo=bar"
		  Dim url6 As URIHelpers.URI = "https://www.google.co.uk:444/search?q=hello, world!"
		  
		  If url1 <> url2 Then
		    Break ' WRONG
		    failures.Append("URL comparison #1 failed")
		  End If
		  
		  If url3 <> url1 Then
		    Break ' WRONG
		    failures.Append("URL comparison #2 failed")
		  End If
		  
		  If url5 = url4 Then
		    Break ' WRONG
		    failures.Append("URL comparison #3 failed")
		  End If
		  
		  If url1 <> url6 Then
		    Break ' WRONG
		    failures.Append("URL comparison #4 failed")
		  End If
		  
		  Return failures
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

	#tag Method, Flags = &h1
		Protected Function URLDecode(Data As MemoryBlock) As String
		  Dim bs As New BinaryStream(Data)
		  Dim decoded As New MemoryBlock(0)
		  Dim dcbs As New BinaryStream(decoded)
		  Do Until bs.EOF
		    Dim char As String = bs.Read(1)
		    If AscB(char) = 37 Then ' %
		      dcbs.Write(ChrB(Val("&h" + bs.Read(2))))
		    Else
		      dcbs.Write(char)
		    End If
		  Loop
		  dcbs.Close
		  Return DefineEncoding(decoded, Encodings.UTF8)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLEncodable(Data As String) As Boolean
		  Dim bs As New BinaryStream(Data)
		  Dim ret As Boolean
		  Do Until bs.EOF
		    Dim char As Byte = bs.ReadByte
		    Select Case char
		    Case &h30 To &h39, &h41 To &h5A, &h61 To &h7A, &h2D, &h2E, &h5F
		      Continue
		    Else
		      ret = True
		      Exit Do
		    End Select
		  Loop
		  bs.Close
		  Return ret
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function URLEncode(Data As MemoryBlock) As String
		  Dim bs As New BinaryStream(Data)
		  Dim encoded As New MemoryBlock(0)
		  Dim enbs As New BinaryStream(encoded)
		  
		  Do Until bs.EOF
		    Dim char As Byte = bs.ReadByte
		    Select Case char
		    Case &h30 To &h39, &h41 To &h5A, &h61 To &h7A, &h2D, &h2E, &h5F
		      enbs.WriteByte(char)
		    Else
		      enbs.Write("%" + Right("0" + Hex(char), 2))
		    End Select
		  Loop
		  enbs.Close
		  Return DefineEncoding(encoded, Encodings.ASCII)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function ValidateURL(URL As String, Strict As Boolean = False, ParamArray SkipChecks() As Integer) As Integer
		  Dim isIPv6 As Boolean
		  Dim scheme, user, pass, domain, port, path, args, frag As String
		  If InStr(URL, "://") > 0 Then
		    scheme = NthField(URL, "://", 1)
		    URL = URL.Replace(scheme + "://", "")
		  End If
		  
		  Dim auth As Integer = Instr(URL, "/")
		  Dim authority As String = Left(URL, auth - 1)
		  If InStr(authority, "@") > 0 Then //  USER:PASS@Domain
		    Dim userinfo As String = NthField(authority, "@", 1)
		    authority = authority.Replace(userinfo + "@", "")
		    user = NthField(userinfo, ":", 1)
		    pass = NthField(userinfo, ":", 2)
		    URL = URL.Replace(userinfo + "@", "")
		  End If
		  
		  If Instr(URL, ":") > 0 And Left(URL, 1) <> "[" Then //  Domain:Port
		    port = NthField(URL, ":", 2)
		    If InStr(port, "/") > InStr(port, "?") Then
		      port = NthField(port, "?", 1)
		    Else
		      port = NthField(port, "/", 1)
		    End If
		    URL = URL.Replace(":" + port, "")
		  ElseIf Left(URL, 1) = "[" And InStr(URL, "]:") > 0 Then ' ipv6 with port
		    isIPv6 = True
		    port = NthField(URL, "]:", 2)
		    port = NthField(port, "?", 1)
		    URL = URL.Replace("]:" + port, "]")
		  ElseIf Left(URL, 1) = "[" And InStr(URL, "]/") > 0 Then ' ipv6 with path
		    isIPv6 = True
		  Else
		    port = ""
		  End If
		  
		  If Instr(URL, "#") > 0 Then
		    frag = NthField(URL, "#", 2)  //    #fragment
		    URL = URL.Replace("#" + frag, "")
		  End If
		  
		  domain = NthField(URL, "/", 1)  //  [sub.]domain.tld
		  URL = URL.Replace(domain, "")
		  
		  If InStr(URL, "?") > 0 Then
		    Dim tmp As String = NthField(URL, "?", 1)
		    Path = tmp  //    /foo/bar.php
		    URL = URL.Replace(tmp + "?", "")
		    args = URL
		  Else
		    path = URL.Trim
		    URL = Replace(URL, path, "")
		  End If
		  
		  
		  If SkipChecks.IndexOf(PARSE_ERR_INVALID_PORT) = -1 And URLEncodable(port) Then Return PARSE_ERR_INVALID_PORT
		  If SkipChecks.IndexOf(PARSE_ERR_MISSING_DOMAIN) = -1 And domain = "" And scheme <> "file" Then Return PARSE_ERR_MISSING_DOMAIN
		  If SkipChecks.IndexOf(PARSE_ERR_INVALID_DOMAIN) = -1 And URLEncodable(domain) Then Return PARSE_ERR_INVALID_DOMAIN
		  If Strict And (user <> "" Or pass <> "") Then
		    If SkipChecks.IndexOf(PARSE_ERR_INVALID_USERNAME) = -1 And URLEncodable(user) Then Return PARSE_ERR_INVALID_USERNAME
		    If SkipChecks.IndexOf(PARSE_ERR_INVALID_PASSWORD) = -1 And URLEncodable(pass) Then Return PARSE_ERR_INVALID_PASSWORD
		  End If
		  If SkipChecks.IndexOf(PARSE_ERR_MISSING_SCHEME) = -1 And scheme.Trim = "" And Strict Then Return PARSE_ERR_MISSING_SCHEME
		  If SkipChecks.IndexOf(PARSE_ERR_INVALID_SCHEME) = -1 And URLEncodable(scheme.Trim) Then Return PARSE_ERR_INVALID_SCHEME
		End Function
	#tag EndMethod


	#tag Constant, Name = PARSE_ERR_INVALID_DOMAIN, Type = Double, Dynamic = False, Default = \"6", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PARSE_ERR_INVALID_PASSWORD, Type = Double, Dynamic = False, Default = \"8", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PARSE_ERR_INVALID_PORT, Type = Double, Dynamic = False, Default = \"4", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PARSE_ERR_INVALID_SCHEME, Type = Double, Dynamic = False, Default = \"5", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PARSE_ERR_INVALID_USERNAME, Type = Double, Dynamic = False, Default = \"7", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PARSE_ERR_MISSING_DOMAIN, Type = Double, Dynamic = False, Default = \"2", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PARSE_ERR_MISSING_PATH, Type = Double, Dynamic = False, Default = \"3", Scope = Protected
	#tag EndConstant

	#tag Constant, Name = PARSE_ERR_MISSING_SCHEME, Type = Double, Dynamic = False, Default = \"1", Scope = Protected
	#tag EndConstant


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
