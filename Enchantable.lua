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