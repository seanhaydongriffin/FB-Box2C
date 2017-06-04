
' #INDEX# =======================================================================================================================
' Title .........: Box2C
' FreeBasic Version : ?
' Language ......: English
' Description ...: SFML Functions.
' Author(s) .....: Sean Griffin
' Dlls ..........: Box2C.dll
' ===============================================================================================================================

' #ENUMERATIONS# ===================================================================================================================
' ===============================================================================================================================


' #TYPES# ===================================================================================================================
type b2Vec2
    x as Single
    y as Single
end type

type b2PolygonShapePortable
    m_type as integer
    m_radius as single
    m_centroid_x as single
    m_centroid_y as single
    m_vertice_1_x as single
    m_vertice_1_y as single
    m_vertice_2_x as single
    m_vertice_2_y as single
    m_vertice_3_x as single
    m_vertice_3_y as single
    m_vertice_4_x as single
    m_vertice_4_y as single
    m_vertice_5_x as single
    m_vertice_5_y as single
    m_vertice_6_x as single
    m_vertice_6_y as single
    m_vertice_7_x as single
    m_vertice_7_y as single
    m_vertice_8_x as single
    m_vertice_8_y as single
    m_normal_1_x as single
    m_normal_1_y as single
    m_normal_2_x as single
    m_normal_2_y as single
    m_normal_3_x as single
    m_normal_3_y as single
    m_normal_4_x as single
    m_normal_4_y as single
    m_normal_5_x as single
    m_normal_5_y as single
    m_normal_6_x as single
    m_normal_6_y as single
    m_normal_7_x as single
    m_normal_7_y as single
    m_normal_8_x as single
    m_normal_8_y as single
    m_vertexCount as integer
end type

' ===============================================================================================================================

' #SUBROUTINES# ===================================================================================================================
' ===============================================================================================================================
	
' #FUNCTIONS# ===================================================================================================================
Dim Shared b2world_constructor As Function (byval gravity As b2Vec2, byval doSleep as Boolean) As Long Ptr

Declare Sub _Box2C_Startup
Declare Sub _Box2C_Shutdown
Declare Function _Box2C_b2World_Constructor(byval gravity As b2Vec2, byval doSleep as Boolean) As Long Ptr
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
Function _Box2C_b2PolygonShape_Constructor(byval vertices As b2Vec2) As Long Ptr

    Dim As b2PolygonShapePortable polygon_shape_portable => (1, 0.01, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 4)
    Dim As b2PolygonShapePortable ptr polygon_shape_portable_ptr = @polygon_shape_portable
    
	_Box2C_b2PolygonShape_Set(polygon_shape_portable_ptr, vertices)

	Return $polygon_shape_portable
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
Function _Box2C_b2PolygonShape_Set(byval polygon_shape_portable_ptr As b2PolygonShapePortable ptr) As Long Ptr


End Function


Func _Box2C_b2PolygonShape_Set($polygon_shape_portable_ptr, $vertices)

	local $polygon_shape_portable = DllStructCreate("STRUCT;int;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;float;int;ENDSTRUCT", $polygon_shape_portable_ptr)
	Local $normals[UBound($vertices)][2]

	Local $polygon_shape_portable_element_num
	Local $vertice_num = -1

	; Compute the polygon centroid.

	Local $centroid = _Box2C_b2PolygonShape_ComputeCentroid($vertices)

	DllStructSetData($polygon_shape_portable, 3, $centroid[0])
	DllStructSetData($polygon_shape_portable, 4, $centroid[1])


	; Shift the shape, meaning it's center and therefore it's centroid, to the world position of 0,0, such that rotations and calculations are easier

	for $vertice_num = 0 to (UBound($vertices) - 1)

		$vertices[$vertice_num][0] = $vertices[$vertice_num][0] - $centroid[0]
		$vertices[$vertice_num][1] = $vertices[$vertice_num][1] - $centroid[1]
	Next


	$polygon_shape_portable_element_num = 4

	for $vertice_num = 0 to (UBound($vertices) - 1)

		$polygon_shape_portable_element_num = $polygon_shape_portable_element_num + 1
		DllStructSetData($polygon_shape_portable, $polygon_shape_portable_element_num, $vertices[$vertice_num][0])
		$polygon_shape_portable_element_num = $polygon_shape_portable_element_num + 1
		DllStructSetData($polygon_shape_portable, $polygon_shape_portable_element_num, $vertices[$vertice_num][1])
	Next

	; Compute normals. Ensure the edges have non-zero length.

	$polygon_shape_portable_element_num = 20

	for $i = 0 to (UBound($vertices) - 1)

		Local $i1 = $i
		Local $i2 = 0

		if ($i + 1) < UBound($vertices) Then

			$i2 = $i + 1
		EndIf

		Local $edge_x = $vertices[$i2][0] - $vertices[$i1][0]
		Local $edge_y = $vertices[$i2][1] - $vertices[$i1][1]

		Local $edge_cross = _Box2C_b2PolygonShape_CrossProductVectorScalar($edge_x, $edge_y, 1)

		$normals[$i][0] = $edge_cross[0]
		$normals[$i][1] = $edge_cross[1]

		Local $normal_normalised = _Box2C_b2PolygonShape_Normalize($normals[$i][0], $normals[$i][1])

		$polygon_shape_portable_element_num = $polygon_shape_portable_element_num + 1
		DllStructSetData($polygon_shape_portable, $polygon_shape_portable_element_num, $normal_normalised[0])
		$polygon_shape_portable_element_num = $polygon_shape_portable_element_num + 1
		DllStructSetData($polygon_shape_portable, $polygon_shape_portable_element_num, $normal_normalised[1])

;		$normals[$i][0] = $normal_normalised[0]
;		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $normals[$i][0] = ' & $normals[$i][0] & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
;		$normals[$i][1] = $normal_normalised[1]
;		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $normals[$i][1] = ' & $normals[$i][1] & @CRLF & '>Error code: ' & @error & @CRLF) ;### Debug Console
	Next


	; Vertex Count

	DllStructSetData($polygon_shape_portable, 37, UBound($vertices))


;	for $i = 0 to (UBound($vertices) - 1)

;		_internalPolyShape.m_vertices[i] = verts[i];
;		_internalPolyShape.m_normals[i] = normals[i];
;	Next

;	VertexCount = verts.Length;


EndFunc
