--[[
    ********************************************
        Snowfall
        1. cast on key down
        2. spam casting shot/attack
        mouseover
        1. allow to mouseover on unitframe
    ********************************************
]]

local mouseover

do
    local orig = GameTooltip.SetUnit
    function GameTooltip:SetUnit(unit)
        mouseover = unit
        return orig(self, unit)
    end
end

do
    local orig = GameTooltip.FadeOut
    function GameTooltip:FadeOut()
        mouseover = nil
        return orig(self)
    end
end

do
    local orig = GameTooltip.Hide
    function GameTooltip:Hide()
        mouseover = nil
        return orig(self)
    end
end

do
    local pass = function() end
    local orig = UseAction
    function UseAction(unit, clicked, onself)
        local mouseover = mouseover
        if mouseover and mouseover ~= 'target' then
            local _PlaySound = PlaySound
            local target = UnitName'target'
            PlaySound = pass
            ClearTarget()
            PlaySound = _PlaySound
            do
                local autoSelfCast = GetCVar'autoSelfCast'
                SetCVar('autoSelfCast', nil)
                orig(unit, clicked, onself)
                SetCVar('autoSelfCast', autoSelfCast)
            end
            SpellTargetUnit(mouseover)
            if target then
                PlaySound = pass
                TargetLastTarget()
                PlaySound = _PlaySound
            end
        else
            orig(unit, clicked, onself)
        end
    end
end

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
