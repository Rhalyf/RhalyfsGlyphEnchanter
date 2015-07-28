Glyph = Item:New()

function Glyph:IsValid()
	return (self.bag > -1 and
			self.slot > -1 and
			not RGE.IsEmpty(self.link) and
			not RGE.IsEmpty(self.name)) and
			(self.type == ITEMTYPE_GLYPH_ARMOR or
	   		 self.type == ITEMTYPE_GLYPH_JEWELRY or
	   		 self.type == ITEMTYPE_GLYPH_WEAPON)
end

function Glyph:AddTooltipLines()
	local displayEquipped = RGE.getSavedSetting("display_equipped")
	local displayInventory = RGE.getSavedSetting("display_inventory")
	
	if (displayEquipped or displayInventory) then
		ItemTooltip:AddLine("", "ZoFontWinH5", 1, 1, 1, BOTTOM)
		ZO_Tooltip_AddDivider(ItemTooltip)
		ItemTooltip:AddLine(RGE.COLORS.BLUE..RGE.LONGNAME:upper(), "ZoFontWinH4", 1, 1, 1, BOTTOM)
		ItemTooltip:AddLine(RGE.COLORS.BLUE.."*"..RGE.COLORS.WHITE.." = item has no enchantment or charges", "ZoFontGameMedium", 1, 1, 1, BOTTOM)
		local typeStr = self:GetTypeStr()
		if (displayEquipped) then
			ItemTooltip:AddLine("", "ZoFontWinH5", 1, 1, 1, BOTTOM)
			self:AddEquippedTooltipLines(typeStr)
		end
		if (displayInventory) then
			ItemTooltip:AddLine("", "ZoFontWinH5", 1, 1, 1, BOTTOM)
			self:AddInventoryTooltipLines(typeStr)
		end
	end
end

function Glyph:CanEnchant(enchantable)
	return CanItemTakeEnchantment(enchantable.bag, enchantable.slot, self.bag, self.slot)
end

function Glyph:GetTypeStr()
	if self.type == ITEMTYPE_GLYPH_ARMOR then
		return "armor"
	elseif self.type == ITEMTYPE_GLYPH_JEWELRY then
		return "jewelry"
	elseif self.type == ITEMTYPE_GLYPH_WEAPON then
		return "weapons"
	end
end

function Glyph:AddEquippedTooltipLines(typeStr)
	ItemTooltip:AddLine("ENCHANTABLE EQUIPPED "..typeStr:upper(), "ZoFontWinH5", 1, 1, 1, BOTTOM)
	local count = 0
	for i = 0, 21 do -- 22 possible slots in BAG_WORN
		local enchantee = Enchantable:New(BAG_WORN, i)
		if (enchantee:IsValid() and self:CanEnchant(enchantee)) then
			count = count + 1
			local line = enchantee:FormatLink()
			if (not enchantee:IsEnchanted()) then
				line = line..RGE.COLORS.BLUE.."*"
			end
			ItemTooltip:AddLine(line, "ZoFontGameMedium", 1, 1, 1, BOTTOM)
		end
	end
	if count == 0 then
		ItemTooltip:AddLine("No equipped "..typeStr.." are enchantable", "ZoFontGameMedium", 1, 1, 1, BOTTOM)
	end
end

function Glyph:AddInventoryTooltipLines(typeStr)
	ItemTooltip:AddLine("ENCHANTABLE "..typeStr:upper().." IN INVENTORY", "ZoFontWinH5", 1, 1, 1, BOTTOM)
	local count = 0
	local bagSlots = GetBagSize(BAG_BACKPACK)
	for i = 0, bagSlots do 
		local enchantee = Enchantable:New(BAG_BACKPACK, i)
		if (enchantee:IsValid() and self:CanEnchant(enchantee)) then
			count = count + 1
			local line = enchantee:FormatLink()
			if (not enchantee:IsEnchanted()) then
				line = line..RGE.COLORS.BLUE.."*"
			end
			ItemTooltip:AddLine(line, "ZoFontGameMedium", 1, 1, 1, BOTTOM)
		end
	end
	if count == 0 then
		ItemTooltip:AddLine("No "..typeStr.." in inventory are enchantable", "ZoFontGameMedium", 1, 1, 1, BOTTOM)
	end
end

