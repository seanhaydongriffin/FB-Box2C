
' #INDEX# =======================================================================================================================
' Title .........: Box2CEx
' FreeBasic Version : ?
' Language ......: English
' Description ...: Box2C Extended Functions.
' Author(s) .....: Sean Griffin
' Dlls ..........: Box2C.dll
' ===============================================================================================================================

' #CONSTANTS# ===================================================================================================================
Const as single __pixels_per_metre = 50
' ===============================================================================================================================

' #ENUMERATIONS# ===================================================================================================================
' ===============================================================================================================================


' #TYPES# ===================================================================================================================
type GUI_Area
    width2 as integer
    height2 as integer
end type

type GUI_Position
    x as integer
    y as integer
end type

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
    prev_screen_x as integer
    prev_screen_y as integer
    curr_screen_x as integer
    curr_screen_y as integer
    prev_angle_degrees as single
    curr_angle_degrees as single
    width2 as single
    height2 as single
    out_of_bounds_behaviour as integer
    draw2 as boolean
end type

type sprite
    created as boolean
    sprite_ptr as long ptr
    screen_offset as sfVector2f
end type

' ===============================================================================================================================

	
' #FUNCTIONS# ===================================================================================================================
'Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, xxx() as integer, byval guid As integer, byval shape_image_file_path as string) As integer
Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, byval vertice1x as single, byval vertice1y as single, byval vertice2x as single, byval vertice2y as single, byval vertice3x as single, byval vertice3y as single, byval vertice4x as single, byval vertice4y as single, byval vertice5x as single, byval vertice5y as single, byval vertice6x as single, byval vertice6y as single, byval vertice7x as single, byval vertice7y as single, byval vertice8x as single, byval vertice8y as single, byval num_vertices as integer, byval shape_image_file_path as string) As integer
'Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, radius_vertice_ptr As b2Vec2 ptr, byval shape_image_file_path as string) As integer
'Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, byval shape_image_file_path as string) As integer
Declare Function _Box2C_b2BodyDefDict_AddItem(byval body_type as integer, byval initial_x as single = 0, byval initial_y as single = 0, byval initial_angle as single = 0, byval linearDamping as single = 0, byval angularDamping as single = 0) As integer
Declare Function _Box2C_b2BodyDict_AddItem_SFML(byval bodydef_index as integer, byval shape_index as integer, density as single, restitution as single, friction as single, x as single, y as single, angle as single, out_of_bounds_behaviour as integer = 0, shape_x_pixel_offset as integer = 0, shape_y_pixel_offset as integer = 0) As integer
Declare Sub _Box2C_b2World_SetGUIArea(byval width2 as integer, byval height2 as integer)
Declare Function _Box2C_b2Vec2_GetGUIPosition(byval world_x as single, byval world_y as single, vertices() As b2Vec2) As GUI_Position
Declare Function GetShapeWidth(vertices() As b2Vec2) As single
Declare Function GetShapeHeight(vertices() As b2Vec2) As single
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
dim shared as sprite __main_sprite(100)
dim shared as GUI_Area __GUI_Area


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
Function _Box2C_b2BodyDict_AddItem_SFML(byval bodydef_index as integer, byval shape_index as integer, density as single, restitution as single, friction as single, x as single = 999999, y as single = 999999, angle as single = 999999, out_of_bounds_behaviour as integer = 0, shape_x_pixel_offset as integer = 0, shape_y_pixel_offset as integer = 0) As integer
    
    ' find a main body that hasn't been created (created = 0)
    dim as integer body_index
    
    for body_index = 0 to (ubound(__main_body) - 1)
        
        if __main_body(body_index).created = 0 then
            
            exit for
        endif
    next
    
    __main_body(body_index).created = 1

    Dim As b2BodyDef Ptr bodydef_ptr = @__main_body_def(bodydef_index).box2c_body_def
    Dim As b2PolygonShapePortable Ptr shape_ptr = @__main_shape(shape_index).box2c_shape

	' create a new Box2C Body for the index of the body definition supplied, and add it to the internal array of body structures
	__main_body(body_index).body_ptr = _Box2C_b2World_CreateBody(__world_ptr, bodydef_ptr)
	_Box2C_b2Body_SetAwake(__main_body(body_index).body_ptr, True)

	if x < 999999 And y < 999999 Then

		_Box2C_b2Body_SetPosition(__main_body(body_index).body_ptr, x, y)
	EndIf

	if angle < 999999 Then

		_Box2C_b2Body_SetAngle(__main_body(body_index).body_ptr, angle)
	EndIf

	' add other attributes, such as the initial positions, angles and body widths and heights to the internal arrays for bodies
    __main_body(body_index).prev_screen_x = -1
    __main_body(body_index).prev_screen_y = -1
    __main_body(body_index).curr_screen_x = -1
    __main_body(body_index).curr_screen_y = -1
    __main_body(body_index).prev_angle_degrees = -1
    __main_body(body_index).curr_angle_degrees = -1
    __main_body(body_index).width2 = GetShapeWidth(__main_shape(shape_index).vertice())
    __main_body(body_index).height2 = GetShapeHeight(__main_shape(shape_index).vertice())
    __main_body(body_index).out_of_bounds_behaviour = out_of_bounds_behaviour
    __main_body(body_index).draw2 = 1 ' True
    

    
    
    
    ' find a main fixture that hasn't been created (created = 0)
    dim as integer fixture_index
    
    for fixture_index = 0 to (ubound(__main_fixture) - 1)
        
        if __main_fixture(fixture_index).created = 0 then
            
            exit for
        endif
    next
    
    __main_fixture(fixture_index).created = 1

   	' create a new Box2C Fixture for the index of the body created, and the index of the shape supplied, and other attributes supplied (density, restitution and friction), add it to the internal array of fixture structures
	__main_fixture(fixture_index).fixture_ptr = _Box2C_b2World_CreateFixture(__main_body(body_index).body_ptr, shape_ptr, density, restitution, friction)

	' get the GUI position of the initial (vector) position of the body, and add it to the internal array of body GUI positions

	if x >= 999999 or y >= 999999 Then

        x = __main_body_def(bodydef_index).box2c_body_def.position.x
        y = __main_body_def(bodydef_index).box2c_body_def.position.y
	EndIf



	dim as GUI_Position tmp_gui_pos = _Box2C_b2Vec2_GetGUIPosition(x, y, __main_shape(shape_index).vertice())
    __main_body(body_index).curr_screen_x = tmp_gui_pos.x
    __main_body(body_index).curr_screen_y = tmp_gui_pos.y
'    _ArrayAdd($__body_gui_pos, $tmp_gui_pos[0] & "|" & $tmp_gui_pos[1])

	' add the index of the shape to the internal array of body shapes
'	_ArrayAdd($__body_shape_index, $shape_index)

	' Add the SFML sprite
    
    ' find a main sprite that hasn't been created (created = 0)
    dim as integer sprite_index
    
    for sprite_index = 0 to (ubound(__main_sprite) - 1)
        
        if __main_sprite(sprite_index).created = 0 then
            
            exit for
        endif
    next
    
    __main_sprite(sprite_index).created = 1
    __main_sprite(sprite_index).sprite_ptr = _CSFML_sfSprite_create()
    _CSFML_sfSprite_setTexture(__main_sprite(sprite_index).sprite_ptr, __main_shape(shape_index).image_ptr, sfTrue)

'    Dim As sfVector2f shape_pixel_offset => (-shape_x_pixel_offset, -shape_y_pixel_offset)
    __main_sprite(sprite_index).screen_offset.x = -shape_x_pixel_offset
    __main_sprite(sprite_index).screen_offset.y = -shape_y_pixel_offset

'	_CSFML_sfSprite_setOrigin($__sprite_ptr[$body_struct_ptr_index], _CSFML_sfVector2f_Constructor((($__body_width[$body_struct_ptr_index] / 2) * $__pixels_per_metre) + $shape_x_pixel_offset, (($__body_height[$body_struct_ptr_index] / 2) * $__pixels_per_metre) + $shape_y_pixel_offset))
	_CSFML_sfSprite_setOrigin(__main_sprite(sprite_index).sprite_ptr, __main_sprite(sprite_index).screen_offset)

	' Add the SFML convex shape

'	Local $tmp_convex_shape_ptr = _CSFML_sfConvexShape_Create()
'	Local $tmp_convex_shape_ptr_str = String($tmp_convex_shape_ptr)
'	$__convex_shape_ptr_dict.Add($tmp_convex_shape_ptr_str, $tmp_convex_shape_ptr_str)

'	_ArrayAdd($__convex_shape_ptr, Null)
'	$__convex_shape_ptr[$body_struct_ptr_index] = _CSFML_sfConvexShape_Create()
'	Local $tmp_shape_vertice_arr = $__shape_vertice_dict($shape_ptr)
'	_CSFML_sfConvexShape_setPointCount($tmp_convex_shape_ptr, UBound($tmp_shape_vertice_arr))

'_ArrayDisplay($tmp_shape_vertice_arr)

'	for $i = 0 to (UBound($tmp_shape_vertice_arr) - 1)

'		_CSFML_sfConvexShape_setPoint($tmp_convex_shape_ptr, $i, $tmp_shape_vertice_arr[$i][0] * 50, $tmp_shape_vertice_arr[$i][1] * 50)
'	Next

'	_CSFML_sfConvexShape_setOrigin($__convex_shape_ptr[$body_struct_ptr_index], _CSFML_sfVector2f_Constructor(($__body_width[$body_struct_ptr_index] / 2) * $__pixels_per_metre, ($__body_height[$body_struct_ptr_index] / 2) * $__pixels_per_metre))
'	_CSFML_sfConvexShape_setOrigin($tmp_convex_shape_ptr, _CSFML_sfVector2f_Constructor(0, 0))
'	_CSFML_sfConvexShape_setFillColor($tmp_convex_shape_ptr, _CSFML_sfColor_Constructor(255, 255, 255, 128))



	' return the index to the new body
	Return body_index
End Function



' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2Vec2_GetGUIPosition
' Description ...: Convert a Box2D position (in metres) to a SFML / GUI position (in pixels)
' Syntax.........: _Box2C_b2Vec2_GetGUIPosition($world_x, $world_y, $vertices)
' Parameters ....: $world_x - the horizontal component of the Box2D vector
'				   $world_y - the vertical component of the Box2D vector
'				   $vertices - a two dimensional array of vertices making up the shape
' Return values .: the GUI position in a two element array
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _Box2C_b2Vec2_GetGUIPosition(byval world_x as single, byval world_y as single, vertices() As b2Vec2) As GUI_Position

	dim as GUI_Position gui_pos

	' get the GUI center
	dim as integer gui_x_center = __GUI_Area.width2 / 2
	dim as integer gui_y_center = __GUI_Area.height2 / 2

	' get the size (largest vertice values) of the polygon
'	dim as single world_width = _ArrayMax(vertices, 1, -1, -1, 0)
	dim as single world_height = GetShapeHeight(vertices())

	' get the centroid of the vertices

	dim as b2Vec2 centroid = _Box2C_b2PolygonShape_ComputeCentroid(vertices())

	gui_pos.x = gui_x_center + (world_x * __pixels_per_metre) - ((centroid.x) * __pixels_per_metre)
	gui_pos.y = gui_y_center - (world_y * __pixels_per_metre) - ((world_height - centroid.y) * __pixels_per_metre)
'	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $centroid[1] = ' & $centroid[1] & @CRLF & '>Error code: ' & @error & @CRLF) '### Debug Console
'	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $world_y = ' & $world_y & @CRLF & '>Error code: ' & @error & @CRLF) '### Debug Console
'	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $gui_y_center = ' & $gui_y_center & @CRLF & '>Error code: ' & @error & @CRLF) '### Debug Console


	return gui_pos

End Function

' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2World_SetGUIArea
' Description ...: Define the width and height (area) of the GUI that the Box2D world is within
' Syntax.........: _Box2C_b2World_SetGUIArea($x, $y)
' Parameters ....: $x - the width of the GUI area in pixels
'				   $y - the height of the GUI area in pixels
' Return values .: None
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2World_SetGUIArea(byval width2 as integer, byval height2 as integer)

	__GUI_Area.width2 = width2
	__GUI_Area.height2 = height2
End Sub


Function GetShapeWidth(vertices() As b2Vec2) As single

    dim as single min_x = 999999
    dim as single max_x = -999999

    for i as integer = 0 to (ubound(vertices) - 1)
        
        if vertices(i).x < min_x then
            
            min_x = vertices(i).x
        endif
        
        if vertices(i).x > max_x then
            
            max_x = vertices(i).x
        endif
    next
    
    dim as single shape_width = max_x - min_x
    return shape_width
End Function


Function GetShapeHeight(vertices() As b2Vec2) As single

    dim as single min_y = 999999
    dim as single max_y = -999999

    for i as integer = 0 to (ubound(vertices) - 1)
        
        if vertices(i).y < min_y then
            
            min_y = vertices(i).y
        endif
        
        if vertices(i).y > max_y then
            
            max_y = vertices(i).y
        endif
        
    next
    
    dim as single shape_height = max_y - min_y
    return shape_height
    
End Function
