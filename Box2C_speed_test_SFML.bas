
#Include once "CSFML.bi"
#Include once "Box2C.bi"
#Include once "Box2CEx.bi"

' #TYPES# ===================================================================================================================
' ===============================================================================================================================

' #SUBROUTINES# ===================================================================================================================
Declare Sub _Exit

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
__world_ptr = _Box2C_b2World_Constructor(gravity, 1)

' Setup the Box2D Shapes

dim as integer platform_shape_index = _Box2C_b2ShapeDict_AddItem_SFML(1, -2.5, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 4, pathname & "\platform.gif")
dim as integer crate_shape_index = _Box2C_b2ShapeDict_AddItem_SFML(1, -0.125, -0.125, 0.125, -0.125, 0.125, 0.125, -0.125, 0.125, 0, 0, 0, 0, 0, 0, 0, 0, 4, pathname & "\smallest_crate.gif")

' Setup the Box2D Body Definitions

dim as integer platform_bodydef_index = _Box2C_b2BodyDefDict_AddItem(Box2C_b2_staticBody, 0, -4, 0, 0, 0)
dim as integer platform2_bodydef_index = _Box2C_b2BodyDefDict_AddItem(Box2C_b2_staticBody, -4.5, -2, -0.785398, 0, 0)
dim as integer platform3_bodydef_index = _Box2C_b2BodyDefDict_AddItem(Box2C_b2_staticBody, +4.5, -2, +0.785398, 0, 0)
dim as integer falling_bodydef_index = _Box2C_b2BodyDefDict_AddItem(Box2C_b2_dynamicBody, 0, 4, 0, 0, 0)

' Setup the Box2D Bodies and SFML Sprites

dim as integer platform_body_index = _Box2C_b2BodyDict_AddItem_SFML(platform_bodydef_index, platform_shape_index, 0, 0, 0, "", "", "", 0, 0, 0)
'Local $platform_body_ptr = _Box2C_b2BodyDict_AddItem_SFML($platform_bodydef_ptr, $platform_shape_ptr, 0, 0, 0, "", "", "", 0, 0, 0)

'sleep

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

