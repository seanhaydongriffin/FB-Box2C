
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
type shape
    vertice(8) as b2Vec2
    num_vertices as integer
    created as boolean
    box2c_shape as b2PolygonShapePortable
    image_file_path as string
    image_ptr as long ptr
end type
'    b2PolygonShape_ptr as long ptr

type fixture
    created as boolean
    fixture_ptr as long ptr
end type

type body_def
    created as boolean
    box2c_body_def as b2BodyDef
end type

type body
    created as boolean
    body_ptr as long ptr
end type
' ===============================================================================================================================

	
' #FUNCTIONS# ===================================================================================================================
'Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, xxx() as integer, byval guid As integer, byval shape_image_file_path as string) As integer
Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, byval vertice1x as single, byval vertice1y as single, byval vertice2x as single, byval vertice2y as single, byval vertice3x as single, byval vertice3y as single, byval vertice4x as single, byval vertice4y as single, byval vertice5x as single, byval vertice5y as single, byval vertice6x as single, byval vertice6y as single, byval vertice7x as single, byval vertice7y as single, byval vertice8x as single, byval vertice8y as single, byval num_vertices as integer, byval shape_image_file_path as string) As integer
'Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, radius_vertice_ptr As b2Vec2 ptr, byval shape_image_file_path as string) As integer
'Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, byval shape_image_file_path as string) As integer
Declare Function _Box2C_b2BodyDefDict_AddItem(byval body_type as integer, byval initial_x as single = 0, byval initial_y as single = 0, byval initial_angle as single = 0, byval linearDamping as single = 0, byval angularDamping as single = 0) As integer
Declare Function _Box2C_b2BodyDict_AddItem_SFML(byval bodydef_index as integer, byval shape_index as integer, density as single, restitution as single, friction as single, x as single, y as single, angle as single, out_of_bounds_behaviour as integer = 0, shape_x_pixel_offset as integer = 0, shape_y_pixel_offset as integer = 0) As integer

' ===============================================================================================================================

' #VARIABLES# ===================================================================================================================
Dim shared As Long Ptr __world_ptr
'dim shared as b2PolygonShapePortable ptr __shape_struct_ptr_arr()
'redim preserve __shape_struct_ptr_arr(0)
'dim shared as b2PolygonShapePortable __shape_struct_arr()
'redim preserve __shape_struct_arr(0)
'dim shared as b2Vec2 __shape_vertice_arr()
'redim preserve __shape_vertice_arr(0)
dim shared as shape __main_shape(100)
'redim __main_shape(0)
dim shared as fixture __main_fixture(100)
dim shared as body_def __main_body_def(100)
dim shared as body __main_body(100)



' ===============================================================================================================================


' #MISCELLANEOUS FUNCTIONS# =====================================================================================================



' #SFCLOCK FUNCTIONS# =====================================================================================================




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
Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, byval vertice1x as single, byval vertice1y as single, byval vertice2x as single, byval vertice2y as single, byval vertice3x as single, byval vertice3y as single, byval vertice4x as single, byval vertice4y as single, byval vertice5x as single, byval vertice5y as single, byval vertice6x as single, byval vertice6y as single, byval vertice7x as single, byval vertice7y as single, byval vertice8x as single, byval vertice8y as single, byval num_vertices as integer, byval shape_image_file_path as string) As integer
    
    ' find a main shape that hasn't been created (created = 0)
    dim as integer shape_index
    
    for shape_index = 0 to (ubound(__main_shape) - 1)
        
        if __main_shape(shape_index).created = 0 then
            
            exit for
        endif
    next
    
    ' add the vertices and image file path to the shape
    __main_shape(shape_index).vertice(0).x = vertice1x
    __main_shape(shape_index).vertice(0).y = vertice1y
    __main_shape(shape_index).vertice(1).x = vertice2x
    __main_shape(shape_index).vertice(1).y = vertice2y
    __main_shape(shape_index).vertice(2).x = vertice3x
    __main_shape(shape_index).vertice(2).y = vertice3y
    __main_shape(shape_index).vertice(3).x = vertice4x
    __main_shape(shape_index).vertice(3).y = vertice4y
    __main_shape(shape_index).vertice(4).x = vertice5x
    __main_shape(shape_index).vertice(4).y = vertice5y
    __main_shape(shape_index).vertice(5).x = vertice6x
    __main_shape(shape_index).vertice(5).y = vertice6y
    __main_shape(shape_index).vertice(6).x = vertice7x
    __main_shape(shape_index).vertice(6).y = vertice7y
    __main_shape(shape_index).vertice(7).x = vertice8x
    __main_shape(shape_index).vertice(7).y = vertice8y
    __main_shape(shape_index).num_vertices = num_vertices
    __main_shape(shape_index).created = 1
    __main_shape(shape_index).image_file_path = shape_image_file_path

    ' get a pointer to the shape in the array
    dim as shape ptr main_shape_ptr = @__main_shape(shape_index)
    

	' create a new Box2C Polygone Shape for the new vertices and add it to the internal array of shape structures
'	Local $tmp_shape_struct

'	Switch $type

'		case $Box2C_e_circle

'			$tmp_shape_struct = _Box2C_b2CircleShape_Constructor($radius_vertice)

'		case $Box2C_e_edge

'			Dim As b2PolygonShapePortable tmp_shape_struct = _Box2C_b2PolygonShape_Constructor(radius_vertice())
			__main_shape(shape_index).box2c_shape = _Box2C_b2PolygonShape_Constructor(*(main_shape_ptr).vertice(0))
'	EndSwitch

'    __main_shape(shape_index).b2PolygonShape_ptr = @tmp_shape_struct

	' add the new sfTexture to the internal array of shape images
    __main_shape(shape_index).image_ptr = sfTexture_createFromFile(__main_shape(shape_index).image_file_path, NULL)

	' return the pointer (dictionary key) of the new shape
	Return shape_index
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2BodyDefDict_AddItem
' Description ...: A convenience function that adds a body definition (b2BodyDef) to an internal array of body definitions.
' Syntax.........: _Box2C_b2BodyDefDict_AddItem($body_type, $initial_x, $initial_y, $initial_angle, $linearDamping, $angularDamping)
' Parameters ....: $body_type
'				   $initial_x
'				   $initial_y
'				   $initial_angle
'				   $linearDamping
'				   $angularDamping
' Return values .: The index of the body definition within the internal array of body definitions.
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2BodyDefDict_AddItem(byval body_type as integer, byval initial_x as single = 0, byval initial_y as single = 0, byval initial_angle as single = 0, byval linearDamping as single = 0, byval angularDamping as single = 0) As integer
    
    ' find a main body def that hasn't been created (created = 0)
    dim as integer body_def_index
    
    for body_def_index = 0 to (ubound(__main_body_def) - 1)
        
        if __main_body_def(body_def_index).created = 0 then
            
            exit for
        endif
    next
    
    __main_body_def(body_def_index).created = 1

	' create a new Box2C Body Definition for the body type, initial x and y and angles, and add it to the internal array of body definition structures
	__main_body_def(body_def_index).box2c_body_def = _Box2C_b2BodyDef_Constructor(body_type, initial_x, initial_y, initial_angle, 0, 0, 0, linearDamping, angularDamping, True, True, False, False, True, Null, 1)

	' return the index of the new body definition within the internal array of body definitions
	Return body_def_index
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2BodyDict_AddItem_SFML
' Description ...: A convenience function for SFML that adds a body (b2Body) and sprite to an internal (PTR) array of bodies and sprites.
' Syntax.........: _Box2C_b2BodyDict_AddItem_SFML($bodydef_index, $shape_index, $density, $restitution, $friction, $vertice, $initial_x, $initial_y)
' Parameters ....: $bodydef_index - the index of the body definition within the internal array of body definitions to create the body with
'				   $shape_index - the index of the shape within the internal arrays of shapes to create the body with
'				   $density - the density of the new body
'				   $restitution - the $restitution of the new body
'				   $friction - the $friction of the new body
'				   $x - the horizontal position of the new body (overriding the position from the BodyDef)
'						use blank string to skip
'				   $y - the vertical position of the new body (overriding the position from the BodyDef)
'						use blank string to skip
'				   $angle - the angle of the new body (overriding the angle from the BodyDef)
'						use blank string to skip
'				   $out_of_bounds_behaviour - a flag that indicates what bodies / sprites should do when they go outside the GUI area
'						0 = do nothing (keep animating)
'						1 = destroy the body / sprite
'						2 = bounce the linear velocity of the body / sprite (like bouncing off a wall)
'						3 = stop the linear velocity of the body / sprite (like hitting a wall)
'						4 = hide the sprite (do not draw) and sleep the body (stops moving in Box2D)
'				   $shape_x_pixel_offset - an offset for the sprite in relation to the Box2D body (in pixels), see remarks below
'				   $shape_y_pixel_offset - an offset for the sprite in relation to the Box2D body (in pixels), see remarks below
' Return values .: The index of the body within the internal array of bodies.
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......: The SFML SetPosition functions will by default draw the top-left corner of the sprite at the location
'				   you specify in those calls.  But Box2D will by default calculate a body with the centroid at this position
'				   (not the top-left of the body, like SFML).  Therefore, when the location of a Box2D body is passed into
'				   the SFML SetPosition functions, the sprite is drawn with it's top-left corner at the centre of the Box2D body.
'				   Usually this is not the desired behaviour.
'				   If you want to position the sprite properly over the centroid of the Box2D body then use the
'				   $shape_x_pixel_offset and $shape_y_pixel_offset parameters above.
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2BodyDict_AddItem_SFML(byval bodydef_index as integer, byval shape_index as integer, density as single, restitution as single, friction as single, x as single = 999999, y as single = 999999, angle as single, out_of_bounds_behaviour as integer = 0, shape_x_pixel_offset as integer = 0, shape_y_pixel_offset as integer = 0) As integer
    
    ' find a main body that hasn't been created (created = 0)
    dim as integer body_index
    
    for body_index = 0 to (ubound(__main_body) - 1)
        
        if __main_body(body_index).created = 0 then
            
            exit for
        endif
    next
    
    __main_body(body_index).created = 1

    Dim As Long Ptr bodydef_ptr = @__main_body_def(bodydef_index).box2c_body_def
    Dim As Long Ptr shape_ptr = @__main_shape(shape_index).box2c_shape

	' create a new Box2C Body for the index of the body definition supplied, and add it to the internal array of body structures
	__main_body(body_index).body_ptr = _Box2C_b2World_CreateBody(__world_ptr, bodydef_ptr)
	_Box2C_b2Body_SetAwake(__main_body(body_index).body_ptr, True)

	if x < 999999 And y < 999999 Then

		_Box2C_b2Body_SetPosition($tmp_body_struct_ptr, $x, $y)
	EndIf

	if IsNumber($angle) = True Then

		_Box2C_b2Body_SetAngle($tmp_body_struct_ptr, $angle)
	EndIf

	Local $tmp_shape_vertice = $__shape_vertice_dict.Item($shape_ptr)



	' add other attributes, such as the initial positions, angles and body widths and heights to the internal arrays for bodies
	$__body_prev_screen_x_dict.Add($tmp_body_struct_ptr_str, -1)
	$__body_prev_screen_y_dict.Add($tmp_body_struct_ptr_str, -1)
	$__body_curr_screen_x_dict.Add($tmp_body_struct_ptr_str, -1)
	$__body_curr_screen_y_dict.Add($tmp_body_struct_ptr_str, -1)
	$__body_prev_angle_degrees_dict.Add($tmp_body_struct_ptr_str, -1)
	$__body_curr_angle_degrees_dict.Add($tmp_body_struct_ptr_str, -1)
	$__body_width_dict.Add($tmp_body_struct_ptr_str, _ArrayMax($tmp_shape_vertice, 1, -1, -1, 0))
	$__body_height_dict.Add($tmp_body_struct_ptr_str, _ArrayMax($tmp_shape_vertice, 1, -1, -1, 1))
	$__body_out_of_bounds_behaviour_dict.Add($tmp_body_struct_ptr_str, $out_of_bounds_behaviour)
	$__body_draw_dict.Add($tmp_body_struct_ptr_str, True)

    
    
    
    ' find a main fixture that hasn't been created (created = 0)
    dim as integer fixture_index
    
    for fixture_index = 0 to (ubound(__main_fixture) - 1)
        
        if __main_fixture(fixture_index).created = 0 then
            
            exit for
        endif
    next
    
    __main_fixture(fixture_index).created = 1

   	' create a new Box2C Fixture for the index of the body created, and the index of the shape supplied, and other attributes supplied (density, restitution and friction), add it to the internal array of fixture structures
	__main_fixture(fixture_index).fixture_def = _Box2C_b2World_CreateFixture(__main_body(body_index).body_ptr, shape_ptr, density, restitution, friction)

	' get the GUI position of the initial (vector) position of the body, and add it to the internal array of body GUI positions

	if IsNumber($x) = False or IsNumber($y) = False Then

		local $b2BodyDef = DllStructCreate("STRUCT;int;float;float;float;float;float;float;float;float;bool;bool;bool;bool;bool;ptr;float;ENDSTRUCT", $bodydef_ptr)
		$x = DllStructGetData($b2BodyDef, 2)
		$y = DllStructGetData($b2BodyDef, 3)
	EndIf

	Local $tmp_gui_pos = _Box2C_b2Vec2_GetGUIPosition($x, $y, $__shape_vertice_dict($shape_ptr))
	_ArrayAdd($__body_gui_pos, $tmp_gui_pos[0] & "|" & $tmp_gui_pos[1])

	; add the index of the shape to the internal array of body shapes
;	_ArrayAdd($__body_shape_index, $shape_index)

	; Add the SFML sprite

	Local $tmp_sprite_ptr = _CSFML_sfSprite_create()
	Local $tmp_sprite_ptr_str = String($tmp_sprite_ptr)
	$__sprite_ptr_dict.Add($tmp_body_struct_ptr_str, $tmp_sprite_ptr_str)

	_CSFML_sfSprite_setTexture($tmp_sprite_ptr, $__shape_image_dict($shape_ptr), $CSFML_sfTrue)
;	_CSFML_sfSprite_setOrigin($__sprite_ptr[$body_struct_ptr_index], _CSFML_sfVector2f_Constructor((($__body_width[$body_struct_ptr_index] / 2) * $__pixels_per_metre) + $shape_x_pixel_offset, (($__body_height[$body_struct_ptr_index] / 2) * $__pixels_per_metre) + $shape_y_pixel_offset))
	_CSFML_sfSprite_setOrigin($tmp_sprite_ptr, _CSFML_sfVector2f_Constructor(-$shape_x_pixel_offset, -$shape_y_pixel_offset))
	_ArrayAdd($__sprite_screen_x_offset, $shape_x_pixel_offset)
	_ArrayAdd($__sprite_screen_y_offset, $shape_y_pixel_offset)

	; Add the SFML convex shape

	Local $tmp_convex_shape_ptr = _CSFML_sfConvexShape_Create()
	Local $tmp_convex_shape_ptr_str = String($tmp_convex_shape_ptr)
	$__convex_shape_ptr_dict.Add($tmp_convex_shape_ptr_str, $tmp_convex_shape_ptr_str)

;	_ArrayAdd($__convex_shape_ptr, Null)
;	$__convex_shape_ptr[$body_struct_ptr_index] = _CSFML_sfConvexShape_Create()
	Local $tmp_shape_vertice_arr = $__shape_vertice_dict($shape_ptr)
	_CSFML_sfConvexShape_setPointCount($tmp_convex_shape_ptr, UBound($tmp_shape_vertice_arr))

;_ArrayDisplay($tmp_shape_vertice_arr)

	for $i = 0 to (UBound($tmp_shape_vertice_arr) - 1)

		_CSFML_sfConvexShape_setPoint($tmp_convex_shape_ptr, $i, $tmp_shape_vertice_arr[$i][0] * 50, $tmp_shape_vertice_arr[$i][1] * 50)
	Next

;	_CSFML_sfConvexShape_setOrigin($__convex_shape_ptr[$body_struct_ptr_index], _CSFML_sfVector2f_Constructor(($__body_width[$body_struct_ptr_index] / 2) * $__pixels_per_metre, ($__body_height[$body_struct_ptr_index] / 2) * $__pixels_per_metre))
	_CSFML_sfConvexShape_setOrigin($tmp_convex_shape_ptr, _CSFML_sfVector2f_Constructor(0, 0))
	_CSFML_sfConvexShape_setFillColor($tmp_convex_shape_ptr, _CSFML_sfColor_Constructor(255, 255, 255, 128))



	; return the index to the new body
	Return $tmp_body_struct_ptr_str
EndFunc


