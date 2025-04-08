local log = hs.logger.new('focusOrLaunch','debug')

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

focusOrLaunchModal:bind({"cmd"}, "s", function()
    focusOrLaunchApp("Lark")
end)

focusOrLaunchModal:bind({"cmd"}, "return", function()
    focusOrLaunchApp("iTerm")
end)

focusOrLaunchModal:bind({"cmd"}, "f", function()
      if hs.application.get("Firefox"):isFrontmost() then
	 focusOrLaunchModal:exit()
	 hs.eventtap.keyStroke({"cmd"}, "f")
	 focusOrLaunchModal:enter()
      else
	 focusOrLaunchApp("Firefox")
      end
end)

focusOrLaunchModal:enter()
