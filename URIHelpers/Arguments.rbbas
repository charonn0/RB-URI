#tag Class
Protected Class Arguments
	#tag Method, Flags = &h0
		Sub Append(Name As String, Value As String)
		  mArgs.Append(DecodeURLComponent(Name):DecodeURLComponent(Value))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Arguments As String)
		  Dim a() As String = Split(Arguments, "&")
		  For i As Integer = 0 To UBound(a)
		    Dim l, r As String
		    l = NthField(a(i), "=", 1)
		    r = Right(a(i), a(i).Len - (l.Len + 1)).Trim
		    l = l.Trim
		    mArgs.Append(l:r)
		  Next
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Count() As Integer
		  Return mArgs.Ubound + 1
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Insert(Index As Integer, Name As String, Value As String)
		  mArgs.Insert(Index, DecodeURLComponent(Name):DecodeURLComponent(Value))
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Name(Index As Integer) As String
		  If EncodeArguments Then
		    Return EncodeURLComponent(mArgs(Index).Left)
		  Else
		    Return mArgs(Index).Left
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Name(Index As Integer, Assigns NewName As String)
		  mArgs(Index) = NewName:mArgs(Index).Right
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Subscript(Index As Integer) As Pair
		  Return mArgs(Index)
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Subscript(Index As Integer, Assigns NewArg As Pair)
		  mArgs(Index) = NewArg
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Remove(Index As Integer)
		  mArgs.Remove(Index)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function ToString() As String
		  If mArgs.Ubound > -1 Then
		    Dim args As String = "?"
		    Dim acount As Integer = Me.Count
		    For i As Integer = 0 To acount - 1
		      If i > 0 Then args = args + "&"
		      args = args + Me.Name(i)
		      If Me.Value(i) <> "" Then args = args + "=" + Me.Value(i)
		    Next
		    Return args
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Value(Index As Integer) As String
		  If EncodeArguments Then
		    Return EncodeURLComponent(mArgs(Index).Right)
		  Else
		    Return mArgs(Index).Right
		  End If
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Value(Index As Integer, Assigns NewValue As String)
		  mArgs(Index) = mArgs(Index).Left:NewValue
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		EncodeArguments As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h1
		Protected mArgs() As Pair
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="EncodeArguments"
			Group="Behavior"
			InitialValue="False"
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
