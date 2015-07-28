RGE = {}

-- https://github.com/Sephiroth018/GuildStoreSearchExtended/blob/master/tooltips.lua

function RGE.OnLoad(event, addOnName)
  	if (addOnName ~= RGE.SHORTNAME) then return end

  	EVENT_MANAGER:UnregisterForEvent("RGE_Loaded", EVENT_ADD_ON_LOADED)	

	RGE.LoadSavedSettings()
	RGE.InitAddOnSettings()
	RGE.AttachInventoryPreHooks()
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

	d(preMessage..RGE.COLORS.GRAY..message.."|r")
end

function RGE.IsEmpty(str)
	return str == nil or str == ""
end

EVENT_MANAGER:RegisterForEvent("RGE_Loaded", EVENT_ADD_ON_LOADED, RGE.OnLoad)
EVENT_MANAGER:RegisterForEvent("RGE_Player_Active", EVENT_PLAYER_ACTIVATED, RGE.SignOfLife)