local showingPopupTooltip = false

local hookSetWornItem = ItemTooltip.SetWornItem
ItemTooltip.SetWornItem = function(control, slotIndex, ...)
	hookSetWornItem(control, slotIndex, ...)
	RGE.AddGlyphTooltipInfo(control, BAG_WORN, slotIndex)
end

local hookSetBagItem = ItemTooltip.SetBagItem
ItemTooltip.SetBagItem = function(control, bagId, slotIndex, ...)
	hookSetBagItem(control, bagId, slotIndex, ...)
	RGE.AddGlyphTooltipInfo(control, bagId, slotIndex)
end

local hookClearTooltip = ClearTooltip
ClearTooltip = function(control)
	hookClearTooltip(control)
	if (control:GetName() == 'ItemTooltip' and showingPopupTooltip) then
		ZO_PopupTooltip_Hide()
	end
end

-- this entire function is so hacky...
local function initPopupTooltip(control, item)
	showingPopupTooltip = true
	if (item.bag == BAG_WORN) then
		InitializeTooltip(PopupTooltip, control, TOPRIGHT, 430, 0, TOPRIGHT)
	else 
		if (item.__index == RGE_Enchantable) then
			InitializeTooltip(PopupTooltip, control, TOPLEFT, -872, 0, TOPLEFT)
		else
			InitializeTooltip(PopupTooltip, control, TOPLEFT, -440, 0, TOPLEFT)
		end
	end
end

function RGE.AddGlyphTooltipInfo(control, bagId, slotIndex)
	if (not RGE.getSavedSetting("display_equipped") or
		not RGE.getSavedSetting("display_inventory") or
		not bagId or not slotIndex) 
	then return end
	-- try glyph	
	local item = RGE_Glyph:New(bagId, slotIndex)
	local isItemValid = item:IsValid()
	if (not isItemValid) then
		-- try enchantable
		item = RGE_Enchantable:New(bagId, slotIndex) -- should probably make a copy constructor 
		isItemValid = item:IsValid()
	end
	if (isItemValid) then
		initPopupTooltip(control, item)
		item:HandleTooltip()
	end
end

