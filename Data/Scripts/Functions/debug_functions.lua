function d()
F=print
D=debug.getinfo(F)
for i,v in pairs(D) do print(i,v) end
end


--[[The following function illustrates the use of debug.getinfo. It prints a primitive traceback of the active stack:]]--

    function traceback ()
      local level = 1
      while true do
        local info = debug.getinfo(level, "Sl")
        if not info then break end
        if info.what == "C" then   -- is a C function?
          print(level, "C function")
        else   -- a Lua function
          print(string.format("[%s]:%d",
                              info.short_src, info.currentline))
        end
        level = level + 1
      end
    end
--[[It is not difficult to improve this function, including more data from getinfo. Actually, the debug library offers such an improved version, debug.traceback. Unlike our version, debug.traceback does not print its result; instead, it returns a string.]]--