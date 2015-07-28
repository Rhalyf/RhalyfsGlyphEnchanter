-- Inheritance LUA Doc: http://www.lua.org/pil/16.2.html 
RGE_Item = {}

function RGE_Item:New(bagId, slotIndex)
	obj = {}
	setmetatable(obj, self)
	self.__index = self
	obj:Init(bagId, slotIndex)
	return obj
end

function RGE_Item:Init(bagId, slotIndex)
	self.bag = bagId
	self.slot = slotIndex
	self.link = GetItemLink(self.bag, self.slot)
	self.type = GetItemLinkItemType(self.link)
	self.name = GetItemLinkName(self.link)
end

function RGE_Item:IsValid()
	return (self.bag > -1 and
			self.slot > -1 and
			self.type > -1 and
			not RGE.IsEmpty(self.link) and
			not RGE.IsEmpty(self.name))
end

function RGE_Item:FormatLink()
	if (not self.formattedLink) then
		local linkLength = self.linkLen or self.link:len()
		local nameLength = self.nameLen or self.name:len()
		local formattedName = self.formattedName or self:FormatName()
		local finalLink = ""
		for i = 1, linkLength-2-nameLength do
			finalLink = finalLink..self.link:sub(i, i)
		end
		finalLink = finalLink..formattedName.."|h"
		self.formattedLink = finalLink
	end
	return self.formattedLink
end

function RGE_Item:FormatName()
	if (not self.formattedName) then
		local length = self.nameLen or self.name:len()
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
		self.formattedNameLen = final:len()
	end
	return self.formattedName
end

function RGE_Item:Write() -- for debugging
	local str = ""
	for k, v in pairs(t) do
		str = str.."["..k.."]="..tostring(v)..",\n"
	end
	RGE.Write(str..", IsValid()="..tostring(self:IsValid()))
end