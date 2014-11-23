local AS = unpack(AddOnSkins)

local name = 'Blizzard_Bags'
function AS:Blizzard_Bags()
	if Tukui and Tukui[2]["Bags"]["Enable"] then return end

	for i = 1, 12 do -- There is 13 Total..
		local Bag = _G["ContainerFrame"..i]
		AS:SkinBackdropFrame(Bag, nil, true)
		for j = 1, 36 do
			local ItemButton = _G["ContainerFrame"..i.."Item"..j]
--			AS:SkinTexture(_G["ContainerFrame"..i.."Item"..j..'IconQuestTexture'])
			AS:SetTemplate(ItemButton, AS:CheckOption('SkinTemplate'))
			AS:SkinTexture(ItemButton.icon)
			ItemButton:SetNormalTexture('')
			ItemButton:SetPushedTexture('')
			ItemButton.icon:SetInside()

			ItemButton.IconBorder:SetTexture('')
			ItemButton.NewItemTexture:SetAtlas(nil)
			ItemButton.NewItemTexture.SetAtlas = AS.Noop

			-- This shit is hax.
			AS:CreateBackdrop(ItemButton)
			ItemButton.Backdrop:Hide()
			hooksecurefunc(ItemButton.NewItemTexture, 'Show', function()
				ItemButton.Backdrop:Show()
			end)
			hooksecurefunc(ItemButton.NewItemTexture, 'Hide', function()
				ItemButton.Backdrop:Hide()
			end)
			ItemButton.Backdrop:SetAllPoints()
			ItemButton.Backdrop:SetFrameStrata(ItemButton:GetFrameStrata())
			ItemButton.Backdrop:SetFrameLevel(ItemButton:GetFrameLevel() + 4)
			ItemButton.Backdrop:SetBackdropColor(0, 0, 0, 0)
			ItemButton.Backdrop:SetScript('OnShow', function(self)
				ItemButton:SetBackdropBorderColor(unpack(AS.BorderColor))
				self:SetBackdropBorderColor(ItemButton.IconBorder:GetVertexColor())
			end)
			ItemButton.Backdrop:SetScript('OnUpdate', function(self)
				self:SetAlpha(ItemButton.NewItemTexture:GetAlpha())
			end)
			ItemButton.Backdrop:SetScript('OnHide', function()
				if select(4, GetContainerItemInfo(ItemButton:GetParent():GetID(), ItemButton:GetID())) > LE_ITEM_QUALITY_COMMON then
					ItemButton:SetBackdropBorderColor(ItemButton.IconBorder:GetVertexColor())
				else
					ItemButton:SetBackdropBorderColor(unpack(AS.BorderColor))
				end
			end)
			-- End of hax.

			ItemButton.searchOverlay:SetAllPoints(ItemButton.icon)
			ItemButton.searchOverlay:SetTexture(0, 0, 0, .8)

			ItemButton:SetNormalTexture('')
			AS:StyleButton(ItemButton)
			hooksecurefunc(ItemButton.IconBorder, 'SetVertexColor', function(self, r, g, b, a)
				if select(4, GetContainerItemInfo(ItemButton:GetParent():GetID(), ItemButton:GetID())) > LE_ITEM_QUALITY_COMMON then
					ItemButton:SetBackdropBorderColor(r, g, b)
				else
					ItemButton:SetBackdropBorderColor(unpack(AS.BorderColor))
				end
			end)
			hooksecurefunc(ItemButton.IconBorder, 'Hide', function(self)
				ItemButton:SetBackdropBorderColor(unpack(AS.BorderColor))
			end)
		end

		Bag.Backdrop:Point("TOPLEFT", 4, -2)
		Bag.Backdrop:Point("BOTTOMRIGHT", 1, 1)
		_G["ContainerFrame"..i.."BackgroundTop"]:Kill()
		_G["ContainerFrame"..i.."BackgroundMiddle1"]:Kill()
		_G["ContainerFrame"..i.."BackgroundMiddle2"]:Kill()
		_G["ContainerFrame"..i.."BackgroundBottom"]:Kill()
		AS:SkinCloseButton(_G["ContainerFrame"..i.."CloseButton"])
		AS:SkinButton(Bag.PortraitButton)
		Bag.PortraitButton.Highlight:Kill()
	end

	local function UpdateBagIcon()
		for i = 1, 12 do
			local Portrait = _G["ContainerFrame"..i.."PortraitButton"]
			if i == 1 then
				Portrait:SetNormalTexture("Interface\\ICONS\\INV_Misc_Bag_36")
			elseif i <= 5 and i >= 2 then
				Portrait:SetNormalTexture(_G["CharacterBag"..(i - 2).."SlotIconTexture"]:GetTexture())
			elseif i <= 12 and i >= 6 then
				Portrait:SetNormalTexture(BankSlotsFrame["Bag"..(i-5)].icon:GetTexture())
			end
			if Portrait:GetNormalTexture() then
				AS:SkinTexture(Portrait:GetNormalTexture())
				Portrait:GetNormalTexture():SetInside()
			end
		end
	end

	hooksecurefunc('BankFrameItemButton_Update', UpdateBagIcon)
	hooksecurefunc('ContainerFrame_Update', UpdateBagIcon)

	AS:SkinEditBox(BagItemSearchBox)
	AS:StripTextures(BackpackTokenFrame)

	AS:SkinButton(BagItemAutoSortButton)
	BagItemAutoSortButton:SetNormalTexture("Interface\\ICONS\\INV_Pet_Broom")
	BagItemAutoSortButton:SetPushedTexture("Interface\\ICONS\\INV_Pet_Broom")
	AS:SkinTexture(BagItemAutoSortButton:GetNormalTexture())
	BagItemAutoSortButton:GetNormalTexture():SetInside()
	AS:SkinTexture(BagItemAutoSortButton:GetPushedTexture())
	BagItemAutoSortButton:GetPushedTexture():SetInside()
	BagItemAutoSortButton:Size(22)

	BagItemAutoSortButton:SetScript('OnShow', function(self)
		local a, b, c, d, e = self:GetPoint()
		self:SetPoint(a, b, c, d - 3, e - 1)
		self.SetPoint = AS.Noop
		self:SetScript('OnShow', nil)
	end)

	for i = 1, 3 do
		local Token = _G["BackpackTokenFrameToken"..i]
		AS:SkinTexture(Token.icon)
		AS:CreateBackdrop(Token, 'Default')
		Token.Backdrop:SetOutside(Token.icon)
		Token.icon:Point("LEFT", Token.count, "RIGHT", 3, 0)
	end

	AS:SkinFrame(BankFrame, nil, nil, true)
	AS:SkinCloseButton(BankFrameCloseButton)
	AS:StripTextures(BankFrameMoneyFrameBorder)
	AS:StripTextures(BankFrameMoneyFrameInset)
	AS:StripTextures(BankSlotsFrame)

	AS:SkinButton(BankFramePurchaseButton)
	BankFramePurchaseButton:Height(22)
	
	BankItemSearchBox:Size(159, 16)
	AS:SkinEditBox(BankItemSearchBox)

	AS:SkinButton(BankItemAutoSortButton)
	BankItemAutoSortButton:SetNormalTexture("Interface\\ICONS\\INV_Pet_Broom")
	BankItemAutoSortButton:SetPushedTexture("Interface\\ICONS\\INV_Pet_Broom")
	AS:SkinTexture(BankItemAutoSortButton:GetNormalTexture())
	BankItemAutoSortButton:GetNormalTexture():SetInside()
	AS:SkinTexture(BankItemAutoSortButton:GetPushedTexture())
	BankItemAutoSortButton:GetPushedTexture():SetInside()
	BankItemAutoSortButton:Size(20)
	BankItemAutoSortButton:SetPoint("LEFT", BankItemSearchBox, "RIGHT", 4, 0)

	-- Bank Bags
	for i = 1, 7 do
		local BankBag = BankSlotsFrame['Bag'..i]
		AS:SkinFrame(BankBag)
		BankBag.HighlightFrame.HighlightTexture:SetTexture(1, 1, 1, .2)
		AS:StyleButton(BankBag)
		AS:SkinTexture(BankBag.icon)
		BankBag.icon:SetInside()
		hooksecurefunc(BankBag.IconBorder, 'SetVertexColor', function(self, r, g, b, a)
			BankBag:SetBackdropBorderColor(r, g, b)
		end)
		hooksecurefunc(BankBag.IconBorder, 'Hide', function(self)
			BankBag:SetBackdropBorderColor(unpack(AS.BorderColor))
		end)
	end

	-- Bank Slots
	for i = 1, 28 do
		local ItemButton = _G["BankFrameItem"..i]
		AS:SkinFrame(ItemButton)
		AS:SkinTexture(ItemButton.icon)
		ItemButton.icon:SetInside()

		ItemButton.searchOverlay:SetAllPoints(ItemButton.icon)
		ItemButton.searchOverlay:SetTexture(0, 0, 0, .8)

		ItemButton:SetNormalTexture(nil)
		AS:StyleButton(ItemButton)
		hooksecurefunc(ItemButton.IconBorder, 'SetVertexColor', function(self, r, g, b, a)
			ItemButton:SetBackdropBorderColor(r, g, b)
		end)
		hooksecurefunc(ItemButton.IconBorder, 'Hide', function(self)
			ItemButton:SetBackdropBorderColor(unpack(AS.BorderColor))
		end)
	end

	AS:SkinTab(BankFrameTab1)
	AS:SkinTab(BankFrameTab2)
end

AS:RegisterSkin(name, AS.Blizzard_Bags)