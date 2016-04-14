#tag Module
Private Module Tests
	#tag Method, Flags = &h21
		Private Sub Assert(BooleanExpression As Boolean, FailMsg As String)
		  If Not BooleanExpression Then
		    Dim err As New RuntimeException
		    err.Message = FailMsg
		    Raise err
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Function RunTests() As String()
		  Dim fail() As String
		  Try
		    TestArguments()
		  Catch Err
		    fail.Append(Err.Message)
		  End Try
		  
		  Try
		    TestCredentials()
		  Catch Err
		    fail.Append(Err.Message)
		  End Try
		  
		  Try
		    TestIPv4()
		  Catch Err
		    fail.Append(Err.Message)
		  End Try
		  
		  Try
		    TestIPv6()
		  Catch Err
		    fail.Append(Err.Message)
		  End Try
		  
		  Try
		    TestHostname()
		  Catch Err
		    fail.Append(Err.Message)
		  End Try
		  
		  Return fail
		End Function
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestArguments()
		  Dim url As URIHelpers.URI = "http://username1:password2@sub1.example.com:8080/index/php/?arg1=1&arg2=2#top"
		  
		  Assert(url.Arguments.Count = 2, "Argument count does not match sample")
		  Assert(url.Arguments.Name(0) = "arg1", "Argument 1 name does not match sample")
		  Assert(url.Arguments.Name(1) = "arg2", "Argument 2 name does not match sample")
		  Assert(url.Arguments.Value(0) = "1", "Argument 1 value does not match sample")
		  Assert(url.Arguments.Value(1) = "2", "Argument 2 value does not match sample")
		  
		  url.Arguments.Append("arg3", "3")
		  Assert(url.Arguments.Name(2) = "arg3", "Argument 3 value does not match sample")
		  Assert(url.Arguments.Value(2) = "3", "Argument 3 value does not match sample")
		  
		  url.Arguments.Insert(0, "arg0", "0")
		  Assert(url.Arguments.Name(0) = "arg0", "Argument 0 value does not match sample")
		  Assert(url.Arguments.Value(0) = "0", "Argument 0 value does not match sample")
		  
		  url.Arguments.Remove(url.Arguments.Count - 1)
		  Assert(url.Arguments.Count = 3, "Argument count does not match sample after removal")
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestCredentials()
		  Dim url As URIHelpers.URI = "http://username1:password2@sub1.example.com:8080/index/php/?arg1=1&arg2=2#top"
		  
		  Assert(url.Credentials.Username = "username1", "Username does not match sample")
		  Assert(url.Credentials.Password = "password2", "Password does not match sample")
		  Assert(url.Credentials.Basic = "dXNlcm5hbWUxOnBhc3N3b3JkMg==", "Basic authentication does not match sample")
		  'Assert(url.Credentials.Digest = "dXNlcm5hbWUxOnBhc3N3b3JkMg==", "Digest authentication does not match sample")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestHostname()
		  Dim url As URIHelpers.URI = "http://sub3.sub2.sub1.domain.tld:8080/index/php/?arg1=1&arg2=2#top"
		  
		  Assert(url.Host.SubDomainCount = 5, "Subdomain count does not match sample")
		  Assert(url.Host.SubDomain(0) = "tld", "Hostname tld does not match sample")
		  Assert(url.Port = 8080, "Hostname port does not match sample")
		  Assert(Not url.Host.IsLiteral, "Hostname registers as literal")
		  Assert(url.Host = "sub3.sub2.sub1.domain.tld", "Hostname does not convert back to sample")
		  
		  
		  Assert(url.Host.TailMatch("domain.tld"), "Hostname does not tail match the sample")
		  Assert(url.Host.TailMatch("sub1.domain.tld"), "Hostname does not tail match the sample")
		  Assert(url.Host.TailMatch("sub2.sub1.domain.tld"), "Hostname does not tail match the sample")
		  Assert(url.Host.TailMatch("sub3.sub2.sub1.domain.tld"), "Hostname does not tail match the sample")
		  Assert(Not url.Host.TailMatch("sub3.sub2.subA.domain.tld"), "Hostname does not tail match the sample")
		  
		  
		  url.Host.InsertSubdomain(2, "sub0")
		  Assert(url.Host.TailMatch("domain.tld"), "Hostname does not tail match the modified sample")
		  Assert(url.Host.SubDomain(2) = "sub0", "Hostname subdomain does not match modified sample")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestIPv4()
		  Dim url As URIHelpers.URI = "http://192.168.1.4:8080/index/php/?arg1=1&arg2=2#top"
		  
		  Assert(url.Host.SubDomainCount = 1, "IPv4 Hostname contains subdomains")
		  Assert(url.Host.SubDomain(0) = "192.168.1.4", "IPv4 Hostname does not match sample")
		  Assert(url.Port = 8080, "IPv4 port does not match sample")
		  Assert(url.Host.IsLiteral, "IPv4 does not register as literal")
		  Assert(url.Host = "192.168.1.4", "IPv4 Hostname does not convert back to sample")
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub TestIPv6()
		  Dim url As URIHelpers.URI = "http://[FEDC:BA98:7654:3210:FEDC:BA98:7654:3211]:8080/index/php/?arg1=1&arg2=2#top"
		  
		  Assert(url.Host.SubDomainCount = 1, "IPv6 Hostname contains subdomains")
		  Assert(url.Host.SubDomain(0) = "[FEDC:BA98:7654:3210:FEDC:BA98:7654:3211]", "IPv6 Hostname does not match sample")
		  Assert(url.Port = 8080, "IPv6 port does not match sample")
		  Assert(url.Host.IsLiteral, "IPv6 does not register as literal")
		  Assert(url.Host = "[FEDC:BA98:7654:3210:FEDC:BA98:7654:3211]", "IPv6 Hostname does not convert back to sample")
		  
		End Sub
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
