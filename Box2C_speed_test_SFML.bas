#Include once "CSFML.bi"


' Setup SFML
_CSFML_Startup


'Dim As Long Ptr fred = _CSFML_sfClock_create()
'Print fred

'dim as longint xxx = _CSFML_sfClock_getElapsedTime(fred)
'Print xxx

Dim As Long Ptr window_ptr = _CSFML_sfRenderWindow_create(800, 600, 16, "xxx", 6, 0)
dim as longint xxx = _CSFML_sfRenderWindow_getSystemHandle(window_ptr)
print xxx
_CSFML_sfRenderWindow_setVerticalSyncEnabled(window_ptr, 0)

Dim As Long Ptr event_ptr
dim as integer www

while 1
www = _CSFML_sfRenderWindow_pollEvent(window_ptr, event_ptr)
print www
wend
Sleep


' Shutdown SFML
_CSFML_Shutdown


