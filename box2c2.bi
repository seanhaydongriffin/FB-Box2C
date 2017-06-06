
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

type b2Vec3
 '   a as single
'    b as single
    x(2) as single
    'y as single
  '  a as single
end type

type b2PolygonShapePortable
    m_type as integer
    m_radius as single
    m_centroid as b2Vec2
    m_vertice(8) as b2Vec2
    m_normal(8) as b2Vec2
    m_vertexCount as integer
end type

'type b2BodyDef
'    type2 as integer
'    position as b2Vec2
'    angle as single
'    linerVelocity as b2Vec2
'    angularVelocity as single
'    linearDamping as single
'    angularDamping as single
'    allowSleep as boolean
'    awake as boolean
'    fixedRotation as boolean
'    bullet as boolean
'    active as boolean
'    userData as long ptr
'    gravityScale as single
'end type


type b2BodyDef
    type2 as integer
    position_x as single
    position_y as single
    angle as single
end type

type b2FixtureDef
    categoryBits as ushort
    maskBits as ushort
    groupIndex as short
end type

' ===============================================================================================================================

	
' #FUNCTIONS# ===================================================================================================================
Dim Shared b2world_constructor As Function (byval gravity As b2Vec2, byval doSleep as Boolean) As Long Ptr
Dim Shared b2body_createfixturefromshape As Function (byval body_ptr As long ptr, byval shape_ptr as b2PolygonShapePortable ptr, byval density as single) As long ptr
Dim Shared b2fixture_setdensity As Sub (byval fixture_ptr As Long Ptr, byval value as single)
Dim Shared b2fixture_setrestitution As Sub (byval fixture_ptr As Long Ptr, byval value as single)
Dim Shared b2fixture_setfriction As Sub (byval fixture_ptr As Long Ptr, byval value as single)
Dim Shared b2fixture_setfilterdata As Sub (byval fixture_ptr As Long Ptr, byval dynamicBox_fixture_filter as b2FixtureDef)
Dim Shared b2fixture_setsensor As Sub (byval fixture_ptr As Long Ptr, byval value as boolean)
Dim Shared b2fixture_setuserdata As Sub (byval fixture_ptr As Long Ptr, byval user_data as Long Ptr)
Dim Shared b2world_createbody As Function (byval world_ptr As long ptr, byval bodyDef_ptr as b2BodyDef ptr) As long ptr
Dim Shared b2body_setawake As Sub (byval body_ptr As Long Ptr, byval awake as boolean)
Dim Shared b2body_getangle As Function (byval body_ptr As long ptr) As single
Dim Shared b2body_settransform As Sub (byval body_ptr As Long Ptr, byval position as b2Vec2, byval angle as single)
Dim Shared b2body_getposition As Sub (byval body_ptr As Long Ptr, byref position as b2Vec3 Ptr)
Dim Shared b2world_step As Sub (byval world_ptr As Long Ptr, byval timeStep as single, byval velocityIterations as integer, byval positionIterations as integer)

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
Declare Function _Box2C_b2World_CreateFixtureFromShape(byval body_ptr As long ptr, byval shape_ptr as b2PolygonShapePortable ptr, byval density as single) As long ptr
Declare Sub _Box2C_b2Fixture_SetDensity(byval fixture_ptr As Long Ptr, byval value as single)
Declare Sub _Box2C_b2Fixture_SetRestitution(byval fixture_ptr As Long Ptr, byval value as single)
Declare Sub _Box2C_b2Fixture_SetFriction(byval fixture_ptr As Long Ptr, byval value as single)
Declare Sub _Box2C_b2Fixture_SetFilterData(byval fixture_ptr As Long Ptr, byval dynamicBox_fixture_filter as b2FixtureDef)
Declare Sub _Box2C_b2Fixture_SetSensor(byval fixture_ptr As Long Ptr, byval value as boolean)
Declare Sub _Box2C_b2Fixture_SetUserData(byval fixture_ptr As Long Ptr, byval user_data as Long Ptr)
Declare Function _Box2C_b2World_CreateBody(byval world_ptr As long ptr, byval bodyDef_ptr as b2BodyDef ptr) As long ptr
Declare Sub _Box2C_b2Body_SetAwake(byval body_ptr As Long Ptr, byval awake as boolean)
Declare Function _Box2C_b2Body_GetAngle(byval body_ptr As long ptr) As single
Declare Sub _Box2C_b2Body_SetPosition(byval body_ptr As Long Ptr, byval x as single, byval y as single)
'Declare Function _Box2C_b2Body_GetPosition(byval body_ptr As Long Ptr) as b2Vec2
'Declare Sub _Box2C_b2Body_SetAngle(byval body_ptr As Long Ptr, byval angle as single)
Declare Sub _Box2C_b2World_Step(byval world_ptr As Long Ptr, byval timeStep as single, byval velocityIterations as integer, byval positionIterations as integer)
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
	b2body_createfixturefromshape = DyLibSymbol( box2c_library, "b2body_createfixturefromshape" )
	b2fixture_setdensity = DyLibSymbol( box2c_library, "b2fixture_setdensity" )
	b2fixture_setrestitution = DyLibSymbol( box2c_library, "b2fixture_setrestitution" )
	b2fixture_setfriction = DyLibSymbol( box2c_library, "b2fixture_setfriction" )
	b2fixture_setfilterdata = DyLibSymbol( box2c_library, "b2fixture_setfilterdata" )
	b2fixture_setsensor = DyLibSymbol( box2c_library, "b2fixture_setsensor" )
	b2fixture_setuserdata = DyLibSymbol( box2c_library, "b2fixture_setuserdata" )
	b2world_createbody = DyLibSymbol( box2c_library, "b2world_createbody" )
	b2body_setawake = DyLibSymbol( box2c_library, "b2body_setawake" )
	b2body_getangle = DyLibSymbol( box2c_library, "b2body_getangle" )
	b2body_settransform = DyLibSymbol( box2c_library, "b2body_settransform" )
	b2body_getposition = DyLibSymbol( box2c_library, "b2body_getposition" )
	b2world_step = DyLibSymbol( box2c_library, "b2world_step" )

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

    Dim As b2BodyDef body_def '=> (type2, (position_x, position_y), angle, (linerVelocity_x, linerVelocity_y), angularVelocity, linearDamping, angularDamping, allowSleep, awake, fixedRotation, bullet, active, userData, gravityScale)
	Return body_def
End Function



' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2World_CreateFixture
' Description ...: Creates a fixture for a shape and body combination
' Syntax.........: _Box2C_b2World_CreateFixture($body_ptr, $shape_ptr, $density, $restitution, $friction, $filter_category_bits, $filter_mask_bits, $filter_group_index, $is_sensor, $user_data)
' Parameters ....: $body_ptr - a pointer to the body (b2Body)
'				   $shape_ptr - a pointer to the shape (b2...)
'				   $density -
'				   $restitution -
'				   $friction -
'				   $filter_category_bits -
'				   $filter_mask_bits -
'				   $filter_group_index -
'				   $is_sensor -
'				   $user_data -
' Return values .: Success - a pointer (PTR) to the fixture (b2Fixture) structure
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2World_CreateFixture(byval body_ptr as long ptr, byval shape_ptr as b2PolygonShapePortable ptr, byval density as single, byval restitution as single, byval friction as single, byval filter_category_bits as ushort = 1, byval filter_mask_bits as ushort = 65535, byval filter_group_index as short = 0, byval is_sensor as boolean = 0, byval user_data as long ptr = NULL) As long ptr

	Dim As long ptr fixture_ptr = _Box2C_b2World_CreateFixtureFromShape(body_ptr, shape_ptr, density)

'    _Box2C_b2Fixture_SetDensity(fixture_ptr, 1)
    _Box2C_b2Fixture_SetRestitution(fixture_ptr, restitution)
    _Box2C_b2Fixture_SetFriction(fixture_ptr, friction)

    dim as b2FixtureDef dynamicBox_fixture_filter => (filter_category_bits, filter_mask_bits, filter_group_index)
    _Box2C_b2Fixture_SetFilterData(fixture_ptr, dynamicBox_fixture_filter)
    
    _Box2C_b2Fixture_SetSensor(fixture_ptr, is_sensor)
    _Box2C_b2Fixture_SetUserData(fixture_ptr, user_data)

	Return fixture_ptr
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2World_CreateFixtureFromShape
' Description ...: Creates a fixture for a shape and body combination
' Syntax.........: _Box2C_b2World_CreateFixtureFromShape($body_ptr, $shape_ptr, $density)
' Parameters ....: $body_ptr - a pointer to the body (b2Body)
'				   $shape_ptr - a pointer to the shape (b2...)
'				   $density -
' Return values .: Success - a pointer (PTR) to the fixture (b2Fixture) structure
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2World_CreateFixtureFromShape(byval body_ptr As long ptr, byval shape_ptr as b2PolygonShapePortable ptr, byval density as single) As long ptr
    
	Dim As long ptr fred3 = b2body_createfixturefromshape(body_ptr, shape_ptr, density)
	Return fred3
End function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Fixture_SetDensity
' Description ...: Sets the density of a fixture (b2Fixture)
' Syntax.........: _Box2C_b2Fixture_SetDensity($fixture_ptr, $value)
' Parameters ....: $fixture_ptr - a pointer to the fixture (b2Fixture)
'				   $value - the density value
' Return values .: Success - True
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2Fixture_SetDensity(byval fixture_ptr As Long Ptr, byval value as single)
	
	b2fixture_setdensity(fixture_ptr, value)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Fixture_SetRestitution
' Description ...: Sets the restitution of a fixture (b2Fixture)
' Syntax.........: _Box2C_b2Fixture_SetRestitution($fixture_ptr, $value)
' Parameters ....: $fixture_ptr - a pointer to the fixture (b2Fixture)
'				   $value - the restitution value
' Return values .: Success - True
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2Fixture_SetRestitution(byval fixture_ptr As Long Ptr, byval value as single)
	
	b2fixture_setrestitution(fixture_ptr, value)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Fixture_SetFriction
' Description ...: Sets the friction of a fixture (b2Fixture)
' Syntax.........: _Box2C_b2Fixture_SetFriction($fixture_ptr, $value)
' Parameters ....: $fixture_ptr - a pointer to the fixture (b2Fixture)
'				   $value - the friction value
' Return values .: Success - True
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2Fixture_SetFriction(byval fixture_ptr As Long Ptr, byval value as single)
	
	b2fixture_setfriction(fixture_ptr, value)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Fixture_SetFilterData
' Description ...: 
' Syntax.........: _Box2C_b2Fixture_SetFilterData(fixture_ptr, dynamicBox_fixture_filter)
' Parameters ....: 
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2Fixture_SetFilterData(byval fixture_ptr As Long Ptr, byval dynamicBox_fixture_filter as b2FixtureDef)

    b2fixture_setfilterdata(fixture_ptr, dynamicBox_fixture_filter)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Fixture_SetSensor
' Description ...: Sets the sensor of a fixture (b2Fixture)
' Syntax.........: _Box2C_b2Fixture_SetSensor($fixture_ptr, $value)
' Parameters ....: $fixture_ptr - a pointer to the fixture (b2Fixture)
'				   $value - True will turn the sensor on, False will turn the sensor off
' Return values .: Success - True
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2Fixture_SetSensor(byval fixture_ptr As Long Ptr, byval value as boolean)
	
	b2fixture_setsensor(fixture_ptr, value)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Fixture_SetUserData
' Description ...: 
' Syntax.........: _Box2C_b2Fixture_SetUserData(fixture_ptr, dynamicBox_fixture_filter)
' Parameters ....: 
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2Fixture_SetUserData(byval fixture_ptr As Long Ptr, byval user_data as Long Ptr)

    b2fixture_setuserdata(fixture_ptr, user_data)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2World_CreateBody
' Description ...: Creates a body in a world from a body definition
' Syntax.........: _Box2C_b2World_CreateBody($world_ptr, $bodyDef_ptr)
' Parameters ....: $world_ptr - a pointer (PTR) to the world (b2World) to create the body within
'				   $bodyDef_ptr - a pointer (PTR) to the definition of the body (b2BodyDef)
' Return values .: Success - a pointer (PTR) to the body (b2Body) structure (STRUCT)
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2World_CreateBody(byval world_ptr As long ptr, byval bodyDef_ptr as b2BodyDef ptr) As long ptr
    
	Dim As long ptr fred3 = b2world_createbody(world_ptr, bodyDef_ptr)
	Return fred3
End function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Body_SetAwake
' Description ...: Sets the awake state of a body (b2Body)
' Syntax.........: _Box2C_b2Body_SetAwake($body_ptr, $awake)
' Parameters ....: $body_ptr - a pointer to the body (b2Body)
'				   $awake - True for awake, False for sleep
' Return values .: Success - True
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2Body_SetAwake(byval body_ptr As Long Ptr, byval awake as boolean)
	
	b2body_setawake(body_ptr, awake)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Body_SetPosition
' Description ...: Sets the position (vector) of a body (b2Body)
' Syntax.........: _Box2C_b2Body_SetPosition($body_ptr, $x, $y)
' Parameters ....: $body_ptr - a pointer to the body (b2Body)
'				   $x - the horizontal position / vector
'				   $y - the vertical position / vector
' Return values .: Success - True
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2Body_SetPosition(byval body_ptr As Long Ptr, byval x as single, byval y as single)

'    dim as b2Vec2 position => (x, y)
    dim as b2Vec2 position
    position.x = 5.5
    position.y = 6.6
	dim as single angle = _Box2C_b2Body_GetAngle(body_ptr)
    b2body_settransform(body_ptr, position, angle)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Body_GetAngle
' Description ...: Gets the angle (radians) of a body (b2Body)
' Syntax.........: _Box2C_b2Body_GetAngle($body_ptr)
' Parameters ....: $body_ptr - a pointer to the body (b2Body)
' Return values .: The angle (radians) of the body (b2Body)
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2Body_GetAngle(byval body_ptr As long ptr) As single
    
	Dim As single fred3 = b2body_getangle(body_ptr)
    print "angle=" & fred3
	Return fred3
End function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Body_SetAngle
' Description ...: Sets the angle (radians) of a body (b2Body)
' Syntax.........: _Box2C_b2Body_SetAngle($body_ptr, $angle)
' Parameters ....: $body_ptr - a pointer to the body (b2Body)
'				   $angle - the angle (radians)
' Return values .: Success - True
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
'Sub _Box2C_b2Body_SetAngle(byval body_ptr As Long Ptr, byval angle as single)

'    dim as b2Vec2 position = _Box2C_b2Body_GetPosition(body_ptr)
'    b2body_settransform(body_ptr, position, angle)
'End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Body_GetPosition
' Description ...: Gets the position (vector) of a body (b2Body)
' Syntax.........: _Box2C_b2Body_GetPosition($body_ptr)
' Parameters ....: $body_ptr - a pointer to the body (b2Body)
' Return values .: A vector (2D element array) of the position of the body (b2Body)
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
'Function _Box2C_b2Body_GetPosition(byval body_ptr As Long Ptr) as b2Vec2

'    dim as b2Vec2 position
'    dim as b2Vec2 ptr position_ptr = @position
'    b2body_getposition(body_ptr, position_ptr)
'    print "position x = " & position.x & ", y = " & position.y
'    return position
'End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2World_Step
' Description ...: Creates a fixture for a shape and body combination
' Syntax.........: _Box2C_b2World_Step($world_ptr, $timeStep, $velocityIterations, $positionIterations)
' Parameters ....: $world_ptr - a pointer to the body (b2Body)
'				   $timeStep - a pointer to the shape (b2...)
'				   $velocityIterations -
'				   $positionIterations -
' Return values .: Success - True
'				   Failure - False
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2World_Step(byval world_ptr As Long Ptr, byval timeStep as single, byval velocityIterations as integer, byval positionIterations as integer)
	
	b2world_step(world_ptr, timeStep, velocityIterations, positionIterations)
End Sub



