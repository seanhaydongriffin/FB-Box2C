
' #INDEX# =======================================================================================================================
' Title .........: CSFML
' FreeBasic Version : ?
' Language ......: English
' Description ...: SFML Functions.
' Author(s) .....: Sean Griffin
' Dlls ..........: csfml-system-2.dll, csfml-graphics-2.dll
' ===============================================================================================================================

#define sfFalse 0
#define sfTrue  1

#ifndef NULL
const NULL as any ptr = 0
#endif

' #ENUMERATIONS# ===================================================================================================================
enum sfEventType
    sfEvtClosed
    sfEvtResized
    sfEvtLostFocus
    sfEvtGainedFocus
    sfEvtTextEntered
    sfEvtKeyPressed
    sfEvtKeyReleased
    sfEvtMouseWheelMoved
    sfEvtMouseButtonPressed
    sfEvtMouseButtonReleased
    sfEvtMouseMoved
    sfEvtMouseEntered
    sfEvtMouseLeft
    sfEvtJoyButtonPressed
    sfEvtJoyButtonReleased
    sfEvtJoyMoved
end enum

enum sfKeyCode
    sfKeyA = 0
    sfKeyB = 1
    sfKeyC = 2
    sfKeyD = 3
    sfKeyE = 4
    sfKeyF = 102
    sfKeyG = 103
    sfKeyH = 104
    sfKeyI = 105
    sfKeyJ = 106
    sfKeyK = 107
    sfKeyL = 108
    sfKeyM = 109
    sfKeyN = 110
    sfKeyO = 111
    sfKeyP = 112
    sfKeyQ = 113
    sfKeyR = 114
    sfKeyS = 115
    sfKeyT = 116
    sfKeyU = 117
    sfKeyV = 118
    sfKeyW = 119
    sfKeyX = 120
    sfKeyY = 121
    sfKeyZ = 122
    sfKeyNum0 = 48
    sfKeyNum1 = 49
    sfKeyNum2 = 50
    sfKeyNum3 = 51
    sfKeyNum4 = 52
    sfKeyNum5 = 53
    sfKeyNum6 = 54
    sfKeyNum7 = 55
    sfKeyNum8 = 56
    sfKeyNum9 = 57
    sfKeyEscape = 36
    sfKeyLControl
    sfKeyLShift
    sfKeyLAlt
    sfKeyLSystem     ''< OS specific key (left side) : windows (Win and Linux), apple (MacOS), ...
    sfKeyRControl
    sfKeyRShift
    sfKeyRAlt
    sfKeyRSystem      ''< OS specific key (right side) : windows (Win and Linux), apple (MacOS), ...
    sfKeyMenu
    sfKeyLBracket     ''< [
    sfKeyRBracket    ''< ]
    sfKeySemiColon    ''< ;
    sfKeyComma        ''< ,
    sfKeyPeriod      ''< .
    sfKeyQuote        ''< '
    sfKeySlash      ''< /
    sfKeyBackSlash
    sfKeyTilde       ''< ~
    sfKeyEqual       ''< =
    sfKeyDash         ''< -
    sfKeySpace
    sfKeyReturn
    sfKeyBack
    sfKeyTab
    sfKeyPageUp
    sfKeyPageDown
    sfKeyEnd
    sfKeyHome
    sfKeyInsert
    sfKeyDelete
    sfKeyAdd        ''< +
    sfKeySubtract     ''< -
    sfKeyMultiply    ''< *
    sfKeyDivide     ''< /
    sfKeyLeft         ''< Left arrow
    sfKeyRight       ''< Right arrow
    sfKeyUp          ''< Up arrow
    sfKeyDown         ''< Down arrow
    sfKeyNumpad0 = 295
    sfKeyNumpad1 = 296
    sfKeyNumpad2 = 297
    sfKeyNumpad3 = 298
    sfKeyNumpad4 = 299
    sfKeyNumpad5 = 300
    sfKeyNumpad6 = 301
    sfKeyNumpad7 = 302
    sfKeyNumpad8 = 303
    sfKeyNumpad9 = 304
    sfKeyF1 = 305
    sfKeyF2 = 306
    sfKeyF3 = 307
    sfKeyF4 = 308
    sfKeyF5 = 309
    sfKeyF6 = 310
    sfKeyF7 = 311
    sfKeyF8 = 312
    sfKeyF9 = 313
    sfKeyF10 = 314
    sfKeyF11 = 315
    sfKeyF12 = 316
    sfKeyF13 = 317
    sfKeyF14 = 318
    sfKeyF15 = 319
    sfKeyPause

    sfKeyCount '' For internal use
end enum

enum sfMouseButton
    sfButtonLeft
    sfButtonRight
    sfButtonMiddle
    sfButtonX1
    sfButtonX2
end enum

enum sfJoyAxis
    sfJoyAxisX
    sfJoyAxisY
    sfJoyAxisZ
    sfJoyAxisR
    sfJoyAxisU
    sfJoyAxisV
    sfJoyAxisPOV
end enum


' #TYPES# ===================================================================================================================
type sfBool as integer

'' 8 bits integer types
type sfInt8 as byte
type sfUint8 as ubyte

'' 16 bits integer types
type sfInt16 as short
type sfUint16as as ushort

'' 32 bits integer types
type sfInt32 as integer
type sfUint32 as uinteger

type sfBlack as sfColor
type sfWhite as sfColor
type sfRed as sfColor
type sfGreen as sfColor
type sfBlue as sfColor
type sfYellow as sfColor
type sfMagenta as sfColor
type sfCyan as sfColor

type sfVideoMode
    width2 as uinteger
    height2 as uinteger
    bitsPerPixel2 as uinteger
end type

type sfVector2f
    x as Single
    y as Single
end type

type sfContextSettings
     depthBits as uinteger
     stencilBits as uinteger
     antialiasingLevel as uinteger
     majorVersion as uinteger
     minorVersion as uinteger
     attributeFlags as uinteger
     sRgbCapable as Boolean 
end type

type sfKeyEvent
    T as sfEventType
    Code as sfKeyCode
    Alt as sfBool
    Control as sfBool
    Shift as sfBool
end type

type sfTextEvent
    T as sfEventType
    Unicode as sfUint32
end type

type sfMouseMoveEvent
    T as sfEventType
    X as integer
    Y as integer
end type

type sfMouseButtonEvent
    T as sfEventType
    Button as sfMouseButton
    X as integer
    Y as integer
end type

type sfMouseWheelEvent
    T as sfEventType
    Delta as integer
end type

type sfJoyMoveEvent
    T as sfEventType
    JoystickId as uinteger
    Axis as sfJoyAxis
    Position as single
end type

type sfJoyButtonEvent
    T as sfEventType
    JoystickId as uinteger
    Button as uinteger
end type

type sfSizeEvent
    T as sfEventType
    W as uinteger
    H as uinteger
end type

type sfEvent
union
    T as sfEventType ''< Type of the event
    Key as sfKeyEvent
    Text as sfTextEvent
    MouseMove as sfMouseMoveEvent
    MouseButton as sfMouseButtonEvent
    MouseWheel as sfMouseWheelEvent
    JoyMove as sfJoyMoveEvent
    JoyButton as sfJoyButtonEvent
    Size as sfSizeEvent
end union
end type

type sfColor
    r as sfUint8
    g as sfUint8
    b as sfUint8
    a as sfUint8
end type


' #FUNCTIONS# ===================================================================================================================
Dim Shared sfClock_create As Function () As Long Ptr
Dim Shared sfClock_getElapsedTime As Function (byval clock As Long Ptr) As LongInt
Dim Shared sfRenderWindow_create As Function (byval mode As sfVideoMode, byval title as ZString Ptr, byval style as uinteger, byval settings as long ptr) As Long ptr
Dim Shared sfRenderWindow_getSystemHandle As Function (byval renderWindow As Long Ptr) As LongInt
Dim Shared sfRenderWindow_setVerticalSyncEnabled As Sub (byval renderWindow As Long Ptr, byval enabled as Boolean)
'Dim Shared sfRenderWindow_pollEvent As Function (byval renderWindow As Long Ptr, byref event As Long Ptr) as integer
Dim Shared sfRenderWindow_pollEvent As Function (byval renderWindow As Long Ptr, byval event As sfEvent Ptr) as integer
Dim Shared sfRenderWindow_close As Sub (byval renderWindow As Long Ptr)
Dim Shared sfSprite_create As Function () As Long Ptr
Dim Shared sfTexture_createFromFile As Function (byval filename as ZString Ptr, byval area as long ptr) As long ptr
Dim Shared sfSprite_setTexture As Sub (byval sprite As Long Ptr, byval texture As Long Ptr, byval resetRect As Boolean)
Dim Shared sfRenderWindow_clear As Sub (byval renderWindow As Long Ptr, byval color2 as sfColor)
Dim Shared sfRenderWindow_drawSprite As Sub (byval renderWindow As Long Ptr, byval object2 As Long Ptr, byval states As Long Ptr)
Dim Shared sfRenderWindow_display As Sub (byval renderWindow As Long Ptr)
Dim Shared sfText_create As Function () As Long Ptr
Dim Shared sfFont_createFromFile As Function (byval filename as ZString Ptr) As long ptr
Dim Shared sfText_setString As Sub (byval text As Long Ptr, byval string2 as ZString Ptr)
Dim Shared sfText_setFont As Sub (byval text As Long Ptr, byval font as Long Ptr)
Dim Shared sfText_setCharacterSize As Sub (byval text As Long Ptr, byval size as uinteger)
Dim Shared sfText_setFillColor As Sub (byval text As Long Ptr, byval color2 as sfColor)
Dim Shared sfText_setPosition As Sub (byval text As Long Ptr, byval position As sfVector2f)
Dim Shared sfSprite_setPosition As Sub (byval sprite As Long Ptr, byval position As sfVector2f)
Dim Shared sfRenderWindow_drawText As Sub (byval renderWindow As Long Ptr, byval object2 As Long Ptr, byval states As Long Ptr)
Dim Shared sfSprite_getPosition As Function (byval sprite As Long Ptr) As sfVector2f

Declare Sub _CSFML_Startup
Declare Sub _CSFML_Shutdown
Declare Function _CSFML_sfClock_create () As Long Ptr
Declare Function _CSFML_sfClock_getElapsedTime (clock As Long Ptr) As LongInt
Declare Function _CSFML_sfRenderWindow_create (byval width3 As uinteger, byval height as uinteger, byval bitsPerPixel as uinteger, byval title as ZString Ptr, byval style as uinteger, byval settings as long ptr) As long ptr
Declare Function _CSFML_sfRenderWindow_getSystemHandle (byval renderWindow As Long Ptr) As LongInt
Declare Sub _CSFML_sfRenderWindow_setVerticalSyncEnabled(byval renderWindow As Long Ptr, byval enabled as Boolean)
'Declare Function _CSFML_sfRenderWindow_pollEvent(byval renderWindow As Long Ptr, byref event As Long Ptr) as integer
Declare Function _CSFML_sfRenderWindow_pollEvent(byval renderWindow As Long Ptr, byval event As sfEvent Ptr) as integer
Declare Sub _CSFML_sfRenderWindow_close(byval renderWindow As Long Ptr)
Declare Function _CSFML_sfSprite_create() As long ptr
Declare Function _CSFML_sfTexture_createFromFile(byval filename as ZString Ptr, byval area as long ptr) As long ptr
Declare Sub _CSFML_sfSprite_setTexture(byval sprite As Long Ptr, byval texture As Long Ptr, byval resetRect As Boolean)
Declare Sub _CSFML_sfRenderWindow_clear(byval renderWindow As Long Ptr, byval color2 as sfColor)
Declare Sub _CSFML_sfRenderWindow_drawSprite(byval renderWindow As Long Ptr, byval object2 As Long Ptr, byval states As Long Ptr)
Declare Sub _CSFML_sfRenderWindow_display(byval renderWindow As Long Ptr)
Declare Function _CSFML_sfText_create() As long ptr
Declare Function _CSFML_sfFont_createFromFile(byval filename as ZString Ptr) As long ptr
Declare Sub _CSFML_sfText_setString(byval text As Long Ptr, byval string2 as ZString Ptr)
Declare Sub _CSFML_sfText_setFont(byval text As Long Ptr, byval font as Long Ptr)
Declare Sub _CSFML_sfText_setCharacterSize(byval text As Long Ptr, byval size as uinteger)
Declare Sub _CSFML_sfText_setFillColor(byval text As Long Ptr, byval color2 as sfColor)
Declare Sub _CSFML_sfText_setPosition(byval text As Long Ptr, byval position As sfVector2f)
Declare Sub _CSFML_sfSprite_setPosition(byval sprite As Long Ptr, byval position As sfVector2f)
Declare Sub _CSFML_sfRenderWindow_drawText(byval renderWindow As Long Ptr, byval object2 As Long Ptr, byval states As Long Ptr)
Declare Function _CSFML_sfText_create_and_set(byval font_ptr As Long Ptr, byval size as uinteger, byval color2 as sfColor, byval x as Single, byval y as Single) As long ptr
Declare Function _CSFML_sfSprite_getPosition(byval sprite As Long Ptr) As sfVector2f
' ===============================================================================================================================

' #VARIABLES# ===================================================================================================================
Dim Shared As Any Ptr csfml_system_library
Dim Shared As Any Ptr csfml_graphics_library
Dim Shared As Any Ptr csfml_window_library
Dim Shared As sfColor black => (0, 0, 0, 255)
Dim Shared As sfColor white => (255, 255, 255, 255)
Dim Shared As Any Ptr courier_new_font_ptr
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
Sub _CSFML_Startup

	' load the CSFML DLLs
	csfml_system_library = DyLibLoad( "csfml-system-2.dll" )
	csfml_graphics_library = DyLibLoad( "csfml-graphics-2.dll" )
	csfml_window_library = DyLibLoad( "csfml-window-2.dll" )
	
	' create the SFML System library functions for the CSFML DLLs
	sfClock_create = DyLibSymbol( csfml_system_library, "sfClock_create" )
	sfClock_getElapsedTime = DyLibSymbol( csfml_system_library, "sfClock_getElapsedTime" )

	' create the SFML Graphics library functions for the CSFML DLLs
	sfRenderWindow_create = DyLibSymbol( csfml_graphics_library, "sfRenderWindow_create" )
	sfRenderWindow_getSystemHandle = DyLibSymbol( csfml_graphics_library, "sfRenderWindow_getSystemHandle" )
	sfRenderWindow_setVerticalSyncEnabled = DyLibSymbol( csfml_graphics_library, "sfRenderWindow_setVerticalSyncEnabled" )
	sfRenderWindow_pollEvent = DyLibSymbol( csfml_graphics_library, "sfRenderWindow_pollEvent" )
	sfRenderWindow_close = DyLibSymbol( csfml_graphics_library, "sfRenderWindow_close" )
	sfSprite_create = DyLibSymbol( csfml_graphics_library, "sfSprite_create" )
	sfTexture_createFromFile = DyLibSymbol( csfml_graphics_library, "sfTexture_createFromFile" )
	sfSprite_setTexture = DyLibSymbol( csfml_graphics_library, "sfSprite_setTexture" )
	sfRenderWindow_clear = DyLibSymbol( csfml_graphics_library, "sfRenderWindow_clear" )
	sfRenderWindow_drawSprite = DyLibSymbol( csfml_graphics_library, "sfRenderWindow_drawSprite" )
	sfRenderWindow_display = DyLibSymbol( csfml_graphics_library, "sfRenderWindow_display" )
	sfText_create = DyLibSymbol( csfml_graphics_library, "sfText_create" )
	sfFont_createFromFile = DyLibSymbol( csfml_graphics_library, "sfFont_createFromFile" )
	sfText_setString = DyLibSymbol( csfml_graphics_library, "sfText_setString" )
	sfText_setFont = DyLibSymbol( csfml_graphics_library, "sfText_setFont" )
	sfText_setCharacterSize = DyLibSymbol( csfml_graphics_library, "sfText_setCharacterSize" )
	sfText_setFillColor = DyLibSymbol( csfml_graphics_library, "sfText_setFillColor" )
	sfText_setPosition = DyLibSymbol( csfml_graphics_library, "sfText_setPosition" )
	sfSprite_setPosition = DyLibSymbol( csfml_graphics_library, "sfSprite_setPosition" )
	sfRenderWindow_drawText = DyLibSymbol( csfml_graphics_library, "sfRenderWindow_drawText" )
	sfSprite_getPosition = DyLibSymbol( csfml_graphics_library, "sfSprite_getPosition" )


  '  courier_new_font_ptr = sfFont_createFromFile("C:\Windows\Fonts\cour.ttf")


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
sub _CSFML_Shutdown

	' unload the DLLs
	DylibFree( csfml_system_library )
	DylibFree( csfml_graphics_library )
	DylibFree( csfml_window_library )

End sub


' #SFCLOCK FUNCTIONS# =====================================================================================================


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfClock_create
' Description ...: Create a new clock and start it.
' Syntax.........: _CSFML_sfClock_create()
' Parameters ....:
' Return values .: Success - A pointer to the clock (sfClock).
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfClock_getElapsedTime
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfClock_create() As Long Ptr

	Dim As Long Ptr fred = sfClock_create()
	Return fred
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfClock_getElapsedTime
' Description ...: Get the time elapsed in a clock.
'				   This function returns the time elapsed since the last call to _CSFML_sfClock_restart or _CSFML_sfClock_create.
' Syntax.........: _CSFML_sfClock_getElapsedTime($clock)
' Parameters ....:
' Return values .: Success - Time elapsed (in microseconds).
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfClock_create, _CSFML_sfClock_restart
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfClock_getElapsedTime(clock As Long Ptr) As LongInt
	
	Dim As LongInt fred2 = sfClock_getElapsedTime(clock)
	Return fred2

End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfRenderWindow_create
' Description ...: Constructs a new render window.
' Syntax.........: _CSFML_sfRenderWindow_create($mode, $title, $style, $settings)
' Parameters ....: $mode - Video mode to use
'				   $title - Title of the window
'				   $style - Window style
'				   $settings - Creation settings (pass Null to use default values)
' Return values .: Success - a pointer to the sfRenderWindow structure (PTR)
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfRenderWindow_create(byval width3 As uinteger, byval height as uinteger, byval bitsPerPixel as uinteger, byval title as ZString Ptr, byval style as uinteger, byval settings as long ptr) As long ptr

'Dim Shared As sfVideoMode Mode => (1024, 768, 32)

    dim mode as sfVideoMode
    mode.width2 = width3
    mode.height2 = height
    mode.bitsPerPixel2 = bitsPerPixel
    
	Dim As long ptr fred3 = sfRenderWindow_create(mode, title, style, settings)
	Return fred3
End function


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfRenderWindow_getSystemHandle
' Description ...: Retrieve the OS-specific handle of a render window.
' Syntax.........: _CSFML_sfRenderWindow_getSystemHandle($renderWindow, $limit)
' Parameters ....: $renderWindow - Render window object
' Return values .: Success - Window handle
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfRenderWindow_create
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfRenderWindow_getSystemHandle(byval renderWindow As Long Ptr) As LongInt
	
	Dim As LongInt fred2 = sfRenderWindow_getSystemHandle(renderWindow)
	Return fred2
End Function



' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfRenderWindow_setVerticalSyncEnabled
' Description ...: Enable / disable vertical synchronization on a render window.
' Syntax.........: _CSFML_sfRenderWindow_setVerticalSyncEnabled($renderWindow, $enabled)
' Parameters ....: $renderWindow - Render window object
'				   $enabled - True to enable v-sync, False to deactivate
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfRenderWindow_create
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfRenderWindow_setVerticalSyncEnabled(byval renderWindow As Long Ptr, byval enabled as Boolean)
	
	sfRenderWindow_setVerticalSyncEnabled(renderWindow, enabled)
End Sub

'Func  _CSFML_sfRenderWindow_setVerticalSyncEnabled($renderWindow, $enabled)

'	DllCall($__CSFML_Graphics_DLL, "NONE:cdecl", "sfRenderWindow_setVerticalSyncEnabled", "PTR", $renderWindow, "BOOL", $enabled)
'	If @error > 0 Then Return SetError(@error,0,0)

'	Return True
'EndFunc


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfRenderWindow_pollEvent
' Description ...: Get the event on top of event queue of a render window, if any, and pop it.
' Syntax.........: _CSFML_sfRenderWindow_pollEvent($renderWindow, $event)
' Parameters ....: $renderWindow - Render window object
'				   $event - Event to fill, if any
' Return values .: Success - True if an event was returned, False if event queue was empty
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfRenderWindow_create
' Link ..........:
' Example .......:
' ===============================================================================================================================
'Function _CSFML_sfRenderWindow_pollEvent(byval renderWindow As Long Ptr, byref event As Long Ptr) as integer
Function _CSFML_sfRenderWindow_pollEvent(byval renderWindow As Long Ptr, byval event As sfEvent Ptr) as integer
	
	dim as integer fred = sfRenderWindow_pollEvent(renderWindow, event)
    
  '  dim as sfEvent joe
  '  joe = *event
    
  '  if joe.T <> 0 and joe.T <> 11 and joe.T <> 12 and joe.T <> 13 then
    
  '      print joe.T
  '  endif
	return fred
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfRenderWindow_close
' Description ...: Close a render window (but doesn't destroy the internal data).
' Syntax.........: _CSFML_sfRenderWindow_close($renderWindow)
' Parameters ....: $renderWindow - Render window object
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfRenderWindow_create
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfRenderWindow_close(byval renderWindow As Long Ptr)

	sfRenderWindow_close(renderWindow)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfSprite_create
' Description ...: Create a new sprite.
' Syntax.........: _CSFML_sfSprite_create()
' Parameters ....: None
' Return values .: Success - A new sfSprite object (PTR)
'				   Failure - 0 or Null
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfSprite_create() As long ptr

    Dim As long ptr fred3 = sfSprite_create()
    return fred3
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfTexture_createFromFile
' Description ...: Create a new texture from a file.
' Syntax.........: _CSFML_sfTexture_createFromFile($filename, $area)
' Parameters ....: $filename - Path of the image file to load
'				   $area - Area of the source image to load (Null to load the entire image)
' Return values .: Success - a pointer to the sfTexture (PTR)
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfTexture_createFromFile(byval filename as ZString Ptr, byval area as long ptr) As long ptr

    Dim As long ptr fred3 = sfTexture_createFromFile(filename, area)
    return fred3
End Function



' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfSprite_setTexture
' Description ...: Change the source texture of a sprite.
'				   The texture argument refers to a texture that must exist as long as the sprite uses it.
'				   Indeed, the sprite doesn't store its own copy of the texture, but rather keeps a pointer to the one that
'				   you passed to this function. If the source texture is destroyed and the sprite tries to use it, the behaviour
'                  is undefined. If resetRect is true, the TextureRect property of the sprite is automatically adjusted to the
'				   size of the new texture. If it is false, the texture rect is left unchanged.
' Syntax.........: _CSFML_sfSprite_setTexture($sprite, $texture, $resetRect)
' Parameters ....: $sprite - Sprite to delete
'				   $texture - New texture
'				   $resetRect - Should the texture rect be reset to the size of the new texture?
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfSprite_create
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfSprite_setTexture(byval sprite As Long Ptr, byval texture As Long Ptr, byval resetRect As Boolean)

	sfSprite_setTexture(sprite, texture, resetRect)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfRenderWindow_clear
' Description ...: Clear a render window with the given color.
' Syntax.........: _CSFML_sfRenderWindow_clear($renderWindow, $color)
' Parameters ....: $renderWindow - Render window object
'				   $color - Fill color
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfRenderWindow_create
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfRenderWindow_clear(byval renderWindow As Long Ptr, byval color2 as sfColor)

    sfRenderWindow_clear(renderWindow, color2)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfRenderWindow_drawSprite
' Description ...: Draw a drawable object to the render-target.
' Syntax.........: _CSFML_sfRenderWindow_drawSprite($renderWindow, $object, $states)
' Parameters ....: $renderWindow - Render window object
'				   $object - the sprite to draw
'				   $states - Render states to use for drawing (Null to use the default states)
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfRenderWindow_create
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfRenderWindow_drawSprite(byval renderWindow As Long Ptr, byval object2 As Long Ptr, byval states As Long Ptr)

    sfRenderWindow_drawSprite(renderWindow, object2, states)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfRenderWindow_display
' Description ...: Display a render window on screen.
' Syntax.........: _CSFML_sfRenderWindow_display($renderWindow)
' Parameters ....: $renderWindow - Render window object
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfRenderWindow_create
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfRenderWindow_display(byval renderWindow As Long Ptr)

    sfRenderWindow_display(renderWindow)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfText_create
' Description ...: Create a new text.
' Syntax.........: _CSFML_sfText_create()
' Parameters ....: None
' Return values .: Success - A new sfText object
'				   Failure - 0 or Null
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfText_create() As long ptr

    Dim As long ptr fred3 = _CSFML_sfText_create()
    return fred3
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfFont_createFromFile
' Description ...: Create a new font from a file.
' Syntax.........: _CSFML_sfFont_createFromFile($filename)
' Parameters ....: $filename - Path of the font file to load
' Return values .: Success - A new sfFont object
'				   Failure - 0 or Null
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfFont_createFromFile(byval filename as ZString Ptr) As long ptr

    Dim As long ptr fred3 = sfFont_createFromFile(filename)
    return fred3
End Function


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfText_setString
' Description ...: Set the string of a text (from an ANSI string).
'				   A text's string is empty by default
' Syntax.........: _CSFML_sfText_setString($text, $string)
' Parameters ....: $text - Text object
'				   $string - New string
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfText_setString(byval text As Long Ptr, byval string2 as ZString Ptr)

    sfText_setString(text, string2)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfText_setFont
' Description ...: Set the font of a text.
'				   The font argument refers to a texture that must exist as long as the text uses it. Indeed, the text
'				   doesn't store its own copy of the font, but rather keeps a pointer to the one that you passed to this
'				   function. If the font is destroyed and the text tries to use it, the behaviour is undefined
' Syntax.........: _CSFML_sfText_setFont($text, $font)
' Parameters ....: $text - Text object
'				   $font - New font
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfText_setFont(byval text As Long Ptr, byval font as Long Ptr)

    sfText_setFont(text, font)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfText_setCharacterSize
' Description ...: Set the character size of a text.
'				   The default size is 30.
' Syntax.........: _CSFML_sfText_setCharacterSize($text, $size)
' Parameters ....: $text - Text object
'				   $size - New character size, in pixels
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfText_setCharacterSize(byval text As Long Ptr, byval size as uinteger)

    sfText_setCharacterSize(text, size)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfText_setFillColor
' Description ...: Set the fill color of a text.
'				   By default, the text's fill color is opaque white. Setting the fill color to a transparent color with an
'				   outline will cause the outline to be displayed in the fill area of the text.
' Syntax.........: _CSFML_sfText_setFillColor($text, $color)
' Parameters ....: $text - Text object
'				   $color - New fill color of the text
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfText_setFillColor(byval text As Long Ptr, byval color2 as sfColor)

    sfText_setFillColor(text, color2)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfText_setPosition
' Description ...: Set the position of a text.
'				   This function completely overwrites the previous position. See sfText_move to apply an offset based on
'				   the previous position instead. The default position of a text Text object is (0, 0).

' Syntax.........: _CSFML_sfText_setPosition($text, $position)
' Parameters ....: $text - Text object
'				   $position - New position
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfText_setPosition(byval text As Long Ptr, byval position As sfVector2f)

    sfText_setPosition(text, position)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfSprite_getPosition
' Description ...: Set the position of a sprite, with a sfVector2f structure.
'				   This function completely overwrites the previous position. See sfSprite_move to apply an offset based
'				   on the previous position instead. The default position of a sprite Sprite object is (0, 0).
' Syntax.........: _CSFML_sfSprite_getPosition($sprite, $position)
' Parameters ....: $sprite - Sprite object
'				   $position - New position (sfVector2f)
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......: This function is slightly slower than _CSFML_sfSprite_setPosition_xy by about 100 frames per second
' Related .......: _CSFML_sfSprite_create, _CSFML_sfVector2f_Constructor
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfSprite_getPosition(byval sprite As Long Ptr) As sfVector2f

    Dim As sfVector2f sprite_pos = sfSprite_getPosition(sprite)
    return sprite_pos
End Function

' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfSprite_setPosition
' Description ...: Set the position of a sprite, with a sfVector2f structure.
'				   This function completely overwrites the previous position. See sfSprite_move to apply an offset based
'				   on the previous position instead. The default position of a sprite Sprite object is (0, 0).
' Syntax.........: _CSFML_sfSprite_setPosition($sprite, $position)
' Parameters ....: $sprite - Sprite object
'				   $position - New position (sfVector2f)
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......: This function is slightly slower than _CSFML_sfSprite_setPosition_xy by about 100 frames per second
' Related .......: _CSFML_sfSprite_create, _CSFML_sfVector2f_Constructor
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfSprite_setPosition(byval sprite As Long Ptr, byval position As sfVector2f)

    sfSprite_setPosition(sprite, position)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfRenderWindow_drawText
' Description ...: Draw text in a render window.
' Syntax.........: _CSFML_sfRenderWindow_drawText($renderWindow, $object, $states)
' Parameters ....: $renderWindow - Render window object
'				   $object - the text to draw
'				   $states - Render states to use for drawing (Null to use the default states)
' Return values .: Success - True
'				   Failure - 0
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......: _CSFML_sfRenderWindow_create
' Link ..........:
' Example .......:
' ===============================================================================================================================
Sub _CSFML_sfRenderWindow_drawText(byval renderWindow As Long Ptr, byval object2 As Long Ptr, byval states As Long Ptr)

    sfRenderWindow_drawText(renderWindow, object2, states)
End Sub


' #FUNCTION# ====================================================================================================================
' Name...........: _CSFML_sfText_create_and_set
' Description ...: A convenience function to create a new text and also set it's properties in one call.
' Syntax.........: _CSFML_sfText_create_and_set()
' Parameters ....: None
' Return values .: Success - A new sfText object
'				   Failure - 0 or Null
' Author ........: Sean Griffin
' Modified.......:
' Remarks .......:
' Related .......:
' Link ..........:
' Example .......:
' ===============================================================================================================================
Function _CSFML_sfText_create_and_set(byval font_ptr As Long Ptr, byval size as uinteger, byval color2 as sfColor, byval x as Single, byval y as Single) As long ptr
    
    Dim As Long Ptr text_ptr = sfText_create()
    sfText_setFont(text_ptr, font_ptr)
    sfText_setCharacterSize(text_ptr, size)
    sfText_setFillColor(text_ptr, color2)
    Dim As sfVector2f text_pos => (x, y)
    sfText_setPosition(text_ptr, text_pos)
    
    return text_ptr
End Function

