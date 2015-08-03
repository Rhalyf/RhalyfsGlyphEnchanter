RGE = {}

function RGE.OnLoad(event, addOnName)
  	if (addOnName ~= RGE.SHORTNAME) then return end

  	EVENT_MANAGER:UnregisterForEvent("RGE_Loaded", EVENT_ADD_ON_LOADED)	

	RGE.LoadSavedSettings()
	RGE.InitAddOnSettings()
end

function RGE.SignOfLife()
	EVENT_MANAGER:UnregisterForEvent("RGE_Player_Active", EVENT_PLAYER_ACTIVATED)
	RGE.Write("Thanks for using "..RGE.COLORS.WHITE..RGE.LONGNAME..RGE.COLORS.GRAY.."!!", true)
end

function RGE.Write(message, includeName)
	if (not RGE.getSavedSetting("notifications")) then return end

	local preMessage = RGE.COLORS.BLUE
	if (includeName == true) then
		preMessage = preMessage..RGE.LONGNAME..": "
	end

	d(preMessage..RGE.COLORS.GRAY..message.."\n")
end

function RGE.IsEmpty(str)
	return str == nil or str == ""
end

function RGE.AddTTLine(str, font)
	if (not font) then
		font = "ZoFontWinH5"
	end
	ItemTooltip:AddLine(str, font, 1, 1, 1, BOTTOM, MODIFY_TEXT_TYPE_NONE, TEXT_ALIGN_CENTER, null)
end

function RGE.WriteTable(t)
	local str = ""
	for k, v in pairs(t) do
		str = str.."["..k.."]="..tostring(v)..",\n"
	end
	RGE.Write(str)
end

EVENT_MANAGER:RegisterForEvent("RGE_Loaded", EVENT_ADD_ON_LOADED, RGE.OnLoad)
EVENT_MANAGER:RegisterForEvent("RGE_Player_Active", EVENT_PLAYER_ACTIVATED, RGE.SignOfLife)