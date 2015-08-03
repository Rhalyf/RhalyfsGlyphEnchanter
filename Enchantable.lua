RGE_Enchantable = RGE_Item:New()

function RGE_Enchantable:Init(bagId, slotIndex)
	self.bag = bagId
	self.slot = slotIndex
	self.link = GetItemLink(self.bag, self.slot)
	self.type = GetItemLinkItemType(self.link)
	self.name = GetItemLinkName(self.link)
	self.hasCharges, self.enchantment, self.enchantDescription = GetItemLinkEnchantInfo(self.link)
end

function RGE_Enchantable:IsValid()
	return  (self.bag > -1 and
			self.slot > -1 and
			self.type > -1 and
			not RGE.IsEmpty(self.link) and
			not RGE.IsEmpty(self.name) and
			IsItemEnchantable(self.bag, self.slot))
end

function RGE_Enchantable:IsEnchantableBy(glyph)
	return glyph:CanEnchant(self)
end

function RGE_Enchantable:IsEnchanted()
	return not RGE.IsEmpty(self.enchantment) and self.hasCharges
end

function RGE_Enchantable:HandleTooltip()
	RGE.AddTTLine("")
	ZO_Tooltip_AddDivider(ItemTooltip)
	RGE.AddTTLine(RGE.COLORS.BLUE..RGE.LONGNAME:upper(), "ZoFontWinH3")
	RGE.AddTTLine("")
	self:HandleTooltipFor("glyphs in inventory", BAG_BACKPACK)
end

function RGE_Enchantable:HandleTooltipFor(typeStr, bag)
	RGE.AddTTLine(typeStr:upper())
	local count = 0
	local bagSlots = GetBagSize(bag)
	for i = 0, bagSlots+1 do
		local glyph = RGE_Glyph:New(bag, i)
		if (glyph:IsValid() and self:IsEnchantableBy(glyph)) then
			count = count + 1
			glyph:ToTooltipLines()
		end
	end
	if count == 0 then
		RGE.AddTTLine("No "..typeStr.." can enchant this item")
	end
end

function RGE_Enchantable:ToTooltipLines()
	local formattedLink = self.formattedLink or self:FormatLink()
	RGE.AddTTLine(formattedLink)
	if (RGE.getSavedSetting("display_enchantment") and self:IsEnchanted()) then
		RGE.AddTTLine(self.enchantment, "ZoFontGameSmall")
	end
	if (RGE.getSavedSetting("display_description") and self:IsEnchanted()) then
		RGE.AddTTLine("("..self.enchantDescription:sub(0, -2)..")", "ZoFontGameSmall")
	end
end