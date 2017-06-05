
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

type body_def
    created as boolean
    box2c_body_def as b2BodyDef
end type
' ===============================================================================================================================

	
' #FUNCTIONS# ===================================================================================================================
'Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, xxx() as integer, byval guid As integer, byval shape_image_file_path as string) As integer
Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, byval vertice1x as single, byval vertice1y as single, byval vertice2x as single, byval vertice2y as single, byval vertice3x as single, byval vertice3y as single, byval vertice4x as single, byval vertice4y as single, byval vertice5x as single, byval vertice5y as single, byval vertice6x as single, byval vertice6y as single, byval vertice7x as single, byval vertice7y as single, byval vertice8x as single, byval vertice8y as single, byval num_vertices as integer, byval shape_image_file_path as string) As integer
'Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, radius_vertice_ptr As b2Vec2 ptr, byval shape_image_file_path as string) As integer
'Declare Function _Box2C_b2ShapeDict_AddItem_SFML(byval type2 as integer, byval shape_image_file_path as string) As integer
Declare Function _Box2C_b2BodyDefDict_AddItem(byval body_type as integer, byval initial_x as single = 0, byval initial_y as single = 0, byval initial_angle as single = 0, byval linearDamping as single = 0, byval angularDamping as single = 0) As integer

' ===============================================================================================================================

' #VARIABLES# ===================================================================================================================
'dim shared as b2PolygonShapePortable ptr __shape_struct_ptr_arr()
'redim preserve __shape_struct_ptr_arr(0)
'dim shared as b2PolygonShapePortable __shape_struct_arr()
'redim preserve __shape_struct_arr(0)
'dim shared as b2Vec2 __shape_vertice_arr()
'redim preserve __shape_vertice_arr(0)
dim shared as shape __main_shape(100)
'redim __main_shape(0)
dim shared as body_def __main_body_def(100)



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
