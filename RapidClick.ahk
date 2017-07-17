$+#LButton::
  Loop
  {
    SetMouseDelay, 5
    Click
    If Not GetKeyState("LButton", "P")
    Break
  }
Return
