local log = hs.logger.new('focusOrLaunch','debug')

------------------------------
-- jump or exec
------------------------------
local function focusOrLaunchApp(appName)
    local app = hs.application.get(appName)
    
    if app then
        local windows = app:allWindows()

        if app:isFrontmost() and #windows == 1 then
            return -- Do nothing if app is already focused
        end
        
        if #windows > 1 then
	   windows[#windows]:focus()
        end

	if #windows == 1 then
           app:activate()	    
	end

	-- no window left
	hs.application.launchOrFocus(appName)
    else
        hs.alert.show("Starting " .. appName .. "...")
        hs.application.launchOrFocus(appName)
    end
end

-- create a new hotkey modal with no key binding to activated/deactivate it. we will activate/deactivate it based on the current app being used
focusOrLaunchModal = hs.hotkey.modal.new({""}, nil)

focusOrLaunchModal:bind({"cmd"}, "e", function()
    focusOrLaunchApp("Emacs")
end)

focusOrLaunchModal:bind({"cmd", "shift"}, "s", function()
    focusOrLaunchApp("Microsoft Teams")
end)

focusOrLaunchModal:bind({"cmd"}, "a", function()
    focusOrLaunchApp("Lark")
end)

focusOrLaunchModal:bind({"cmd"}, "return", function()
    focusOrLaunchApp("iTerm")
end)

focusOrLaunchModal:bind({"cmd"}, "d", function()
    focusOrLaunchApp("Firefox")
end)

-- focusOrLaunchModal:bind({"cmd"}, "f", function()
--       if hs.application.get("Firefox"):isFrontmost() then
-- 	 focusOrLaunchModal:exit()
-- 	 hs.eventtap.keyStroke({"cmd"}, "f")
-- 	 focusOrLaunchModal:enter()
--       else
-- 	 focusOrLaunchApp("Firefox")
--       end
-- end)

focusOrLaunchModal:enter()

---------------------------------
-- move window to another screen
---------------------------------
hs.hotkey.bind({'cmd'}, ';', function()
      -- get the focused window
      local win = hs.window.focusedWindow()
      -- get the screen where the focused window is displayed, a.k.a. current screen
      local screen = win:screen()
      -- compute the unitRect of the focused window relative to the current screen
      -- and move the window to the next screen setting the same unitRect 
      win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
end)

---------------------------------
-- maximium or restore a window
---------------------------------
function isAlreadyMax(curFrame, targetFrame)
   local epsilon = 5
   if math.abs(curFrame.x - targetFrame.x) < epsilon and
      math.abs(curFrame.y - targetFrame.y) < epsilon and
      math.abs(curFrame.w - targetFrame.w) < epsilon and
      math.abs(curFrame.h - targetFrame.h) < epsilon then
      return true
   else
      return false
   end
end
      
previousFrameSizes = {}
hs.hotkey.bind({'cmd'}, 'm', function()
      local curWin = hs.window.focusedWindow()
      local curWinFrame = curWin:frame()
      local targetFrame = curWin:screen():frame()

      if not isAlreadyMax(curWinFrame, targetFrame) then
	 previousFrameSizes[curWin:id()] = curWinFrame
	 curWin:setFrame(targetFrame)
      elseif previousFrameSizes[curWin:id()] then
	 curWin:setFrame(previousFrameSizes[curWin:id()])
	 previousFrameSizes[curWin:id()] = nil
      end
end)
