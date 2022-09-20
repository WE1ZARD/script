--[[
    ******************************************
    Dismount
    1. use '/dismount' or /run dismount()

    ******************************************
]]

local tip = CreateFrame('GAMETOOLTIP', 'dismount', nil, 'GameTooltipTemplate')
tip:SetOwner(UIParent, 'ANCHOR_NONE')

function dismount()
    local counter = 0
    local tooltipfind = "Increases speed by (.+)%%"
    while GetPlayerBuff(counter) >= 0 do
        local index, untilCancelled = GetPlayerBuff(counter)
        tip:ClearLines()
        tip:SetPlayerBuff(index)
        local desc = getglobal(tip:GetName().."TextLeft2"):GetText();
        if desc then
            _, _, speed = string.find(desc, tooltipfind) 
            if speed then
                CancelPlayerBuff(counter)
                return
            end 
        end
        counter = counter + 1
    end
end

SLASH_DISMOUNT1 = "/dismount"
SlashCmdList["DISMOUNT"] = 
function(arg)
    dismount()
end
