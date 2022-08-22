--[[
=====================================================
Snowfall
1. cast on key down
2. enable spam attack/shot/wand
=====================================================
]]
function ActionButtonDown(id)
    if ( BonusActionBarFrame:IsShown() ) then
        local button = getglobal("BonusActionButton"..id);
        if ( button:GetButtonState() == "NORMAL" ) then
            button:SetButtonState("PUSHED");
            if not (button.flashing == 1)  then
                UseAction(ActionButton_GetPagedID(button), 0)
            end
        end
        return;
    end
    
    local button = getglobal("ActionButton"..id);
    if ( button:GetButtonState() == "NORMAL" ) then
        if ( button:GetButtonState() == "NORMAL" ) then
            button:SetButtonState("PUSHED");
            if not (button.flashing == 1) then 
                UseAction(ActionButton_GetPagedID(button), 0)
            end
        end
    end
end


function ActionButtonUp(id, onSelf)
    if ( BonusActionBarFrame:IsShown() ) then
        local button = getglobal("BonusActionButton"..id);
        if ( button:GetButtonState() == "PUSHED" ) then
            button:SetButtonState("NORMAL");
            if ( MacroFrame_SaveMacro ) then
                MacroFrame_SaveMacro();
            end
            if ( IsCurrentAction(ActionButton_GetPagedID(button)) ) then
                 button:SetChecked(1);
            else
                button:SetChecked(0);
            end
        end
        return;
    end

    local button = getglobal("ActionButton"..id);
    if ( button:GetButtonState() == "PUSHED" ) then
        button:SetButtonState("NORMAL");
        if ( MacroFrame_SaveMacro ) then
            MacroFrame_SaveMacro();
        end
        if ( IsCurrentAction(ActionButton_GetPagedID(button)) ) then
            button:SetChecked(1);
        else
            button:SetChecked(0);
        end
    end
end

function MultiActionButtonDown(bar, id)
    local button = getglobal(bar.."Button"..id);
    if ( button:GetButtonState() == "NORMAL" ) then
        button:SetButtonState("PUSHED");
        if not (button.flashing == 1) then
            UseAction(ActionButton_GetPagedID(button), 0)
        end
    end
end

function MultiActionButtonUp(bar, id, onSelf)
    local button = getglobal(bar.."Button"..id);
    if ( button:GetButtonState() == "PUSHED" ) then
        button:SetButtonState("NORMAL");
        if ( MacroFrame_SaveMacro ) then
            MacroFrame_SaveMacro();
        end
        if ( IsCurrentAction(ActionButton_GetPagedID(button)) ) then
            button:SetChecked(1);
        else
            button:SetChecked(0);
        end
    end
end


function PetActionButtonDown(id)
    local button = getglobal("PetActionButton"..id);
    if ( button:GetButtonState() == "NORMAL" ) then
        button:SetButtonState("PUSHED");
        if not (button.flashing == 1) then
            CastPetAction(id);
        end
    end
end

function PetActionButtonUp(id)
    local button = getglobal("PetActionButton"..id);
    if ( button:GetButtonState() == "PUSHED" ) then
        button:SetButtonState("NORMAL");
    end
end
