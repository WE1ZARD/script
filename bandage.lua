--[[
**********************************************************************

    Smart Bandage
    1. bandage mouseover Ally without change target
    2. bandage Ally
    3. bandage self

    How To Use: type in macro with "/run bandage()" or "/bandage"
**********************************************************************
]]

local L={}
do
    if (GetLocale()=="zhCN") then
        L["Bandage"]="绷带"
    else
        L["Bandage"]="Bandage"
    end
end

SLASH_BANDAGE1 = "/bandage"
SlashCmdList["BANDAGE"] = 
function(arg)
    bandage()
end
bandage = function()
    for b=0,4 do 
        for s=1,GetContainerNumSlots(b,s)do 
            local n=GetContainerItemLink(b,s)
            if n and (strfind(n,L["Bandage"]) or strfind(n,"The Rag"))then 
                if UnitExists("mouseover") and not UnitCanAttack("player","mouseover")then
                    TargetUnit("mouseover")
                    UseContainerItem(b,s)
                    SpellTargetUnit("mouseover")
                    TargetLastTarget()
                elseif UnitExists("target") and not UnitCanAttack("player","target")then
                    UseContainerItem(b,s)
                    SpellTargetUnit("target")
                else  
                    UseContainerItem(b,s)
                    SpellTargetUnit("player")
                end                    
            end 
        end 
    end
end
