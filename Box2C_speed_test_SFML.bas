
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

if 1 = 1 then
    
    print "true=" & True
endif 

print "false=" & False


' Setup the Box2D World
Dim As b2Vec2 gravity => (0, -10)
__world_ptr = _Box2C_b2World_Constructor(gravity, 1)
print "world ptr=" & __world_ptr

' Setup the Box2D Shapes

dim as integer platform_shape_index = _Box2C_b2ShapeDict_AddItem_SFML(1, -2.5, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 4, pathname & "\platform.gif")
dim as integer crate_shape_index = _Box2C_b2ShapeDict_AddItem_SFML(1, -0.125, -0.125, 0.125, -0.125, 0.125, 0.125, -0.125, 0.125, 0, 0, 0, 0, 0, 0, 0, 0, 4, pathname & "\smallest_crate.gif")
'dim as integer crate_shape_index = _Box2C_b2ShapeDict_AddItem_SFML(1, -2.5, -0.5, 2.5, -0.5, 2.5, 0.5, -2.5, 0.5, 0, 0, 0, 0, 0, 0, 0, 0, 4, pathname & "\platform.gif")

' Setup the Box2D Body Definitions

dim as integer platform_bodydef_index = _Box2C_b2BodyDefDict_AddItem(Box2C_b2_staticBody, 0, -4, 0, 0, 0)
'dim as integer platform2_bodydef_index = _Box2C_b2BodyDefDict_AddItem(Box2C_b2_staticBody, -4.5, -2, -0.785398, 0, 0)
'dim as integer platform3_bodydef_index = _Box2C_b2BodyDefDict_AddItem(Box2C_b2_staticBody, +4.5, -2, +0.785398, 0, 0)
dim as integer falling_bodydef_index = _Box2C_b2BodyDefDict_AddItem(Box2C_b2_dynamicBody, 0, 4, 0, 0, 0)

' Setup the Box2D Bodies and SFML Sprites

dim as integer platform_body_index = _Box2C_b2BodyDict_AddItem_SFML(platform_bodydef_index, platform_shape_index, 0, 0, 0, 999999, 999999, 999999, 0, 0, 0)
'dim as integer platform2_body_index = _Box2C_b2BodyDict_AddItem_SFML(platform2_bodydef_index, platform_shape_index, 0, 0, 0, 999999, 999999, 999999, 0, 0, 0)
'dim as integer platform3_body_index = _Box2C_b2BodyDict_AddItem_SFML(platform3_bodydef_index, platform_shape_index, 0, 0, 0, 999999, 999999, 999999, 0, 0, 0)
'dim as integer falling_body_index = _Box2C_b2BodyDict_AddItem_SFML(falling_bodydef_index, crate_shape_index, 1, 0.2, 0.3, 999999, 999999, 999999, 0, -6.25, -6.25)
dim as integer falling_body_index = _Box2C_b2BodyDict_AddItem_SFML(falling_bodydef_index, crate_shape_index, 1, 0.2, 0.3, 999999, 999999, 999999, 0, 0, 0)
'dim as integer falling_body_index = _Box2C_b2BodyDict_AddItem_SFML(falling_bodydef_index, crate_shape_index, 1, 0.2, 0.3, 0, 4, 0, 0, -6.25, -6.25)

'sleep

'Dim As Long Ptr fred = _CSFML_sfClock_create()
'Print fred

'dim as longint xxx = _CSFML_sfClock_getElapsedTime(fred)
'Print xxx

' Setup the GUI for SFML inside the AutoIT GUI

window_ptr = _CSFML_sfRenderWindow_create(800, 600, 16, "Box2D Speed Test for the SFML Engine", 6, NULL)
window_hwnd = _CSFML_sfRenderWindow_getSystemHandle(window_ptr)
_CSFML_sfRenderWindow_setVerticalSyncEnabled(window_ptr, 0)
courier_new_font_ptr = sfFont_createFromFile("C:\Windows\Fonts\cour.ttf")
Dim As Long Ptr info_text_ptr = _CSFML_sfText_create_and_set(courier_new_font_ptr, 14, black, 10, 10)

' Setup the Box2D animation, including the clocks (timers) and animation rate

dim as integer num_frames = 0
dim as integer frame_duration = 0
dim as string info_text_string
dim as integer fps = 0
'Local $fps_timer = _Timer_SetTimer($window_hwnd, 1000, "update_fps")
'Local $events_timer = _Timer_SetTimer($window_hwnd, 100, "check_events")
'Local $frame_timer = _Timer_Init()

'Dim As Long Ptr texture_ptr = _CSFML_sfTexture_createFromFile(pathname & "\crate.gif", NULL)
'print texture_ptr
'Dim As Long Ptr sprite_ptr = _CSFML_sfSprite_create()
'sfSprite_setTexture(sprite_ptr, texture_ptr, sfTrue)
'Dim As sfVector2f sprite_pos => (100, 100)
'sfSprite_setPosition(sprite_ptr, sprite_pos)

Dim Start As Double
Start = Timer

event_ptr = @event

' The animation frame loop

While 1

	' Every animation frame (1 / 60th of a second / 16 milliseconds) update the Box2D world

	'if _Timer_Diff($frame_timer) > ((1 / 60) * 1000) Then
    if (Timer - Start) > (1.0 / 60.0) then
    
        Start = Timer

	'	$frame_timer = _Timer_Init()

		' The following b2World Step compensates well for a large number of bodies
'		_Box2C_b2World_Step_Ex((0.6 + ($__body_struct_ptr_dict.Count / 200)) / 60.0)
		_Box2C_b2World_Step(__world_ptr, (1.0 / 60.0), 6, 2)
'        print __main_body(falling_body_index).body_ptr
'        dim as b2Vec2 ddd = _Box2C_b2Body_GetPosition(__main_body(falling_body_index).body_ptr)
'        print __main_body(platform_body_index).body_ptr
'        dim as b2Vec2 ddd2 = _Box2C_b2Body_GetPosition(__main_body(platform_body_index).body_ptr)
'sleep 50


  '      print ddd.y
        
		' Animate the frame
		_Box2C_b2World_Animate_SFML(window_ptr, white, info_text_ptr, info_text_string, 2)

		num_frames = num_frames + 1
'		frame_duration = _Timer_Diff(frame_timer)
	'EndIf
    
    
    while _CSFML_sfRenderWindow_pollEvent(window_ptr, event_ptr) = sfTrue

  '      print event.T

        select case event.T
        
            case sfEvtKeyPressed
                
                  '  print event.Key.Code
                select case event.Key.Code
                
                    case sfKeyEscape
    
                        _Exit
    
'                    case sfKeyD
                        
 '                       sprite_pos = sfSprite_getPosition(sprite_ptr)
  '                      sprite_pos.x = sprite_pos.x + 1
   '                     sfSprite_setPosition(sprite_ptr, sprite_pos)
    
    
                end select
        end select
    wend
    
    endif
    
WEnd




'    sfText_setString(text_ptr, "hello")

 '   sfRenderWindow_clear(window_ptr, white)
'    sfRenderWindow_drawSprite(window_ptr, sprite_ptr, NULL)
'    sfRenderWindow_drawText(window_ptr, text_ptr, NULL)
'    sfRenderWindow_display(window_ptr)

_Exit

Sub _Exit

    _CSFML_sfRenderWindow_close(window_ptr)
    
    ' Shutdown SFML
    _CSFML_Shutdown
    
    end 0
    
End Sub

'Function FORM1_TIMER1_WM_TIMER ( _
 '                              hWndForm      as HWnd, _     ' handle of Form
'                               wTimerID      as Long  _  ' the timer identifier
'                               ) as Long

'   Static i as Long
   
'   i = i + 1
'   Print i;
   
'   Function = 0   ' change according to your needs
'End Function
