
--function colormap_cb()
--	local newcolor=fltk.fl_show_colormap(colormap:color())
--	colormap:hide() -- so there is no label overlap
--	colormap:color(newcolor)
--	colormap:label("FLTK Color "..newcolor)
--	w:redraw()
--	colormap:show()
--	colormap:set_changed()
--	colormap:redraw_label()
--        Fl:flush()
--end

--pop=fltk:Fl_Return_Button(left+bw,row+bw,bw*16,80,"push for built-in color map")
--colormap=fltk:Fl_Button(380,20,100,80,"fl_show_colormap")
--colormap:align(fltk.FL_ALIGN_BOTTOM)
--colormap:callback(colormap_cb)

--colorchooser=fltk:Fl_Button(380,125,100,80,"fl_color_chooser")
--colorchooser:align(fltk.FL_ALIGN_BOTTOM)
--colorchooser:color(15)
--colorchooser:callback(
--function(colorchooser_cb)
--local-- color_o k -
	-- initialize loal variables
	--gRed,gGreen,gBlue=Fl:get_color(colorchooser:color(),gRed,gGreen,gBlue)
	colorChooser = fltk.fl_color_chooser(gEditingMode, gRed, gGreen, gBlue)
	colorChooser:callback(handleColorInput)
	if colorChooser == 1 then -- color_ok represents the first value (exit status) returned by fl_color_chooser
	hexcolor=string.format("#%.2X%.2X%.2X",gRed, gGreen, gBlue) -- convert the rgb values to hex
	handleColorInput(colorChooser)
	end
--end
--)
