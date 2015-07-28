local lastControl = nil

function RGE.AttachInventoryPreHooks()
	-- have to delay OnShow call to handle race condition
	ZO_PreHookHandler(ItemTooltip, "OnShow", function() zo_callLater(RGE.AddGlyphEnchantInfo, 500) end)
	ZO_PreHookHandler(ItemTooltip, "OnUpdate", function() RGE.AddGlyphEnchantInfo() end)
	ZO_PreHookHandler(ItemTooltip, "OnHide", function() lastControl = nil end)
end

function RGE.AddGlyphEnchantInfo()
	local moc = moc() -- mouse over control
	if (not moc or
		moc == lastControl or -- don't add glyph info if the control hasn't changed
		not moc.dataEntry or
		not moc.dataEntry.data or
		not moc.dataEntry.data.bagId or
		not moc.dataEntry.data.slotIndex) 
		then return end

	lastControl = moc
	local bagId = moc.dataEntry.data.bagId
	local slotIndex = moc.dataEntry.data.slotIndex
	-- try glyph
	local item = Glyph:New(bagId, slotIndex)
	if (item:IsValid()) then 
		item:AddTooltipLines()
	else
		-- try enchantable
		-- item = Enchantable:New(bagId, slotIndex)
		-- if (item:IsValid()) then
		-- 	item:AddTooltipLines()
		-- end
	end
end