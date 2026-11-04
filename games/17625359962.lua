-- Rivals
-- ============================================================================
-- MASTER COMBINED SCRIPT TEMPLATE (LinoriaLib Framework)
-- ============================================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Load your UI Library (e.g., LinoriaLib)
-- local repo = 'https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/'
-- local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()

local Window = Library:CreateWindow({
    Title = 'Baza Hub - Extended Edition',
    Center = true,
    AutoShow = true,
    TabPadding = 8,
})

local Tabs = {
    Combat = Window:AddTab('Combat'),
    Visuals = Window:AddTab('Visuals'),
    Misc = Window:AddTab('Misc'),
}

-- ============================================================================
-- MODULE 1: ADVANCED HIT EFFECTS & DAMAGE BILLBOARDS
-- ============================================================================
local HitEffectsModule = {}
do
    local damageBillboardInfoCache = setmetatable({}, { __mode = "k" })

    local function getDamageBillboardInfo(obj)
        local cached = damageBillboardInfoCache[obj]
        if cached ~= nil then return cached end
        if not obj:IsA("BillboardGui") or obj.Name == "FortniteDamageNumber" then return end
        local lbl = obj:FindFirstChildWhichIsA("TextLabel", true)
        if not lbl then return end
        local dmg = tonumber(lbl.Text)
        if not (dmg and dmg > 0) then return end
        local adornee = obj.Adornee or (obj.Parent and obj.Parent:IsA("BasePart") and obj.Parent)
        if not adornee then return end
        
        local info = { lbl = lbl, dmg = dmg, adornee = adornee }
        damageBillboardInfoCache[obj] = info
        return info
    end

    workspace.DescendantAdded:Connect(function(obj)
        if not obj:IsA("BillboardGui") then return end
        local info = getDamageBillboardInfo(obj)
        if not info then return end
        task.defer(function()
            if not obj or not obj.Parent then return end
            -- Customize or hide default bill-board style here
            obj.Enabled = false 
        end)
    end)
end

-- ============================================================================
-- MODULE 2: VIEWMODEL CHAMS & CUSTOM OUTLINES
-- ============================================================================
local ViewmodelChamsModule = {}
do
    local function applyChams(character)
        if not character then return end
        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("MeshPart") or part:IsA("Part") then
                -- Apply custom material or color overrides
                part.Material = Enum.Material.Neon
            end
        end
    end

    LocalPlayer.CharacterAdded:Connect(applyChams)
    if LocalPlayer.Character then
        applyChams(LocalPlayer.Character)
    end
end

-- ============================================================================
-- MODULE 3: UI CONTROLS & SETTINGS INTEGRATION
-- ============================================================================
local CombatGroup = Tabs.Combat:AddLeftGroupbox('Ragebot Settings')
CombatGroup:AddToggle('RageEnable', {
    Text = 'Enable Ragebot / C-Sync',
    Default = false,
    Callback = function(value)
        print('Ragebot toggled:', value)
    end
})

local VisualsGroup = Tabs.Visuals:AddLeftGroupbox('Hit Effects & Chams')
VisualsGroup:AddToggle('CustomHits', {
    Text = 'Enable Custom Hit Popups',
    Default = true,
    Callback = function(value)
        print('Custom hit popups:', value)
    end
})

VisualsGroup:AddToggle('ViewmodelChams', {
    Text = 'Enable Viewmodel Glow',
    Default = false,
    Callback = function(value)
        print('Viewmodel Chams:', value)
    end
})

Library:Notify('Baza Hub Successfully Loaded with Integrated Modules!')
