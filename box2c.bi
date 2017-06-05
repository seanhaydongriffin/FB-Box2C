
' #INDEX# =======================================================================================================================
' Title .........: Box2C
' FreeBasic Version : ?
' Language ......: English
' Description ...: SFML Functions.
' Author(s) .....: Sean Griffin
' Dlls ..........: Box2C.dll
' ===============================================================================================================================

' #CONSTANTS# ===================================================================================================================
Const as single __epsilon = 0.00001
' ===============================================================================================================================


' #ENUMERATIONS# ===================================================================================================================
Enum Box2C_b2Shape_m_type
    Box2C_e_circle
    Box2C_e_edge
    Box2C_e_polygon
    Box2C_e_chain
    Box2C_e_typeCount
End Enum

Enum Box2C_b2Body_type
    Box2C_b2_staticBody
    Box2C_b2_kinematicBody
    Box2C_b2_dynamicBody
End Enum
' ===============================================================================================================================


' #TYPES# ===================================================================================================================
type b2Vec2
    x as Single
    y as Single
end type


type b2PolygonShapePortable
    m_type as integer
    m_radius as single
    m_centroid as b2Vec2
    m_vertice(8) as b2Vec2
    m_normal(8) as b2Vec2
    m_vertexCount as integer
end type

type b2BodyDef
    type2 as integer
    position as b2Vec2
    angle as single
    linerVelocity as b2Vec2
    angularVelocity as single
    linearDamping as single
    angularDamping as single
    allowSleep as boolean
    awake as boolean
    fixedRotation as boolean
    bullet as boolean
    active as boolean
    userData as long ptr
    gravityScale as single
end type

' ===============================================================================================================================

	
' #FUNCTIONS# ===================================================================================================================
Dim Shared b2world_constructor As Function (byval gravity As b2Vec2, byval doSleep as Boolean) As Long Ptr

Declare Sub _Box2C_Startup
Declare Sub _Box2C_Shutdown
Declare Function _Box2C_b2Vec2_Length(vector as b2Vec2) as single
Declare Function _Box2C_b2World_Constructor(byval gravity As b2Vec2, byval doSleep as Boolean) As Long Ptr
Declare Function _Box2C_b2PolygonShape_Constructor(vertices() As b2Vec2) As b2PolygonShapePortable
Declare Sub _Box2C_b2PolygonShape_Set(byref polygon_shape_portable As b2PolygonShapePortable, vertices() As b2Vec2)
Declare Function _Box2C_b2PolygonShape_ComputeCentroid(vertices() As b2Vec2) As b2Vec2
Declare Function _Box2C_b2PolygonShape_CrossProductVectorVector(x1 as single, y1 as single, x2 as single, y2 as single) as single
Declare Function _Box2C_b2PolygonShape_CrossProductVectorScalar(x as single, y as single, s as single) as b2Vec2
Declare Function _Box2C_b2PolygonShape_Normalize(vector as b2Vec2) as b2Vec2
Declare Function _Box2C_b2BodyDef_Constructor(type2 as integer = 2, position_x as single = 0, position_y as single = 0, angle as single = 0, linerVelocity_x as single = 0, linerVelocity_y as single = 0, angularVelocity as single = 0, linearDamping as single = 0, angularDamping as single = 0, allowSleep as boolean = 1, awake as boolean = 1, fixedRotation as boolean = 0, bullet as boolean = 0, active as boolean = 1, userData as long ptr = NULL, gravityScale as single = 1) As b2BodyDef
' ===============================================================================================================================

' #VARIABLES# ===================================================================================================================
Dim Shared As Any Ptr box2c_library
' ===============================================================================================================================


' #MISCELLANEOUS FUNCTIONS# =====================================================================================================


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_Startup
' Description ...: Loads the CSFML DLLs
' Syntax.........: _CSFML_Startup
' Parameters ....: 
' Return values .: 
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_Shutdown
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_Startup

	' load the CSFML DLLs
	box2c_library = DyLibLoad( "Box2C.dll" )
	
	' create the Box2C library functions for the Box2C DLL
	b2world_constructor = DyLibSymbol( box2c_library, "b2world_constructor" )

End Sub

' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_Shutdown
' Description ...: Unloads the CSFML DLLs
' Syntax.........: _CSFML_Shutdown()
' Parameters ....:
' Return values .: None
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_Startup
' Link ..........:
' Example .......:
' ===============================================================================================================================
sub _Box2C_Shutdown

	' unload the DLLs
	DylibFree( csfml_system_library )
	DylibFree( csfml_graphics_library )
	DylibFree( csfml_window_library )

End sub


' #SFCLOCK FUNCTIONS# =====================================================================================================



' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Vec2_Length
' Description ...: Gets the length of a vector.
' Syntax.........: _Box2C_b2Vec2_Length($x, $y)
' Parameters ....: $x - horizontal component (pixel position) of the vector
'				   $y - vertical component (pixel position) of the vector
' Return values .: Success - the length of the vector
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2Vec2_Length(vector as b2Vec2) as single

	Return sqr(vector.x * vector.x + vector.y * vector.y)
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2World_Constructor
' Description ...: Constructs a b2World structure.
' Syntax.........: _Box2C_b2World_Constructor($gravity, $doSleep)
' Parameters ....: $gravity - gravity
'				   $doSleep - ?
' Return values .: Success - a pointer (PTR) to the b2World structure (PTR).
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2World_Constructor(byval gravity As b2Vec2, byval doSleep as Boolean) As Long Ptr
    
	Dim As Long Ptr fred = b2world_constructor(gravity, doSleep)
	Return fred
End Function



' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2PolygonShape_Constructor
' Description ...: Constructs a b2PolygonShape structure.
' Syntax.........: _Box2C_b2PolygonShape_Constructor($vertices)
' Parameters ....: $vertices - the vertices of the polygon to construct
' Return values .: Success - the b2PolygonShape structure (STRUCT).
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2PolygonShape_Constructor(vertices() As b2Vec2) As b2PolygonShapePortable

'    Dim As b2PolygonShapePortable polygon_shape_portable => (1, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4)
    Dim As b2PolygonShapePortable polygon_shape_portable => (1, 0.01, (0, 0), {(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)}, {(0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0), (0, 0)}, 0)
'    Dim As b2PolygonShapePortable ptr polygon_shape_portable_ptr = @polygon_shape_portable

	_Box2C_b2PolygonShape_Set(polygon_shape_portable, vertices())

	Return polygon_shape_portable
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2PolygonShape_Set
' Description ...: Creates a fixture for a shape and body combination
' Syntax.........: _Box2C_b2PolygonShape_Set($polygon_shape_portable_ptr, $vertices)
' Parameters ....: $polygon_shape_portable_ptr - a pointer to the body (b2Body)
'				   $vertices - a pointer to the shape (b2...)
' Return values .: None
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......: There is no return value for this function.  It simply repopulates the structure pointed to by $polygon_shape_portable_ptr
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2PolygonShape_Set(byref polygon_shape_portable As b2PolygonShapePortable, vertices() As b2Vec2)

    dim as b2Vec2 normals(ubound(vertices))
    
   
	' Compute the polygon centroid.

	dim as b2Vec2 centroid = _Box2C_b2PolygonShape_ComputeCentroid(vertices())
    polygon_shape_portable.m_centroid.x = centroid.x
    polygon_shape_portable.m_centroid.y = centroid.y
	
    ' Shift the shape, meaning it's center and therefore it's centroid, to the world position of 0,0, such that rotations and calculations are easier

	for vertice_num as integer = 0 to (UBound(vertices) - 1)

		vertices(vertice_num).x = vertices(vertice_num).x - centroid.x
		vertices(vertice_num).y = vertices(vertice_num).y - centroid.y
	Next

    dim as integer polygon_shape_portable_element_num = 4
    
	for vertice_num as integer = 0 to (UBound(vertices) - 1)

        polygon_shape_portable.m_vertice(vertice_num).x = vertices(vertice_num).x
        polygon_shape_portable.m_vertice(vertice_num).y = vertices(vertice_num).y
	Next
    
    ' Compute normals. Ensure the edges have non-zero length.

	for i as integer = 0 to (UBound(vertices) - 1)

		dim as integer i1 = i
		dim as integer i2 = 0

		if (i + 1) < UBound(vertices) Then

			i2 = i + 1
		EndIf

		dim as single edge_x = vertices(i2).x - vertices(i1).x
		dim as single edge_y = vertices(i2).y - vertices(i1).y

		dim as b2Vec2 edge_cross = _Box2C_b2PolygonShape_CrossProductVectorScalar(edge_x, edge_y, 1)

		normals(i).x = edge_cross.x
		normals(i).y = edge_cross.y

		dim as b2Vec2 normal_normalised = _Box2C_b2PolygonShape_Normalize(normals(i))

        polygon_shape_portable.m_normal(i).x = normal_normalised.x
        polygon_shape_portable.m_normal(i).y = normal_normalised.y
    next

	' Vertex Count
    polygon_shape_portable.m_vertexCount = ubound(vertices)

End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2PolygonShape_ComputeCentroid
' Description ...:
' Syntax.........: _Box2C_b2PolygonShape_ComputeCentroid($vertices)
' Parameters ....: $x -
'				   $y -
' Return values .: A vector (2D element array) of the centroid of the vertices
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2PolygonShape_ComputeCentroid(vertices() As b2Vec2) As b2Vec2

    dim as b2Vec2 centroid
    dim as single area = 0

	if UBound(vertices) = 2 Then

		centroid.x = 0.5 * (vertices(0).x + vertices(1).x)
		centroid.y = 0.5 * (vertices(0).y + vertices(1).y)
	EndIf

	' pRef is the reference point for forming triangles.
	' It's location doesn't change the result (except for rounding error).

    dim as integer pRef_x = 0, pRef_y = 0
    dim as integer inv3 = 1 / 3

	for i as integer = 0 to (UBound(vertices) - 1)

		dim as integer p1_x = pRef_x
		dim as integer p1_y = pRef_y
		dim as single p2_x = vertices(i).x
		dim as single p2_y = vertices(i).y
		dim as single p3_x, p3_y

		if (i + 1) < UBound(vertices) Then

			p3_x = vertices(i + 1).x
			p3_y = vertices(i + 1).y
		Else

			p3_x = vertices(0).x
			p3_y = vertices(0).y
		EndIf

		dim as single e1_x = p2_x - p1_x
		dim as single e1_y = p2_y - p1_y
		dim as single e2_x = p3_x - p1_x
		dim as single e2_y = p3_y - p1_y

		dim as single D = _Box2C_b2PolygonShape_CrossProductVectorVector(e1_x, e1_y, e2_x, e2_y)

		dim as single triangleArea = 0.5 * D
		area = area + triangleArea

		' Area weighted centroid
		centroid.x = centroid.x + (triangleArea * inv3 * (p1_x + p2_x + p3_x))
		centroid.y = centroid.y + (triangleArea * inv3 * (p1_y + p2_y + p3_y))

    next
    
	centroid.x = centroid.x * (1 / area)
	centroid.y = centroid.y * (1 / area)

	Return centroid
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2PolygonShape_CrossProductVectorVector
' Description ...:
' Syntax.........: _Box2C_b2PolygonShape_CrossProductVectorVector($x1, $y1, $x2, $y2)
' Parameters ....: $x1 -
'				   $y1 -
'				   $x2 -
'				   $y2 -
' Return values .:
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2PolygonShape_CrossProductVectorVector(x1 as single, y1 as single, x2 as single, y2 as single) as single

	Return (x1 * y2) - (y1 * x2)
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2PolygonShape_CrossProductVectorScalar
' Description ...:
' Syntax.........: _Box2C_b2PolygonShape_CrossProductVectorScalar($x, $y, $s)
' Parameters ....: $x -
'				   $y -
'				   $s -
' Return values .:
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2PolygonShape_CrossProductVectorScalar(x as single, y as single, s as single) as b2Vec2

    dim as b2Vec2 vector

    vector.x = s * y
	vector.y = -s * x

	Return vector
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2PolygonShape_Normalize
' Description ...:
' Syntax.........: _Box2C_b2PolygonShape_Normalize($x, $y)
' Parameters ....: $x -
'				   $y -
' Return values .:
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2PolygonShape_Normalize(vector as b2Vec2) as b2Vec2

    dim as b2Vec2 vector_out
	dim as single length = _Box2C_b2Vec2_Length(vector)

	if length < __epsilon Then

        vector_out.x = 0
        vector_out.y = 0
		Return vector_out
	EndIf

	dim as single invLength = 1 / length

	vector_out.x = vector.x * invLength
	vector_out.y = vector.y * invLength

	Return vector_out
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2BodyDef_Constructor
' Description ...: Constructs a b2BodyDef structure for a box shape.
' Syntax.........: _Box2C_b2BodyDef_Constructor($type, $position_x, $position_y, $angle, $linearVelocity_x, $linearVelocity_y, $angularVelocity, $linearDamping, $angularDamping, $allowSleep, $awake, $fixedRotation, $bullet, $active, $userData, $gravityScale)
' Parameters ....: $type -
'				   $position_x -
'				   $position_y -
'				   $angle -
'				   $linearVelocity_x -
'				   $linearVelocity_y -
'				   $angularVelocity -
'				   $linearDamping -
'				   $angularDamping -
'				   $allowSleep -
'				   $awake -
'				   $fixedRotation -
'				   $bullet -
'				   $active -
'				   $userData -
'				   $gravityScale -
' Return values .: Success - the b2BodyDef structure (STRUCT).
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2BodyDef_Constructor(type2 as integer = 2, position_x as single = 0, position_y as single = 0, angle as single = 0, linerVelocity_x as single = 0, linerVelocity_y as single = 0, angularVelocity as single = 0, linearDamping as single = 0, angularDamping as single = 0, allowSleep as boolean = 1, awake as boolean = 1, fixedRotation as boolean = 0, bullet as boolean = 0, active as boolean = 1, userData as long ptr = NULL, gravityScale as single = 1) As b2BodyDef

    Dim As b2BodyDef body_def => (type2, (position_x, position_y), angle, (linerVelocity_x, linerVelocity_y), angularVelocity, linearDamping, angularDamping, allowSleep, awake, fixedRotation, bullet, active, userData, gravityScale)
	Return body_def
End Function



