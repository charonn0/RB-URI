#tag Class
Class URI
	#tag Method, Flags = &h0
		Function Credentials() As URIHelpers.Credentials
		  Return mCredentials
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  Dim URL As String
		  If Scheme <> "" Then URL = EncodeURLComponent(Scheme) + "://"
		  
		  If Username <> "" Then
		    URL = URL + EncodeURLComponent(Username)
		    If Scheme <> "mailto" Then URL = URL + ":"
		    If Password <> "" Then URL = URL + EncodeURLComponent(Password)
		    URL = URL + "@"
		  End If
		  
		  URL = URL + Host.ToString
		  
		  If Port > -1 And (Scheme <> "" And URIHelpers.SchemeToPort(Scheme) <> Port) Then
		    URL = URL + ":" + Format(Port, "####0")
		  End If
		  
		  URL = URL + Me.Path.ToString
		  
		  If Arguments.Count > 0 Then
		    URL = URL + Arguments.ToString
		  End If
		  
		  If Fragment <> "" Then
		    URL = URL + "#" + EncodeURLComponent(Fragment)
		  End If
		  If URL.Trim = "" Then URL = "/"
		  Return URL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(URL As String)
		  ' Pass a URI string to parse. e.g. http://user:password@www.example.com:8080/?foo=bar&bat=baz#Top
		  
		  Dim isIPv6 As Boolean
		  If NthField(URL, ":", 1) <> "mailto" Then
		    If InStr(URL, "://") > 0 Then
		      Me.Scheme = NthField(URL, "://", 1)
		      URL = URL.Replace(Me.Scheme + "://", "")
		    End If
		    
		    If Instr(URL, "@") > 0 Then //  USER:PASS@Domain
		      Me.Username = NthField(URL, ":", 1)
		      URL = URL.Replace(Me.Username + ":", "")
		      
		      Me.Password = NthField(URL, "@", 1)
		      URL = URL.Replace(Me.Password + "@", "")
		    End If
		    
		    If Instr(URL, ":") > 0 And Left(URL, 1) <> "[" Then //  Domain:Port
		      Dim s As String = NthField(URL, ":", 2)
		      s = NthField(s, "?", 1)
		      If Val(s) > 0 Then
		        Me.Port = Val(s)
		        URL = URL.Replace(":" + Format(Me.Port, "######"), "")
		      End If
		    ElseIf Left(URL, 1) = "[" And InStr(URL, "]:") > 0 Then ' ipv6 with port
		      isIPv6 = True
		      Dim s As String = NthField(URL, "]:", 2)
		      s = NthField(s, "?", 1)
		      Me.Port = Val(s)
		      URL = URL.Replace("]:" + Format(Me.Port, "######"), "]")
		    ElseIf Left(URL, 1) = "[" And InStr(URL, "]/") > 0 Then ' ipv6 with path
		      isIPv6 = True
		      'URL = URL.Replace("]/", "]")
		    Else
		      Me.Port = URIHelpers.SchemeToPort(Me.Scheme)
		    End If
		    
		    
		    If Instr(URL, "#") > 0 Then
		      Me.Fragment = NthField(URL, "#", 2)  //    #fragment
		      URL = URL.Replace("#" + Me.Fragment, "")
		    End If
		    
		    Me.Host = NthField(URL, "/", 1)  //  [sub.]domain.tld
		    URL = URL.Replace(Me.Host.ToString, "")
		    
		    If InStr(URL, "?") > 0 Then
		      Dim tmp As String = NthField(URL, "?", 1)
		      Path = tmp  //    /foo/bar.php
		      URL = URL.Replace(tmp + "?", "")
		      Me.Arguments = New URIHelpers.Arguments(URL)
		    Else
		      Path = URL.Trim
		      URL = Replace(URL, Me.Path.ToString, "")
		      Me.Arguments = New URIHelpers.Arguments("")
		    End If
		    
		  Else
		    Me.Scheme = "mailto"
		    URL = Replace(URL, "mailto:", "")
		    Me.Username = NthField(URL, "@", 1)
		    URL = Replace(URL, Me.Username + "@", "")
		    
		    If InStr(URL, "?") > 0 Then
		      Me.Host = NthField(URL, "?", 1)
		      Me.Arguments = New URIHelpers.Arguments(NthField(URL, "?", 2))
		    Else
		      Me.Host = URL
		    End If
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		Arguments As URIHelpers.Arguments
	#tag EndProperty

	#tag Property, Flags = &h0
		Fragment As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Host As URIHelpers.Hostname
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mCredentials As URIHelpers.Credentials
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mCredentials = Nil Then mCredentials = New URIHelpers.Credentials
			  return mCredentials.Password
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mCredentials = Nil Then mCredentials = New URIHelpers.Credentials
			  mCredentials.Password = value
			End Set
		#tag EndSetter
		Password As String
	#tag EndComputedProperty

	#tag Property, Flags = &h0
		Path As URIHelpers.RemotePath
	#tag EndProperty

	#tag Property, Flags = &h0
		Port As Integer = -1
	#tag EndProperty

	#tag Property, Flags = &h0
		Scheme As String
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mCredentials = Nil Then mCredentials = New URIHelpers.Credentials
			  return mCredentials.Username
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  If mCredentials = Nil Then mCredentials = New URIHelpers.Credentials
			  mCredentials.Username = value
			End Set
		#tag EndSetter
		Username As String
	#tag EndComputedProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Fragment"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
			Name="Password"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Port"
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Scheme"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
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
		#tag ViewProperty
			Name="Username"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
