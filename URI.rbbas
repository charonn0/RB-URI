#tag Class
Protected Class URI
	#tag Method, Flags = &h0
		Sub Constructor(URL As String)
		  Parse(URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Compare(CompareTo As URI) As Integer
		  //Return values:
		  // -1: CompareTo < Me -Or- not equal (if CaseSensitive = False)
		  //  0: CompareTo = Me
		  //  1: CompareTo > Me -Or- not equal (if CaseSensitive = False)
		  
		  Dim l, r As String
		  l = CompareTo
		  r = Me
		  
		  If Me.CaseSensitive Or CompareTo.CaseSensitive Then
		    Return StrComp(l, r, 1)
		  Else
		    If l = r Then
		      Return 0
		    Else
		      Return -1
		    End If
		  End If
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Function Operator_Convert() As String
		  //This method overloads the assigment operator ("=") so that any instance of the URI class can be converted directly into a string:
		  '     Dim URL As New URI("hxxp://www.example.net")
		  '     URL.ServerFile = "/sections.html"
		  '     URL.Fragment = "Section31"
		  '     If URL.Username = "" Then
		  '       URL.Username = "bobbytables"
		  '       URL.Password = "secret123"
		  '     End If
		  '     Dim s As String = URL   //s is now "hxxp://bobbytables:secret123@www.example.net/sections.html#Section31"
		  
		  
		  Dim URL As String
		  If Protocol = "mailto" Then
		    URL = "mailto:"
		  Else
		    If Protocol <> "" Then URL = Protocol + "://"
		  End If
		  
		  If Username <> "" Then
		    URL = URL + Username
		    If Password <> "" Then URL = URL + ":" + Password
		    URL = URL + "@"
		  End If
		  
		  URL = URL + FQDN
		  
		  If Port <> 0 Then //port specified
		    URL = URL + ":" + Format(Port, "#####")
		  End If
		  
		  If ServerFile <> "" Then
		    URL = URL + ServerFile
		  Else
		    If Protocol <> "mailto" Then URL = URL + "/"
		  End If
		  
		  If UBound(Arguments) > -1 Then
		    URL = URL + "?" + Join(Arguments, "&")
		  End If
		  
		  If Fragment <> "" Then
		    URL = URL + "#" + Fragment
		  End If
		  
		  Return URL
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Operator_Convert(URL As String)
		  //This method overloads the assigment operator ("=") so that
		  //any instance of the URI class can be assigned directly to a 
		  //string:
		  '       Dim URL As New URI("hxxp://bobbytables:secret123@www.example.net")
		  '       //URL now contains "hxxp://bobbytables:secret123@www.example.net"
		  '       URL = "hxxp://bobbytables:secret123@www.example.net/sections.html#Section31"
		  '       //URL now contains "hxxp://bobbytables:secret123@www.example.net/sections.html#Section31"
		  
		  //Just parse it
		  Parse(URL)
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Sub Parse(URL As String)
		  //The Parse method accepts a string as input and parses that string as a URI into the various class properties.
		  //Parse is called by the class constructor and by the Operator_Convert(String) method.
		  
		  If NthField(URL, ":", 1) <> "mailto" Then 
		    If InStr(URL, "://") > 0 Then
		      Protocol = NthField(URL, "://", 1)
		      URL = URL.Replace(Protocol + "://", "")
		    End If
		    
		    If Instr(URL, "@") > 0 Then //  USER:PASS@Domain
		      Username = NthField(URL, ":", 1)
		      URL = URL.Replace(Username + ":", "")
		      
		      Password = NthField(URL, "@", 1)
		      URL = URL.Replace(Password + "@", "")
		    End If
		    
		    If Instr(URL, ":") > 0 Then //  Domain:Port
		      Port = Val(NthField(URL, ":", 2))
		      URL = URL.Replace(":" + Format(Port, "######"), "")
		    End If
		    
		    If Instr(URL, "#") > 0 Then
		      Fragment = NthField(URL, "#", 2)  //    #fragment
		      URL = URL.Replace("#" + Fragment, "")
		    End If
		    
		    FQDN = NthField(URL, "/", 1)  //  [sub.]domain.tld
		    URL = URL.Replace(FQDN, "")
		    
		    If InStr(URL, "?") > 0 Then
		      ServerFile = NthField(URL, "?", 1)  //    /foo/bar.php
		      URL = URL.Replace(ServerFile + "?", "")
		      Arguments = Split(URL, "&")
		    Else
		      ServerFile = URL
		    End If
		  Else
		    Protocol = "mailto"
		    URL = Replace(URL, "mailto:", "")
		    Username = NthField(URL, "@", 1)
		    URL = Replace(URL, Username + "@", "")
		    
		    If InStr(URL, "?") > 0 Then
		      FQDN = NthField(URL, "?", 1)
		      Arguments = Split(NthField(URL, "?", 2), "&")
		    Else
		      FQDN = URL
		    End If
		  End If
		End Sub
	#tag EndMethod


	#tag Note, Name = Examples
		1. Creating and modifying URIs
		
		     Dim url As New URI("https://crashreports.mycompany.net#newreports")
		     If url.Protocol <> "https" Then
		       msgbox("Not a secure server!")
		       Return
		     End If
		     url.Username = CustomerUserName
		     url.Password = CustomerLicenseKey
		     url.ServerFile = "/reports/" + reportName
		     url.Arguments.Append("filter=all")
		     url.Arguments.Append("hostid=123456789")
		     ShowURL(url)
		
		This code might generate a URL like this: 
		     https://johncustomer:License1234567@crashreports.mycompany.net/reports/report.rpt?filter=all&hostid=123456789#newreports
		
		We can then just change one or two things and get the new URL:
		
		     url.Fragment = "oldreports"
		     url.FQDN = "arch.mycompany.net"
		     url.Port = 8080
		     ShowURL(url)
		     //   https://johncustomer:License1234567@arch.mycompany.net:8080/reports/report.rpt?filter=all&hostid=123456789#oldreports
		
		
		2. Comparing and Converting URIs
		
		The URI class can convert itself into a string and also can convert a string into itself. URIs are therefore easily
		passed back and forth between being a string and being an instance of the URI class. Instances of the URI class can
		also be directly compared to one another. When compared, they will be considered equal if converting both into a string
		produces identical strings. Set the CaseSensitive property to True to make the comparisons sensitive to encoding.
		
		     Dim URL As New URI("") //Create an empty URI
		     Dim URL2 As New URI("Http://bobbytables:secret123@www.example.net")
		     URL = "http://bobbytables:secret123@www.example.net"  //Convert a string into a URI
		     If URL = URL2 Then  //Compare URIs
		       //We get here if neither URI is set to CaseSensitive
		     Else
		       //We get here if EITHER URI is set to CaseSensitive (even if the other one isn't CaseSensitive)
		     End If
		
		
		
		
		
		
		
		
		
		
		
		
	#tag EndNote

	#tag Note, Name = How to use this class
		URI Class by Andrew Lambert
		http://www.boredomsoft.org
		(c)2012, CC-BY-SA
		
		You create a new instance of the URI class with any valid URI ("" is also considered valid)
		
		    Dim url As New URI("http://www.example.net")
		
		Once instantiated, you can test and/or set any of the properties:
		
		    If URL.Protocol = "HTTP" Then
		      URL.Protocol = "HTTPS"
		    End If
		
		The URI class can convert itself to and from strings:
		
		    URL = "http://www.example.com"   //Convert a string into a URI
		    MsgBox(URL)                      //Convert a URI into a string
		
		URI instances can be compared directly for equality.
	#tag EndNote

	#tag Note, Name = What is a URI?
		This class implements an easy-to-manipulate object for dealing with URIs. URIs are strings like these:
		
		       http://docs.realsoftware.com/index.php/UsersGuide:Chapter13:Making_Networking_Easy#Making_Networking_Easy
		       ftp://jpublic:letmein@example.net:21/home/jpublic/plans.txt
		       mailto:user@host.net?subject=Hello&body=world
		       ircs://2001::123:4567:abcd:6697/MyChannel?chanpasswd
		
		This class ought to work with most of the common variants of the URI scheme. The scheme expected is either:
		
		         [PROTOCOL]<://>[USER<:>PASS<@>][SUB.]DOMAIN.TLD[<:>port][</>SERVERFILE.EXT]<?>[arg1=1<&>[arg2=2]][#Fragment]
		    -OR-
		         MAILTO<:>USER<@>[SUB.]DOMAIN.TLD<?>[arg1=1<&>[arg2=2]]
		
		DOMAIN.TLD can also be any IP address in proper URI format, e.g. "http://bob:letmein@127.0.0.1:8080/htdocs/index.html#Page1"
		IPv6 addresses might screw up but should convert back properly.
		
		Parts in square brackets ([ ]) are optional, parts in angle brackets (< >) are implied and inserted when the
		URI converts itself to a string (and stripped out when a string is converted into a URI. )CAPITALIZED parts are 
		the salient details of the URI, with those not in square brackets being mandatory.
		
		mailto does NOT have a double slash (ie. not mailto://) and is treated as a special case.
		
		As you can see, URIs contain a lot of useful information in a fairly elastic format. Not all types of
		URI accept all the possible formats. mailto: is not technically a URI and is only partly implemented
		here (the important parts.)
	#tag EndNote


	#tag Property, Flags = &h0
		#tag Note
			The arguments represent the query string part of the URI.
			
			e.g.
			
			http://example.net/index.html?QUERYSTRING
			
			Each argument in the query string is delimited by an ampersang (&):
			
			http://example.net/index.html?QUERYSTRING1&QUERYSTRING2=2&QUERYSTRING3
			
			Arguments are stored and returned in the same order they are received as an
			array of strings. When converted to a string, the URI class uses the Join
			method on the array with an ampersand as the delimiter. Ampersands are stripped
			from strings being converted to URIs.
		#tag EndNote
		Arguments() As String
	#tag EndProperty

	#tag Property, Flags = &h0
		CaseSensitive As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The Fully-Qualified Domain Name.
			
			e.g.
			
			sub.domain.tld
			domain.tld
			sub1.sub2.->sub[n].domain.tld
		#tag EndNote
		FQDN As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The URI fragment, or anchor.
			
			e.g.
			
			www.example.net/contents.html#FRAGMENT
		#tag EndNote
		Fragment As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The password is never present without a Username and will be ignored if the Username is not set.
			
			mailto URIs never have a password part.
		#tag EndNote
		Password As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			Specifies the port number part of the URI. If this property is 0 then it's ignored for conversion/comparison purposes.
			
			e.g.
			
			   Dim url1 As New URI("http://www.example.net")
			   Dim url2 As New URI("http://www.example.net")
			   url2.Port = 0
			   
			url1 and url2 would still be equivalent since converting them to strings yields the same result "http://www.example.net"
			
			However,
			
			   Dim url1 As New URI("http://www.example.net")
			   Dim url2 As New URI("http://www.example.net")
			   url2.Port = 80
			
			in this case, url1 and url2 are not equal since url1 converts to "http://www.example.net" whereas 
			url2 converts to "http://www.example.net:80"
			
			This class does not know about default ports and will explicitly specify any port assigned, even the default
			port for the specified protocol. To indicate the default port, then, just set the port to 0 or don't set it at all.
		#tag EndNote
		Port As Integer
	#tag EndProperty

	#tag Property, Flags = &h0
		Protocol As String
	#tag EndProperty

	#tag Property, Flags = &h0
		#tag Note
			The full remote file path, if any.
			
			e.g.
			
			/dir/dir2/dir3/dir4/file.ext
			/search.php
			/files/download.asp
			/index.html
			/  (top directory or default page, same as empty string)
			"" (empty string)
		#tag EndNote
		ServerFile As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Username As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="CaseSensitive"
			Group="Behavior"
			InitialValue="False"
			Type="Boolean"
		#tag EndViewProperty
		#tag ViewProperty
			Name="FQDN"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
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
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Protocol"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ServerFile"
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
