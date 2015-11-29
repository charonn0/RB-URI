#tag Class
Protected Class Hostname
	#tag Method, Flags = &h1
		Protected Sub Constructor(Hostname As String)
		  If Not URIHelpers.IsLiteral(Hostname) Then
		    Dim s() As String = Split(Hostname, ".")
		    For i As Integer = 0 To UBound(s)
		      mSubdomains.Insert(0, DecodeURLComponent(s(i)))
		    Next
		  Else
		    mSubdomains = Array(Hostname)
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function IsLiteral() As Boolean
		  Return URIHelpers.IsLiteral(Join(mSubdomains, ""))
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(OtherHost As String) As Integer
		  Return StrComp(OtherHost, Me.ToString, 0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(NewHost As String)
		  Me.Constructor(NewHost)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubDomain(Index As Integer) As String
		  Return mSubdomains(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub SubDomain(Index As Integer, Assigns NewSubDomain As String)
		  mSubdomains(Index) = DecodeURLComponent(NewSubDomain)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function SubDomainCount() As Integer
		  Return mSubdomains.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function TLD() As String
		  Return mSubdomains(0)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TLD(Assigns NewTLD As String)
		  mSubdomains(0) = DecodeURLComponent(NewTLD)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  Dim s As String
		  Dim c As Integer = SubDomainCount - 1
		  For i As Integer = c DownTo 0
		    If Not Me.IsLiteral Then
		      If s <> "" Then s = s + "."
		      s = s + EncodeURLComponent(mSubdomains(i))
		    ElseIf c = 0 Then' IPv6
		      s = mSubdomains(0)
		      Exit For
		    Else
		      If s <> "" Then s = s + "."
		      s = s + mSubdomains(i)
		    End If
		  Next
		  
		  Return s
		End Function
	#tag EndMethod


	#tag Property, Flags = &h1
		Protected mSubdomains() As String
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
	#tag EndViewBehavior
End Class
#tag EndClass
