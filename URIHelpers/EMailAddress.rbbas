#tag Class
Protected Class EMailAddress
	#tag Method, Flags = &h1
		Protected Sub Constructor(Address As String)
		  Dim h As String = NthField(Address, "@", CountFields(Address, "@"))
		  Username = Left(Address, Address.Len - (h.Len + 1))
		  Host = h
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLegal() As Boolean
		  If Me.Host = "" Then Return False
		  If Me.Username = "" Then Return False
		  If Me.ToString.Len > 254 Then Return False
		  
		  Dim tmp As String = Username
		  Dim bs As New BinaryStream(tmp)
		  Dim dotcount As Integer
		  Dim quote As Boolean
		  Dim lastchar As Byte
		  Do Until bs.EOF
		    Dim char As Byte = bs.ReadByte
		    Select Case char
		    Case 33, 35 To 39, 42, 43, 45, 47 To 57, 61, 63, 65 To 90, 94 To 126
		      dotcount = 0
		    Case 34 ' "
		      If quote Or dotcount = 1 Or bs.Position = 1 Or bs.Position = bs.Length Then
		        If lastchar <> 92 Then
		          quote = Not quote
		        End If
		      Else
		        Return False
		      End If
		      
		    Case 32, 40, 41, 44, 58 To 60, 62, 64, 91, 93
		      If Not quote And lastchar <> 92 Then 
		        Return False
		      End If
		      
		    Case 46
		      dotcount = dotcount + 1
		      If dotcount > 2 Then 
		        Return False
		      End If
		    Else
		      dotcount = 0
		    End Select
		    lastchar = char
		  Loop
		  bs.Close
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(Address As String)
		  If Left(Address, 7) = "mailto:" Then 
		    Dim u As URI = Address
		    Address = u.Username + "@" + u.Host.ToString
		  End If
		  Me.Constructor(Address)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Return Username + "@" + Host.ToString
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  If mHost = Nil Then mHost = ""
			  return mHost
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHost = value
			End Set
		#tag EndSetter
		Host As URIHelpers.Hostname
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private mHost As URIHelpers.Hostname
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
