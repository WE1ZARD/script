--[[ 
====================================== 
Send Coord
  - click on MinimapZoneText (solo /in patry /in raid)
====================================== 
]]
local function SendCoord()
    local _,class = UnitClass('player')
    local pX, pY = GetPlayerMapPosition("player")
    if GetNumPartyMembers() > 5 then
        SendChatMessage( format(GetZoneText()..' - (%.0f,%.0f)', pX*100, pY*100), "RAID" )
    elseif GetNumPartyMembers() > 0 then 
        SendChatMessage( format(GetZoneText()..' - (%.0f,%.0f)', pX*100, pY*100), "PARTY" )    
    else
        DEFAULT_CHAT_FRAME:AddMessage('|cffFFFF00'..format(GetZoneText()..' - (%.0f,%.0f)', pX*100, pY*100)..'|r')
    end
end

MinimapZoneTextButton:SetScript("OnClick",SendCoord)
