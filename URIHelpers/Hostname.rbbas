#tag Class
Protected Class Hostname
	#tag Method, Flags = &h0
		Sub AppendSubdomain(SubName As String)
		  mSubdomains.Append(SubName)
		End Sub
	#tag EndMethod

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
		Sub InsertSubdomain(Index As Integer, SubName As String)
		  mSubdomains.Insert(Index, SubName)
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
		Sub RemoveSubdomain(Index As Integer)
		  mSubdomains.Remove(Index)
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
		Function TailMatch(OtherHost As URIHelpers.Hostname, BinaryCompare As Boolean = True) As Boolean
		  Dim count As Integer = Min(OtherHost.SubDomainCount - 1, Me.SubDomainCount - 1)
		  Dim mode As Integer
		  If Not BinaryCompare Then mode = 1
		  For i As Integer = 0 To count
		    If StrComp(OtherHost.SubDomain(i), Me.SubDomain(i), mode) <> 0 Then Return False
		  Next
		  Return True
		  
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
		  Dim c As Integer = Me.SubDomainCount - 1
		  Dim literal As Boolean = Me.IsLiteral
		  For i As Integer = c DownTo 0
		    If Not literal Then
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


	#tag Note, Name = Subdomain order
		A internet domain name is read from right to left, with the leftmost name part being the zeroth subdomain and then
		rightmost part being at SubDomainCount-1
		
		For example, the domain name "sub2.sub1.domain.tld" would be represented as:
		
		SubDomain(0) = "tld"
		SubDomain(1) = "domain"
		SubDomain(2) = "sub1"
		SubDomain(3) = "sub2"
		
		This class can also handle IPv4 and IPv6 address literals. When doing so, the IP literal is stored entirely at SubDomain(0).
		
	#tag EndNote


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
