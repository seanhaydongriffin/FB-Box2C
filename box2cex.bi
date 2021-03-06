
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
Declare Sub _Box2C_b2World_Animate_SFML(byval window_ptr As Long Ptr, byval window_color as sfColor, byval info_text_ptr As Long Ptr, byval info_text_string as string, byval draw_info_text_before_body as integer)
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
        
'    print "xxx index=" & shape_index
'    print "xxx main_shape_ptr=" & main_shape_ptr


	' create a new Box2C Polygone Shape for the new vertices and add it to the internal array of shape structures
'	Local $tmp_shape_struct

'	Switch $type

'		case $Box2C_e_circle

'			$tmp_shape_struct = _Box2C_b2CircleShape_Constructor($radius_vertice)

'		case $Box2C_e_edge

'			Dim As b2PolygonShapePortable tmp_shape_struct = _Box2C_b2PolygonShape_Constructor(radius_vertice())
			__main_shape(shape_index).box2c_shape = _Box2C_b2PolygonShape_Constructor(*(main_shape_ptr).vertice(0))
'	EndSwitch

    print "shape.box2c_shape m_type=" & __main_shape(shape_index).box2c_shape.m_type & " m_radius=" & __main_shape(shape_index).box2c_shape.m_radius & " m_centroidx=" & __main_shape(shape_index).box2c_shape.m_centroid.x & " m_centroidy=" & __main_shape(shape_index).box2c_shape.m_centroid.y
    print " m_vertice0=" & __main_shape(shape_index).box2c_shape.m_vertice(0).x & "," & __main_shape(shape_index).box2c_shape.m_vertice(0).y & " m_vertice1=" & __main_shape(shape_index).box2c_shape.m_vertice(1).x & "," & __main_shape(shape_index).box2c_shape.m_vertice(1).y & " m_vertice2=" & __main_shape(shape_index).box2c_shape.m_vertice(2).x & "," & __main_shape(shape_index).box2c_shape.m_vertice(2).y & " m_vertice3=" & __main_shape(shape_index).box2c_shape.m_vertice(3).x & "," & __main_shape(shape_index).box2c_shape.m_vertice(3).y & " m_vertice4=" & __main_shape(shape_index).box2c_shape.m_vertice(4).x & "," & __main_shape(shape_index).box2c_shape.m_vertice(4).y & " m_vertice5=" & __main_shape(shape_index).box2c_shape.m_vertice(5).x & "," & __main_shape(shape_index).box2c_shape.m_vertice(5).y & " m_vertice6=" & __main_shape(shape_index).box2c_shape.m_vertice(6).x & "," & __main_shape(shape_index).box2c_shape.m_vertice(6).y & " m_vertice7=" & __main_shape(shape_index).box2c_shape.m_vertice(7).x & "," & __main_shape(shape_index).box2c_shape.m_vertice(7).y
    print " m_normal0=" & __main_shape(shape_index).box2c_shape.m_normal(0).x & "," & __main_shape(shape_index).box2c_shape.m_normal(0).y & " m_normal1=" & __main_shape(shape_index).box2c_shape.m_normal(1).x & "," & __main_shape(shape_index).box2c_shape.m_normal(1).y & " m_normal2=" & __main_shape(shape_index).box2c_shape.m_normal(2).x & "," & __main_shape(shape_index).box2c_shape.m_normal(2).y & " m_normal3=" & __main_shape(shape_index).box2c_shape.m_normal(3).x & "," & __main_shape(shape_index).box2c_shape.m_normal(3).y & " m_normal4=" & __main_shape(shape_index).box2c_shape.m_normal(4).x & "," & __main_shape(shape_index).box2c_shape.m_normal(4).y & " m_normal5=" & __main_shape(shape_index).box2c_shape.m_normal(5).x & "," & __main_shape(shape_index).box2c_shape.m_normal(5).y & " m_normal6=" & __main_shape(shape_index).box2c_shape.m_normal(6).x & "," & __main_shape(shape_index).box2c_shape.m_normal(6).y & " m_normal7=" & __main_shape(shape_index).box2c_shape.m_normal(7).x & "," & __main_shape(shape_index).box2c_shape.m_normal(7).y
    print "vertexcount=" & __main_shape(shape_index).box2c_shape.m_vertexCount

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
	__main_body_def(body_def_index).box2c_body_def = _Box2C_b2BodyDef_Constructor(body_type, initial_x, initial_y, initial_angle, 0, 0, 0, linearDamping, angularDamping, 1, 1, 0, 0, 1, Null, 1)
'	__main_body_def(body_def_index).box2c_body_def = _Box2C_b2BodyDef_Constructor(2, 0, 4, 0, 0, 0, 0, linearDamping, angularDamping, 1, 1, 0, 0, 1, Null, 1)
'	__main_body_def(body_def_index).box2c_body_def = _Box2C_b2BodyDef_Constructor(2, 0, 4, 0)
    
'    print "body_def ptr=" & @__main_body_def(body_def_index).box2c_body_def
'    print "body_def_index=" & body_def_index
'    print "body_def type2=" & __main_body_def(body_def_index).box2c_body_def.type2 & " positionx=" & __main_body_def(body_def_index).box2c_body_def.position.x & " positiony=" & __main_body_def(body_def_index).box2c_body_def.position.y & " angle=" & __main_body_def(body_def_index).box2c_body_def.angle & " linearVelocityx=" & __main_body_def(body_def_index).box2c_body_def.linearVelocity.x & " linearVelocityy=" & __main_body_def(body_def_index).box2c_body_def.linearVelocity.y & " angularVelocity=" & __main_body_def(body_def_index).box2c_body_def.angularVelocity & " linearDamping=" & __main_body_def(body_def_index).box2c_body_def.linearDamping & " angularDamping=" & __main_body_def(body_def_index).box2c_body_def.angularDamping & " allowSleep=" & __main_body_def(body_def_index).box2c_body_def.allowSleep & " awake=" & __main_body_def(body_def_index).box2c_body_def.awake & " fixedRotation=" & __main_body_def(body_def_index).box2c_body_def.fixedRotation & " bullet=" & __main_body_def(body_def_index).box2c_body_def.bullet & " active=" & __main_body_def(body_def_index).box2c_body_def.active & " userData=" & __main_body_def(body_def_index).box2c_body_def.userData & " gravityScale=" & __main_body_def(body_def_index).box2c_body_def.gravityScale

    
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

 '   print "body_def type2=" & __main_body_def(bodydef_index).box2c_body_def.type2 & " positionx=" & __main_body_def(bodydef_index).box2c_body_def.position.x & " positiony=" & __main_body_def(bodydef_index).box2c_body_def.position.y & " angle=" & __main_body_def(bodydef_index).box2c_body_def.angle & " linearVelocityx=" & __main_body_def(bodydef_index).box2c_body_def.linearVelocity.x & " linearVelocityy=" & __main_body_def(bodydef_index).box2c_body_def.linearVelocity.y & " angularVelocity=" & __main_body_def(bodydef_index).box2c_body_def.angularVelocity & " linearDamping=" & __main_body_def(bodydef_index).box2c_body_def.linearDamping & " angularDamping=" & __main_body_def(bodydef_index).box2c_body_def.angularDamping & " allowSleep=" & __main_body_def(bodydef_index).box2c_body_def.allowSleep & " awake=" & __main_body_def(bodydef_index).box2c_body_def.awake & " fixedRotation=" & __main_body_def(bodydef_index).box2c_body_def.fixedRotation & " bullet=" & __main_body_def(bodydef_index).box2c_body_def.bullet & " active=" & __main_body_def(bodydef_index).box2c_body_def.active & " userData=" & __main_body_def(bodydef_index).box2c_body_def.userData & " gravityScale=" & __main_body_def(bodydef_index).box2c_body_def.gravityScale

    Dim As b2BodyDef Ptr bodydef_ptr = @__main_body_def(bodydef_index).box2c_body_def
    Dim As b2PolygonShapePortable Ptr shape_ptr = @__main_shape(shape_index).box2c_shape

	' create a new Box2C Body for the index of the body definition supplied, and add it to the internal array of body structures
'   print "initial_y=" & __main_body_def(bodydef_index).box2c_body_def.position.y
	__main_body(body_index).body_ptr = _Box2C_b2World_CreateBody(__world_ptr, bodydef_ptr)
    print "body_ptr=" & __main_body(body_index).body_ptr
	_Box2C_b2Body_SetAwake(__main_body(body_index).body_ptr, True)


	if x < 999999 And y < 999999 Then

		_Box2C_b2Body_SetPosition(__main_body(body_index).body_ptr, x, y)
	EndIf

	if angle < 999999 Then

		_Box2C_b2Body_SetAngle(__main_body(body_index).body_ptr, angle)
	EndIf

'    dim as b2Vec2 ddd = _Box2C_b2Body_GetPosition(__main_body(body_index).body_ptr)
'    dim as single eee = _Box2C_b2Body_GetAngle(__main_body(body_index).body_ptr)
        

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

    print "fixture_index=" & fixture_index & " fixture_ptr=" & __main_fixture(fixture_index).fixture_ptr & " shape_ptr=" & shape_ptr & " density=" & density & " restitution=" & restitution & " friction=" & friction

	' get the GUI position of the initial (vector) position of the body, and add it to the internal array of body GUI positions

	if x >= 999999 or y >= 999999 Then

        x = __main_body_def(bodydef_index).box2c_body_def.position.x
        y = __main_body_def(bodydef_index).box2c_body_def.position.y
        print "x=" & x & ", y=" & y
	EndIf



'	dim as GUI_Position tmp_gui_pos = _Box2C_b2Vec2_GetGUIPosition(x, y, __main_shape(shape_index).vertice())
'    __main_body(body_index).curr_screen_x = tmp_gui_pos.x
'    __main_body(body_index).curr_screen_y = tmp_gui_pos.y
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

    Dim As sfVector2f shape_pixel_offset => (-shape_x_pixel_offset, -shape_y_pixel_offset)
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



' #FUNCTION# ====================================================================================================================
' Name...........: _Box2C_b2World_Animate_SFML
' Description ...: The animation loop specifically for Box2D and SFML
' Syntax.........: _Box2C_b2World_Animate_SFML($window_ptr, $window_color, $info_text_ptr, $info_text_string)
' Parameters ....: $window_ptr
'				   $window_color
'				   $info_text_ptr
'				   $info_text_string
'				   $draw_info_text_before_body - the index of the body to draw the info text before
' Return values .: None
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _Box2C_b2World_Animate_SFML(byval window_ptr As Long Ptr, byval window_color as sfColor, byval info_text_ptr As Long Ptr, byval info_text_string as string, byval draw_info_text_before_body as integer)

	' Transform all the Box2D bodies to SFML sprites

	' converting dictionaries into arrays because arrays (including the conversion to arrays) perform about 6 times faster than dictionaries
	'	these arrays can only be used to "get" data.  To "set" data we must still reference the associated dictionary.
	'   (~0 ms @ 100 bodies)

'	Local $body_ptr = $__body_out_of_bounds_behaviour_dict.Keys
'	Local $__body_struct_ptr_arr = $__body_struct_ptr_dict.Items
'	Local $__body_out_of_bounds_behaviour_arr = $__body_out_of_bounds_behaviour_dict.Items
'	Local $__body_draw_arr = $__body_draw_dict.Items
'	Local $__body_curr_screen_x_arr = $__body_curr_screen_x_dict.Items
'	Local $__body_curr_screen_y_arr = $__body_curr_screen_y_dict.Items
'	Local $__sprite_ptr_arr = $__sprite_ptr_dict.Items

	' Transform the Box2D bodies and draw SFML sprites

	dim as integer body_num = -1

	While True

		body_num = body_num + 1

		if body_num > (UBound(__main_body) - 1) Then

			Exit While
		EndIf

'print __main_body(body_num).created

        if __main_body(body_num).created = True then



            dim as b2Vec2 body_position = _Box2C_b2Body_GetPosition(__main_body(body_num).body_ptr)
    
            ' if the body is off-screen (~0 ms @ 100 bodies)
    '		if $body_position[0] < -8 or $body_position[0] > 8 or $body_position[1] < -6 or $body_position[1] > 6 Then
    
    '			if $__body_out_of_bounds_behaviour_arr[$body_num] = 4 Then
    
    '				_Box2C_b2BodyArray_SetItemAwake($body_num, False)
    '				$__body_draw_dict.Item($body_ptr[$body_num]) = False
    '			EndIf
    
    '			if $__body_out_of_bounds_behaviour_arr[$body_num] = 2 Then
    
    '				Local $velocity = _Box2C_b2Body_GetLinearVelocity($__body_struct_ptr_arr[$body_num])
    
    '				if $body_position[0] < -8 or $body_position[0] > 8 Then
    
    '					_Box2C_b2Body_SetPosition($__body_struct_ptr_arr[$body_num], $body_position[0] * 0.99, $body_position[1])
    '					_Box2C_b2Body_SetLinearVelocity($__body_struct_ptr_arr[$body_num], 0 - $velocity[0], $velocity[1])
    '				EndIf
    
    '				if $body_position[1] < -6 or $body_position[1] > 6 Then
    
    '					_Box2C_b2Body_SetPosition($__body_struct_ptr_arr[$body_num], $body_position[0], $body_position[1] * 0.99)
    '					_Box2C_b2Body_SetLinearVelocity($__body_struct_ptr_arr[$body_num], $velocity[0], 0 - $velocity[1])
    '				EndIf
    '			EndIf
    
    '			if $__body_out_of_bounds_behaviour_arr[$body_num] = 1 Then
    
    '				_Box2C_b2Body_Destroy_SFML($body_num)
    '				$body_num = $body_num - 1
    '			EndIf
    '		Else
    
                ' Update sprite position (5 ms @ 100 bodies)
    
                ' converting the below to C might improve animations by a further 500 frames per seconds
                
                __main_body(body_num).curr_screen_x = 400 + (body_position.x * __pixels_per_metre)
                __main_body(body_num).curr_screen_y = 300 - (body_position.y * __pixels_per_metre)
                dim as sfVector2f tmp_sprite_position => (__main_body(body_num).curr_screen_x, __main_body(body_num).curr_screen_y)
                _CSFML_sfSprite_setPosition(__main_sprite(body_num).sprite_ptr, tmp_sprite_position)
                

'                $__body_curr_screen_x_dict.Item($body_ptr[$body_num]) = $__gui_center_x + ($body_position[0] * $__pixels_per_metre)
 '               $__body_curr_screen_y_dict.Item($body_ptr[$body_num]) = $__gui_center_y - ($body_position[1] * $__pixels_per_metre)
  '              _CSFML_sfSprite_setPosition_xy($__sprite_ptr_arr[$body_num], $__body_curr_screen_x_arr[$body_num], $__body_curr_screen_y_arr[$body_num])
    
                ' Update sprite rotation (4 ms @ 100 bodies)
    '			Local $body_angle = _Box2C_b2Body_GetAngle($__body_struct_ptr_arr[$body_num])
    '			$__body_curr_angle_degrees_dict.Item($body_ptr[$body_num]) = _Degree($body_angle)
    '			_CSFML_sfSprite_setRotation($__sprite_ptr_arr[$body_num], _Degree($body_angle))
    '		EndIf
        endif
        
	WEnd

	' Clear the animation frame (~0 ms @ 100 bodies)
	_CSFML_sfRenderWindow_clear(window_ptr, window_color)

	' converting dictionaries into arrays because arrays (including the conversion to arrays) perform about 6 times faster than dictionaries
	'	these arrays can only be used to "get" data.  To "set" data we must still reference the associated dictionary.

'	Local $__convex_shape_ptr_arr

'	if $body_num >= $__convex_shape_draw_lower_index and $body_num <= $__convex_shape_draw_upper_index Then

'		$__convex_shape_ptr_arr = $__convex_shape_ptr_dict.Items
'	EndIf

	body_num = -1

	While True

		body_num = body_num + 1

'		if $body_num > (UBound($__body_draw_arr) - 1) Then

'			ExitLoop
'		EndIf

        if body_num > (UBound(__main_body) - 1) Then

			Exit While
		EndIf

        if __main_body(body_num).created = True then


            ' if drawing the info text (~0 ms @ 100 bodies)
   '         if $draw_info_text_before_body > -1 And $body_num = $draw_info_text_before_body Then
    
    '            _CSFML_sfRenderWindow_drawTextString($window_ptr, $info_text_ptr, $info_text_string, Null)
     '       EndIf
    
      '      if $__body_draw_arr[$body_num] = True Then
    
                ' if drawing sprites (2 ms @ 100 bodies)
        '        if $body_num >= $__sprite_draw_lower_index and $body_num <= $__sprite_draw_upper_index Then
    
                    _CSFML_sfRenderWindow_drawSprite(window_ptr, __main_sprite(body_num).sprite_ptr, Null)
         '       EndIf
    
                ' if drawing convex shapes - disabled in the speed test (~0 ms @ 100 bodies)
    '			if $body_num >= $__convex_shape_draw_lower_index and $body_num <= $__convex_shape_draw_upper_index Then
    
    '				_CSFML_sfRenderWindow_drawConvexShape($window_ptr, $__convex_shape_ptr_arr[$body_num], Null)
    '			EndIf
       '     EndIf
        endif
        
	WEnd

	' Display the animation frame (~0 ms @ 100 bodies)
	_CSFML_sfRenderWindow_display(window_ptr)

End Sub



