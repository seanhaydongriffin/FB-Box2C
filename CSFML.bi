
' #INDEX# =======================================================================================================================
' Title .........: CSFML
' FreeBasic Version : ?
' Language ......: English
' Description ...: SFML Functions.
' Author(s) .....: Sean Griffin
' Dlls ..........: csfml-system-2.dll, csfml-graphics-2.dll
' ===============================================================================================================================

#ifndef NULL
const NULL as any ptr = 0
#endif


type sfVideoMode
    width2 as uinteger
    height2 as uinteger
    bitsPerPixel2 as uinteger
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


' #SUBROUTINES# ===================================================================================================================
Declare Sub _CSFML_Startup
Declare Sub _CSFML_Shutdown
' ===============================================================================================================================
	
' #FUNCTIONS# ===================================================================================================================
Dim Shared sfClock_create As Function () As Long Ptr
Dim Shared sfClock_getElapsedTime As Function (byval clock As Long Ptr) As LongInt
Dim Shared sfRenderWindow_create As Function (byval mode As sfVideoMode, byval title as ZString Ptr, byval style as uinteger, byval settings as long ptr) As Long ptr
Dim Shared sfRenderWindow_getSystemHandle As Function (byval renderWindow As Long Ptr) As LongInt
Dim Shared sfRenderWindow_setVerticalSyncEnabled As Sub (byval renderWindow As Long Ptr, byval enabled as Boolean)
Dim Shared sfRenderWindow_pollEvent As Function (byval renderWindow As Long Ptr, byref event As Long Ptr) as integer

Declare Function _CSFML_sfClock_create () As Long Ptr
Declare Function _CSFML_sfClock_getElapsedTime (clock As Long Ptr) As LongInt
Declare Function _CSFML_sfRenderWindow_create (byval width3 As uinteger, byval height as uinteger, byval bitsPerPixel as uinteger, byval title as ZString Ptr, byval style as uinteger, byval settings as long ptr) As long ptr
Declare Function _CSFML_sfRenderWindow_getSystemHandle (byval renderWindow As Long Ptr) As LongInt
Declare Sub _CSFML_sfRenderWindow_setVerticalSyncEnabled(byval renderWindow As Long Ptr, byval enabled as Boolean)
Declare Function _CSFML_sfRenderWindow_pollEvent(byval renderWindow As Long Ptr, byref event As Long Ptr) as integer
' ===============================================================================================================================

' #VARIABLES# ===================================================================================================================
Dim Shared As Any Ptr csfml_system_library
Dim Shared As Any Ptr csfml_graphics_library
Dim Shared As Any Ptr csfml_window_library
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
Function _CSFML_sfRenderWindow_pollEvent(byval renderWindow As Long Ptr, byref event As Long Ptr) as integer
	
	dim as integer fred = sfRenderWindow_pollEvent(renderWindow, event)
	return fred
End Function

'Func  _CSFML_sfRenderWindow_pollEvent($renderWindow, $event)

'	Local $sfBool = DllCall($__CSFML_Graphics_DLL, "INT:cdecl", "sfRenderWindow_pollEvent", "PTR", $renderWindow, "PTR", $event)
'	If @error > 0 Then Return SetError(@error,0,0)

'	Local $sfBool_val = $sfBool[0]
'	Return $sfBool_val
'EndFunc

