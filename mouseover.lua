-- mouseover function
----------------------------------------------
function mouseover(msg)
    local func = loadstring(msg or "")
    local oldt = true
    local unit = "mouseover" or GetUnit()
    if not UnitExists(unit) then
        local frame = GetMouseFocus()
        if frame.label and frame.id then
          unit = frame.label .. frame.id
        elseif UnitExists("target") then
          unit = "target"
        elseif GetCVar("autoSelfCast") == "1" then
          unit = "player"
        else
          return
        end
    end
    if UnitIsUnit("target", unit) then oldt = nil end
        TargetUnit(unit)
    if func then
        func()
    else
        CastSpellByName(msg)
    end
    TargetLastTarget()
end
function SlashCmdList.MOUSEOVER(msg)
    mouseover(msg)
end
_G.SLASH_MOUSEOVER1 = "/mouseover"
