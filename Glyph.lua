RGE_Glyph = RGE_Item:New()

function RGE_Glyph:IsValid()
	return (self.bag > -1 and
			self.slot > -1 and
			not RGE.IsEmpty(self.link) and
			not RGE.IsEmpty(self.name)) and
			(self.type == ITEMTYPE_GLYPH_ARMOR or
	   		 self.type == ITEMTYPE_GLYPH_JEWELRY or
	   		 self.type == ITEMTYPE_GLYPH_WEAPON)
end

function RGE_Glyph:AddTooltipLines() -- Add Tooltip lines for Glyph tooltip
	local displayEquipped = RGE.getSavedSetting("display_equipped")
	local displayInventory = RGE.getSavedSetting("display_inventory")

	if (displayEquipped or displayInventory) then
		RGE.AddTTLine("")
		ZO_Tooltip_AddDivider(ItemTooltip)
		RGE.AddTTLine(RGE.COLORS.BLUE..RGE.LONGNAME:upper(), "ZoFontWinH3")
		local typeStr = self:GetTypeStr()
		if (displayEquipped) then
			RGE.AddTTLine("")
			self:AddTooltipLinesFor("equipped "..typeStr, BAG_WORN)
		end
		if (displayInventory) then
			RGE.AddTTLine("")
			self:AddTooltipLinesFor(typeStr.." in inventory", BAG_BACKPACK)
		end
	end
end

function RGE_Glyph:CanEnchant(enchantable)
	return CanItemTakeEnchantment(enchantable.bag, enchantable.slot, self.bag, self.slot)
end

function RGE_Glyph:GetTypeStr()
	if self.type == ITEMTYPE_GLYPH_ARMOR then
		return "armor"
	elseif self.type == ITEMTYPE_GLYPH_JEWELRY then
		return "jewelry"
	elseif self.type == ITEMTYPE_GLYPH_WEAPON then
		return "weapons"
	end
end

function RGE_Glyph:AddTooltipLinesFor(typeStr, bag)
	RGE.AddTTLine(typeStr:upper())
	local count = 0
	local bagSlots = GetBagSize(bag)
	for i = 0, bagSlots do
		local enchantee = RGE_Enchantable:New(bag, i)
		if (enchantee:IsValid() and self:CanEnchant(enchantee)) then
			count = count + 1
			RGE.AddTTLine(enchantee:ToTooltipStr())
		end
	end
	if count == 0 then
		RGE.AddTTLine("No "..typeStr.." are enchantable")
	end
end