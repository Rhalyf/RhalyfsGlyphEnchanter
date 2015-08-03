-- LOOK INTO POPUP TOOLTIPS TOO
local hookSetWornItem = ItemTooltip.SetWornItem
ItemTooltip.SetWornItem = function(control, slotIndex, ...)
	hookSetWornItem(control, slotIndex, ...)
	RGE.AddGlyphTooltipInfo(BAG_WORN, slotIndex)
end

local hookSetBagItem = ItemTooltip.SetBagItem
ItemTooltip.SetBagItem = function(control, bagId, slotIndex, ...)
	hookSetBagItem(control, bagId, slotIndex, ...)
	RGE.AddGlyphTooltipInfo(bagId, slotIndex)
end

function RGE.AddGlyphTooltipInfo(bagId, slotIndex)
	if (not bagId or not slotIndex) then return end
	-- try glyph	
	local item = RGE_Glyph:New(bagId, slotIndex)
	if (item:IsValid()) then 
		item:HandleTooltip()
	else
		-- try enchantable
		item = RGE_Enchantable:New(bagId, slotIndex) -- should probably make a copy constructor 
		if (item:IsValid()) then
			item:HandleTooltip()
		end
	end
end