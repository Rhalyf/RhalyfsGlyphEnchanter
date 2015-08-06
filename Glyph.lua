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

function RGE_Glyph:HandleTooltip() -- Add Tooltip lines for Glyph tooltip
	RGE.AddTTLine("")
	RGE.AddTTLine(RGE.COLORS.BLUE..RGE.LONGNAME:upper(), "ZoFontWinH2")
	ZO_Tooltip_AddDivider(PopupTooltip)
	if (RGE.getSavedSetting("display_name")) then
		local formattedLink = self.formattedLink or self:FormatLink()
		RGE.AddTTLine(formattedLink, "ZoFontWinH3")
	end
	RGE.AddTTLine("")
	local typeStr = self:GetTypeStr()
	if (RGE.getSavedSetting("display_equipped")) then
		self:HandleTooltipFor("equipped "..typeStr, BAG_WORN)
		RGE.AddTTLine("")
	end
	if (RGE.getSavedSetting("display_inventory")) then
		RGE.AddTTLine("")
		self:HandleTooltipFor(typeStr.." in inventory", BAG_BACKPACK)
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

function RGE_Glyph:HandleTooltipFor(typeStr, bag)
	RGE.AddTTLine(typeStr:upper(), "ZoFontWinH4")
	local count = 0
	local bagSlots = GetBagSize(bag)
	for i = 0, bagSlots+1 do
		local enchantee = RGE_Enchantable:New(bag, i)
		if (enchantee:IsValid() and self:CanEnchant(enchantee)) then
			count = count + 1
			enchantee:ToTooltipLines()
		end
	end
	if count == 0 then
		RGE.AddTTLine("No "..typeStr.." are enchantable")
	end
end

function RGE_Glyph:ToTooltipLines(count)
	local line = self.formattedLink or self:FormatLink()
	if (count and count > 1) then
		line = line.." (x"..count..")"
	end
	RGE.AddTTLine(line)
	if (RGE.getSavedSetting("display_description")) then
		RGE.AddTTLine("("..self.enchantDescription:sub(0, -2)..")", "ZoFontGameSmall")
	end
end