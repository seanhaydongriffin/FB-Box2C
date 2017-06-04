#Include once "CSFML.bi"

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
