-- ZO_Object source: http://esodata.uesp.net/current/src/libraries/utility/baseobject.lua.html
-- Inheritance LUA Doc: http://www.lua.org/pil/16.2.html 
Item = {}

function Item:New(bagId, slotIndex)
	obj = {}
	setmetatable(obj, self)
	self.__index = self
	obj:Init(bagId, slotIndex)
	return obj
end

function Item:Init(bagId, slotIndex)
	-- RGE.Write("inside init item "..tostring(self))
	self.bag = bagId
	self.slot = slotIndex
	self.link = GetItemLink(self.bag, self.slot)
	self.type = GetItemLinkItemType(self.link)
	self.name = GetItemLinkName(self.link)
end

function Item:IsValid()
	return (self.bag > -1 and
			self.slot > -1 and
			self.type > -1 and
			not RGE.IsEmpty(self.link) and
			not RGE.IsEmpty(self.name))
end

function Item:FormatLink(itemLinkStyle) -- adapted from LootDrop:FormatLink(link)
	local linkLength = self.link:len()
	local nameLength = self.name:len()
	local formattedName = self.formattedName or self:FormatName()
	if (itemLinkStyle == LINK_STYLE_BRACKETS) then
		formattedName = "["..formattedName.."]"
	end
	local finalLink = ""
	for i = 1, linkLength-2-nameLength do
		finalLink = finalLink..self.link:sub(i, i)
	end
	finalLink = finalLink..formattedName.."|h"
	return finalLink
end

function Item:FormatName() -- adapted from LootDrop:FormatItemLink(str)
	local length = self.name:len()
	local final = ""
	for i = 1, length do
		local char = self.name:sub(i, i)
		if (i == 1 or self.name:sub(i-1, i-1) == " ") then
			final = final..char:upper()
		elseif (char == "^") then
			break
		else
			final = final..char
		end
	end
	self.formattedName = final
	return final
end