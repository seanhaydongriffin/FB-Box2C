
' #INDEX# =======================================================================================================================
' Title .........: Box2CEx
' FreeBasic Version : ?
' Language ......: English
' Description ...: Box2C Extended Functions.
' Author(s) .....: Sean Griffin
' Dlls ..........: Box2C.dll
' ===============================================================================================================================

' #ENUMERATIONS# ===================================================================================================================
' ===============================================================================================================================


' #TYPES# ===================================================================================================================
' ===============================================================================================================================

' #SUBROUTINES# ===================================================================================================================
' ===============================================================================================================================
	
' #FUNCTIONS# ===================================================================================================================
Declare Sub _Box2C_Startup
Declare Sub _Box2C_Shutdown
Declare Function _Box2C_b2World_Constructor(byval gravity As b2Vec2, byval doSleep as Boolean) As Long Ptr
' ===============================================================================================================================

' #VARIABLES# ===================================================================================================================
' ===============================================================================================================================


' #MISCELLANEOUS FUNCTIONS# =====================================================================================================



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
' Name...........: _Box2C_b2ShapeDict_AddItem_SFML
' Description ...: A convenience function for SFML that adds a polygon shape (b2PolygonShape) to an internal array of shapes.
' Syntax.........: _Box2C_b2ShapeDict_AddItem_SFML($type, $radius_vertice, $shape_image_file_path)
' Parameters ....: $type - the type of shape:
'						$Box2C_e_circle (0) = a circle shape
'						$Box2C_e_edge (1) = an edge shape
'						$Box2C_e_polygon (2) = a polygon shape
'						$Box2C_e_chain (3) = a chain shape
'				   $radius_vertice:
'						for a $type of $Box2C_e_circle this is the radius of the circle
'						for a $type of $Box2C_e_edge this is a two dimensional vector array of the edges of the polygon
'				   $shape_image_file_path - the path to the image file of the shape to add
' Return values .: The index of the shape within the internal array of shapes.
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Func _Box2C_b2ShapeDict_AddItem_SFML($type, $radius_vertice, $shape_image_file_path)

	; create a new Box2C Polygone Shape for the new vertices and add it to the internal array of shape structures
	Local $tmp_shape_struct

	Switch $type

		case $Box2C_e_circle

			$tmp_shape_struct = _Box2C_b2CircleShape_Constructor($radius_vertice)

		case $Box2C_e_edge

			$tmp_shape_struct = _Box2C_b2PolygonShape_Constructor($radius_vertice)
	EndSwitch

	Local $tmp_shape_struct_ptr = DllStructGetPtr($tmp_shape_struct)
	Local $tmp_shape_struct_ptr_str = String($tmp_shape_struct_ptr)
	$__shape_struct_ptr_dict.Add($tmp_shape_struct_ptr_str, $tmp_shape_struct_ptr_str)
	$__shape_struct_dict.Add($tmp_shape_struct_ptr_str, $tmp_shape_struct)

	; add the new vertices to the internal dictionary of shape vertices

	if $type = $Box2C_e_edge Then

		$__shape_vertice_dict.Add($tmp_shape_struct_ptr_str, $radius_vertice)
	EndIf

	; add the new sfTexture to the internal array of shape images
	$__shape_image_file_path_dict.Add($tmp_shape_struct_ptr_str, $shape_image_file_path)

	Local $tmp_shape_image = _CSFML_sfTexture_createFromFile($shape_image_file_path, Null)
	$__shape_image_dict.Add($tmp_shape_struct_ptr_str, $tmp_shape_image)

	; return the pointer (dictionary key) of the new shape
	Return $tmp_shape_struct_ptr_str
EndFunc
