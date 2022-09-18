--[[
    ***************************************************************
    Smart ChatFrameTab (***DEFAULT CHATFRAME ONLY***)
    
    1. Ctrl+Click >> Open /Guild
    2. Shift+Click >> Open /Say
    3. Alt+Click >> Open /Battleground /Raid /Party /Say (solo)
    
    ****************************************************************
]] 
function FCF_Tab_OnClick(button)
    local chatFrame = getglobal("ChatFrame"..this:GetID());
    -- If Rightclick bring up the options menu

    if IsAltKeyDown() then
        local inInstance, instanceType = IsInInstance()
        if instanceType == "pvp" then
            ChatFrame_OpenChat("/bg ", chatFrame)
        elseif GetNumPartyMembers() > 5 then
            ChatFrame_OpenChat("/raid ", chatFrame)
        elseif GetNumPartyMembers() > 0 then 
            ChatFrame_OpenChat("/p ", chatFrame)
        else
            ChatFrame_OpenChat("/g ", chatFrame)
        end
    elseif IsShiftKeyDown() then
        ChatFrame_OpenChat("/s ", chatFrame)
    elseif IsControlKeyDown() then
        ChatFrame_OpenChat("/g ", chatFrame)
    else
        if ( button == "RightButton" ) then
            chatFrame:StopMovingOrSizing();
            ToggleDropDownMenu(1, nil, getglobal(this:GetName().."DropDown"), this:GetName(), 0, 0);
            return;
        end
        -- Close all dropdowns
        CloseDropDownMenus();
        -- If frame is docked assume that a click is to select a chat window, not drag it
        SELECTED_CHAT_FRAME = chatFrame;
        if ( chatFrame.isDocked ) then
            FCF_SelectDockFrame(chatFrame);
            return;
        end
        -- If frame is not docked then allow the frame to be dragged or dropped
        if ( this:GetButtonState() == "PUSHED" ) then
            chatFrame:StopMovingOrSizing();
            local activeDockRegion = FCF_GetActiveDockRegion();
            if ( activeDockRegion ) then
                FCF_DockFrame(chatFrame, activeDockRegion);
            else
                -- Move chat frame if out of bounds
                FCF_ValidateChatFramePosition(chatFrame);
            end
            MOVING_CHATFRAME = nil;
        else
            -- If locked don't allow any movement
            if ( not chatFrame.isDocked and chatFrame.isLocked ) then
                return;
            else
                chatFrame:StartMoving();
                MOVING_CHATFRAME = chatFrame;
            end
        end
    end
end
