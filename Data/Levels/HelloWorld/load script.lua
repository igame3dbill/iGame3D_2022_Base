-- Create a new text box t with the default font 
-- This font is loaded at startup of iGame3D and uses "Data/FontPngs/default32_1.png" and "Data/FontPngs/default32_2.png"
t=make(ig3d_text_box, "Data/FontPngs/default32_1.png")
-- Make this text box read "Hello, World"
setText_boxInfo(t, IG3D_TEXT, "Hello, World")
-- Set the position of the text box to top-left corner of the window (with an offset of 50 pixels in the horizontal and vertical)
setText_boxInfo(t, IG3D_POSITION, 50,50)
-- Use only the FLTK updating routine as the game function. You can define your own function and make game_func
-- point to it to run your own game code
game_func=fltk_update