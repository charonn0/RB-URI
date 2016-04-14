#tag Class
Protected Class Credentials
	#tag Method, Flags = &h0
		Function Basic() As String
		  Return EncodeBase64(Username + ":" + Password)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Digest(Realm As String, Nonce As String, Method As String, URL As String) As String
		  Dim h1, h2 As String
		  h1 = MD5(Username + ":" + Realm + ":" + Password)
		  h2 = MD5(Method + ":" + URL)
		  Return EncodeHex(MD5(h1 + ":" + Nonce + ":" + h2))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(FromString As String)
		  Username = URLDecode(NthField(FromString, ":", 1))
		  Password = URLDecode(NthField(FromString, ":", 2))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return Username + ":" + Password
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0
		Password As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Username As String
	#tag EndProperty


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
			Name="Password"
			Group="Behavior"
			Type="String"
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
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
