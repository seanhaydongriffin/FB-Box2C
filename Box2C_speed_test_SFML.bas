
#Include once "CSFML.bi"
#Include once "Box2C.bi"
#Include once "Box2CEx.bi"

' #TYPES# ===================================================================================================================
' ===============================================================================================================================

' #SUBROUTINES# ===================================================================================================================
Declare Sub _Exit
Declare Sub shape_arrayadd(shape_tmp() as shape, byval guid as integer, byval vertice1x as single, byval vertice1y as single, byval vertice2x as single, byval vertice2y as single, byval vertice3x as single, byval vertice3y as single, byval vertice4x as single, byval vertice4y as single, byval vertice5x as single, byval vertice5y as single, byval vertice6x as single, byval vertice6y as single, byval vertice7x as single, byval vertice7y as single, byval vertice8x as single, byval vertice8y as single, byval num_vertices as integer)
'Declare sub shape_arrayadd(shape_ptr As shape ptr)
'Declare sub shape_arrayadd(shape_tmp() As shape)

' ===============================================================================================================================

' #VARIABLES# ===================================================================================================================
Dim shared window_ptr As Long Ptr
dim as longint window_hwnd
dim event as sfEvent
Dim As sfEvent Ptr event_ptr
' ===============================================================================================================================

Dim pathname As String = ExePath
'Print "This program's initial directory is: " & pathname

' Setup SFML
_CSFML_Startup

' Setup Box2C
_Box2C_Startup




' Setup the Box2D World
Dim As b2Vec2 gravity => (0, -10)
_Box2C_b2World_Constructor(gravity, 1)

' Setup the Box2D Shapes


'	dim result() as string
 '   dim as string tt = "aaa"
	'dim as integer ww = split(tt, result(), ":", 0)



' 0 = platform1

shape_arrayadd(__main_shape(), 1, -2.5, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 4)
shape_arrayadd(__main_shape(), 2, 3, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 4)
print __main_shape(0).guid
print __main_shape(1).guid
print ubound(__main_shape)

dim as b2Vec2 vertices(4) => {(-2.5,-0.5),(2.5,-0.5),(2.5,0.5),(-2.5,0.5)}
dim as b2Vec2 ptr vertices_ptr = @vertices(0)
'dim as integer fred = _Box2C_b2ShapeDict_AddItem_SFML(1, vertices(), pathname & "\platform.gif")
'dim as integer fred = _Box2C_b2ShapeDict_AddItem_SFML(1, vertices_ptr, pathname & "\platform.gif")
dim as integer fred = _Box2C_b2ShapeDict_AddItem_SFML(1, 1, pathname & "\platform.gif")
'dim as integer fred = _Box2C_b2ShapeDict_AddItem_SFML(1, __main_shape(), 1, pathname & "\platform.gif")
'dim as integer fred = _Box2C_b2ShapeDict_AddItem_SFML(1, vertices_ptr, pathname & "\platform.gif")

sleep

'Dim As Long Ptr fred = _CSFML_sfClock_create()
'Print fred

'dim as longint xxx = _CSFML_sfClock_getElapsedTime(fred)
'Print xxx

window_ptr = _CSFML_sfRenderWindow_create(800, 600, 16, "xxx", 6, NULL)
window_hwnd = _CSFML_sfRenderWindow_getSystemHandle(window_ptr)
_CSFML_sfRenderWindow_setVerticalSyncEnabled(window_ptr, 0)
courier_new_font_ptr = sfFont_createFromFile("C:\Windows\Fonts\cour.ttf")
Dim As Long Ptr text_ptr = _CSFML_sfText_create_and_set(courier_new_font_ptr, 14, black, 50, 50)

Dim As Long Ptr texture_ptr = sfTexture_createFromFile(pathname & "\crate.gif", NULL)
print texture_ptr
Dim As Long Ptr sprite_ptr = _CSFML_sfSprite_create()
sfSprite_setTexture(sprite_ptr, texture_ptr, sfTrue)
Dim As sfVector2f sprite_pos => (100, 100)
sfSprite_setPosition(sprite_ptr, sprite_pos)




event_ptr = @event

while 1
    
    while _CSFML_sfRenderWindow_pollEvent(window_ptr, event_ptr) = sfTrue

  '      print event.T

        select case event.T
        
            case sfEvtKeyPressed
            
              '  print event.Key.Code
            select case event.Key.Code
            
                case sfKeyEscape

                    _Exit

                case sfKeyD
                    
                    sprite_pos = sfSprite_getPosition(sprite_ptr)
                    sprite_pos.x = sprite_pos.x + 1
                    sfSprite_setPosition(sprite_ptr, sprite_pos)


            end select
        end select
    wend

    sfText_setString(text_ptr, "hello")

    sfRenderWindow_clear(window_ptr, white)
    sfRenderWindow_drawSprite(window_ptr, sprite_ptr, NULL)
    sfRenderWindow_drawText(window_ptr, text_ptr, NULL)
    sfRenderWindow_display(window_ptr)
wend

_Exit

Sub _Exit

    _CSFML_sfRenderWindow_close(window_ptr)
    
    ' Shutdown SFML
    _CSFML_Shutdown
    
    end 0
    
End Sub


Sub shape_arrayadd(shape_tmp() as shape, byval guid as integer, byval vertice1x as single, byval vertice1y as single, byval vertice2x as single, byval vertice2y as single, byval vertice3x as single, byval vertice3y as single, byval vertice4x as single, byval vertice4y as single, byval vertice5x as single, byval vertice5y as single, byval vertice6x as single, byval vertice6y as single, byval vertice7x as single, byval vertice7y as single, byval vertice8x as single, byval vertice8y as single, byval num_vertices as integer)
'sub shape_arrayadd(shape_ptr As shape ptr)
'sub shape_arrayadd(shape_tmp() As shape)
    
    
    redim preserve shape_tmp(ubound(shape_tmp) + 1)
    
    shape_tmp(ubound(shape_tmp) - 1).guid = guid
    shape_tmp(ubound(shape_tmp) - 1).vertice(0).x = vertice1x
    shape_tmp(ubound(shape_tmp) - 1).vertice(0).y = vertice1y
    shape_tmp(ubound(shape_tmp) - 1).vertice(1).x = vertice2x
    shape_tmp(ubound(shape_tmp) - 1).vertice(1).y = vertice2y
    shape_tmp(ubound(shape_tmp) - 1).vertice(2).x = vertice3x
    shape_tmp(ubound(shape_tmp) - 1).vertice(2).y = vertice3y
    shape_tmp(ubound(shape_tmp) - 1).vertice(3).x = vertice4x
    shape_tmp(ubound(shape_tmp) - 1).vertice(3).y = vertice4y
    shape_tmp(ubound(shape_tmp) - 1).vertice(4).x = vertice5x
    shape_tmp(ubound(shape_tmp) - 1).vertice(4).y = vertice5y
    shape_tmp(ubound(shape_tmp) - 1).vertice(5).x = vertice6x
    shape_tmp(ubound(shape_tmp) - 1).vertice(5).y = vertice6y
    shape_tmp(ubound(shape_tmp) - 1).vertice(6).x = vertice7x
    shape_tmp(ubound(shape_tmp) - 1).vertice(6).y = vertice7y
    shape_tmp(ubound(shape_tmp) - 1).vertice(7).x = vertice8x
    shape_tmp(ubound(shape_tmp) - 1).vertice(7).y = vertice8y
    shape_tmp(ubound(shape_tmp) - 1).num_vertices = num_vertices
    
end Sub

