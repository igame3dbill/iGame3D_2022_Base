-- save screenshot
function save_screenshot()
screenShotPath=gameroot..ig3d_GetLevelName__s().."/"..os.time()..".png"
ig3d_SaveScreenshot_s2bi(screenShotPath,false,false,16)
end

