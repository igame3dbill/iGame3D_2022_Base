-- CHOOSE FILE OR FOLDER

function chooseFolder(title,start_path)
-- fl_dir_chooser (function)
-- fltk.fl_dir_chooser(title,start_path,relative)
-- "relative" is a toggle. Non-zero means the filename returned will be a relative path, and zero returns absolute path. 
-- Using nil as start path will default to the previously chosen path,
-- or current directory if this is the first time the function is called
local relative=0
 local dirname=fltk.fl_dir_chooser(title,start_path,relative)
 if dirname then tFolder= replaceText(gameroot,"",dirname) end
 return tFolder 
end


function chooseFile(title,filename_filter,start_path)
-- fl_file_chooser (function)
-- fltk.fl_file_chooser(title,filename_filter,start_path,relative)
-- "relative" is a toggle. Non-zero means the filename returned will be a relative path, and zero returns absolute path. 
local relative=0
local filename=fltk.fl_file_chooser(title,filename_filter,start_path,relative)
 if filename then tFile= replaceText(gameroot,"",filename) end
 return tFile 
end

--Cancel
function canceldialog()
--beep()
--dialogWindow:hide();
end