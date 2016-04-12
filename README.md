This project implements a set of [REALstudio](http://www.realsoftware.com/realstudio/) object classes which together allow for easy manipulation of [URIs](https://en.wikipedia.org/wiki/Uniform_resource_identifier). Strictly speaking, only the UR**L** subset of the UR**I** specification is supported. Other subsets like UR**N**s are not supported.

URI instances may be converted to and from Strings as well as directly compared to other URI instances for equivalence.

Each Property of the [URI class](https://github.com/charonn0/RB-URI/wiki/URIHelpers.URI) represents a member of the actual URI being parsed; they may be manipulated independently of one another and in any order.

Assigning a string value to an instance of the URI class re-parses the entire URI using the assigned string. For example:
```vb.net
Dim t As URI = "http://www.example.com?hello=world" 't is now "http://www.example.com?hello=world"
t = "https://www.example.net" 't is now "https://www.example.net"
```

Manipulating the properties individually, however, does not re-parse the URI:
```vb.net
Dim t As New = "http://www.example.net/foo/bar.bat?Frell=27#Main" 'Create a URI  
t.Host = "www.example.com" 'Change the domain
ReDim t.Arguments(-1)  'Remove arguments
t.Scheme = "https" 'Change the protocol
't is now: "https://www.example.com/foo/bar.bat#Main"
```
