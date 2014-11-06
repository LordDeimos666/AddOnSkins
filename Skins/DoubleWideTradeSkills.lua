local AS = unpack(AddOnSkins)

if not AS:CheckAddOn('DoubleWideTradeSkills') then return end

function AS:DoubleWideTradeSkills(event, addon)
	if addon ~= 'DoubleWideTradeSkills' then return end
	AS:SkinFrame(TradeSkillFrame)
	AS:SkinStatusBar(TradeSkillRankFrame)
	TradeSkillListScrollFrame:StripTextures()
end

AS:RegisterSkin('DoubleWideTradeSkills', AS.DoubleWideTradeSkills, 'ADDON_LOADED')