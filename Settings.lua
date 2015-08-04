function RGE.LoadSavedSettings()
	local defaultSettings = {
  		notifications = true,
  		display_equipped = true,
  		display_inventory = false,
  		display_enchantment = true,
  		display_description = true,
  	}
  	-- Documentation: ZO_SavedVars:NewAccountWide(savedVariableName, settingsVersion, settingsNamespace, defaultSettings, settingsProfile)
  	RGE.savedSettings = ZO_SavedVars:NewAccountWide("RGE_SavedSettings", 1, "RGE", defaultSettings, "RGE")
end

function RGE.InitAddOnSettings()
	local LAM2 = LibStub("LibAddonMenu-2.0")

	local panelData = {
		type = "panel",
		name = RGE.LONGNAME,
		displayName = RGE.COLORS.BLUE..RGE.LONGNAME,
		author = RGE.AUTHOR,
		version = RGE.VERSION,
	}

	LAM2:RegisterAddonPanel(RGE.SHORTNAME.."Options", panelData)

	local optionsData = {
		[1] = {

			type = "description",
			text = "Note: The following settings are Account-bound and will be the same across all characters.",
		},
        [2] = {
			type = "checkbox",
			name = "Display chat greeting",
			tooltip = "Recieve chat notification from "..RGE.LONGNAME..".",
			getFunc = function() return RGE.getSavedSetting("notifications") end,
			setFunc = function(state) RGE.setSavedSetting("notifications", state) end,
        },
        [3] = {
        	type = "checkbox",
			name = "Display equipped items in enchantable toolip",
			tooltip = "Display equipped items that can be enchanted in the tooltip when hovering over a glyph",
			getFunc = function() return RGE.getSavedSetting("display_equipped") end,
			setFunc = function(state) RGE.setSavedSetting("display_equipped", state) end,
    	},
    	[4] = {
    		type = "checkbox",
			name = "Display inventory items in enchantable tooltip",
			tooltip = "Display items in inventory that can be enchanted in the tooltip when hovering over a glyph",
			getFunc = function() return RGE.getSavedSetting("display_inventory") end,
			setFunc = function(state) RGE.setSavedSetting("display_inventory", state) end,
    	},
    	[5] = {
    		type = "checkbox",
			name = "Show current enchantment in tooltips",
			tooltip = "Shows the current enchantment when listing items in tooltips. Warning: this makes the tooltips longer and sometimes harder to read",
			getFunc = function() return RGE.getSavedSetting("display_enchantment") end,
			setFunc = function(state) RGE.setSavedSetting("display_enchantment", state) end,
    	},
    	[6] = {
    		type = "checkbox",
			name = "Show enchantment description in tooltips",
			tooltip = "Shows the current enchantment description when listing items in tooltips. Warning: this makes the tooltips MUCH longer and sometimes harder to read",
			getFunc = function() return RGE.getSavedSetting("display_description") end,
			setFunc = function(state) RGE.setSavedSetting("display_description", state) end,
    	},
    }

	LAM2:RegisterOptionControls(RGE.SHORTNAME.."Options", optionsData)
end

function RGE.getSavedSetting(setting)
	return RGE.savedSettings[setting]
end

function RGE.setSavedSetting(setting, state)
	RGE.savedSettings[setting] = state
end