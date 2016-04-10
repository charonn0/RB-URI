#tag Class
Protected Class RemotePath
	#tag Method, Flags = &h0
		Sub Append(Name As String)
		  If Right(Name, 1) = "/" Then
		    Name = Left(Name, Name.Len - 1)
		    mHasEndSlash = True
		    If Name = "" Then Return
		  Else
		    mHasEndSlash = False
		  End If
		  If Name <> "" Then mPath.Append(DecodeURLComponent(Name))
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h1
		Protected Sub Constructor(FilePath As String)
		  Dim s() As String = Split(DecodeURLComponent(FilePath), "/")
		  For i As Integer = 0 To UBound(s)
		    If s(i).Trim <> "" Then mPath.Append(s(i))
		  Next
		  If s.Ubound > -1 Then mHasEndSlash = (s(s.Ubound) = "") Else mHasEndSlash = False
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Name As String)
		  mPath.Insert(Index, DecodeURLComponent(Name))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name(Index As Integer) As String
		  Return mPath(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Index As Integer, Assigns NewName As String)
		  mPath(Index) = DecodeURLComponent(NewName)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function NameCount() As Integer
		  Return mPath.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(NewPath As String)
		  Me.Constructor(NewPath)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Parent() As URIHelpers.RemotePath
		  Dim p As New RemotePath(Me.ToString)
		  If p.NameCount > 1 Then
		    p.Remove(p.NameCount - 1)
		    Return p
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  mPath.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString(URLEncoded As Boolean = True) As String
		  Dim s As String
		  For i As Integer = 0 To UBound(mPath)
		    If mPath(i).Trim = "" Then Continue
		    If URLEncoded Then
		      s = s + "/" + EncodeURLComponent(mPath(i))
		    Else
		      s = s + "/" + mPath(i)
		    End If
		  Next
		  If mHasEndSlash Then s = s + "/"
		  Return s
		End Function
	#tag EndMethod


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  return mHasEndSlash
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHasEndSlash = value
			End Set
		#tag EndSetter
		HasEndSlash As Boolean
	#tag EndComputedProperty

	#tag Property, Flags = &h1
		Protected mHasEndSlash As Boolean
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mPath() As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="HasEndSlash"
			Group="Behavior"
			Type="Boolean"
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
