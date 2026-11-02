--[[

  $$$$$$$\                            $$\                           $$\    $$\                              
  $$  __$$\                           $$ |                          $$ |   $$ |                             
  $$ |  $$ | $$$$$$\  $$$$$$$\   $$$$$$$ | $$$$$$\   $$$$$$\        $$ |   $$ |$$$$$$\   $$$$$$\   $$$$$$\  
  $$$$$$$  |$$  __$$\ $$  __$$\ $$  __$$ |$$  __$$\ $$  __$$\       \$$\  $$  |\____$$\ $$  __$$\ $$  __$$\ 
  $$  __$$< $$$$$$$$ |$$ |  $$ |$$ /  $$ |$$$$$$$$ |$$ |  \__|       \$$\$$  / $$$$$$$ |$$ /  $$ |$$$$$$$$ |
  $$ |  $$ |$$   ____|$$ |  $$ |$$ |  $$ |$$   ____|$$ |              \$$$  / $$  __$$ |$$ |  $$ |$$   ____|
  $$ |  $$ |\$$$$$$$\ $$ |  $$ |\$$$$$$$ |\$$$$$$$\ $$ |               \$  /  \$$$$$$$ |$$$$$$$  |\$$$$$$$\ 
  \__|  \__| \_______|\__|  \__| \_______| \_______|\__|                \_/    \_______|$$  ____/  \_______|
                                                                                      $$ |                
                                                                                      $$ |                
                                                                                      \__|   
   A very sexy and overpowered vape mod created at Render Intents  
   CustomModules/155615604.lua (Prison life) - Maxlasertech      
   https://renderintents.lol                                                                                                                                                                                                                                                                     
]]

type vapemain = {
    ObjectsThatCanBeSaved: table,
    objects: table
};

type bool = boolean
   
type vapeminimodule = {
	Enabled: boolean,
	Object: Instance,
	ToggleButton: (boolean | nil, boolean | nil) -> ()
};

type vapeslider = {
	Value: number,
	Object: Instance,
	SetValue: (number) -> ()
};

type vapecolorslider = {
	Hue: number,
	Sat: number,
	Value: number,
	Object: Instance,
	SetRainbow: (boolean | nil) -> (),
	SetValue: (number, number, number) -> ()
};

type vapedropdown = {
	Value: string,
	Object: Instance,
	SetValue: (table) -> ()
};

type vapetextlist = {
	ObjectList: table,
	Object: Instance,
	RefreshValues: (table) -> table
};

type vapetextbox = {
	Value: string,
	Object: Instance,
	SetValue: (string) -> ()
};

type vapecustomwindow = {
	GetCustomChildren: (table) -> Frame,
	SetVisible: (boolean | nil) -> ()
};

type securetable = {
	clear: (securetable, (any, any) -> ()) -> (),
	len: (securetable) -> number,
	shutdown: (securetable) -> (),
	getplainarray: (securetable) -> table
};

type vapemodule = {
    Connections: table,
    Enabled: boolean,
    Object: Instance,
    ToggleButton: (boolean | nil, boolean | nil) -> (),
	CreateTextList: (table) -> vapetextlist,
	CreateColorSlider: (table) -> vapeslider,
	CreateToggle: (table) -> vapeminimodule,
	CreateDropdown: (table) -> vapedropdown,
	CreateSlider: (table) -> vapeslider,
	CreateTextBox: (table) -> vapetextbox,
	GetCustomChildren: (table) -> vapecustomwindow
};

type vapewindow = {
	CreateOptionsButton: (table) -> vapemodule,
	SetVisible: (boolean | nil) -> ()
};

type rendertarget = {
    Player: Player | nil,
    Humanoid: Humanoid | nil,
    RootPart: BasePart | nil,
    NPC: boolean | nil
};

local gui: vapemain = shared.rendervape;
local render: table = render or warn('❌ Failed to fetch the render main table.') or {};

for i: (any), v: (...any) -> (...any) in render.utils do
    getfenv()[i] = v;
end;

local vape: vapemain = gui;
local GuiLibrary: vapemain = gui;
local players: Players = getservice('Players');
local textservice: TextService = getservice('TextService');
local lighting: Lighting = getservice('Lighting');
local textchat: TextChatService = getservice('TextChatService');
local inputservice: UserInputService = getservice('UserInputService');
local runservice: RunService = getservice('RunService');
local teleport: TeleportService = getservice('TeleportService');
local tween: TweenService = getservice('TweenService');
local collection: CollectionService = getservice('CollectionService');
local httpservice: HttpService = getservice('HttpService');
local replicatedstorage: ReplicatedStorage = getservice('ReplicatedStorage');
local fakecam: Camera = Instance.new('Camera');
local camera: Camera? = workspace.CurrentCamera;
local lplr: Player = players.LocalPlayer;
local vapeConnections: table = {};
local vapeCachedAssets: table = {};
local vapeEvents: table = setmetatable({}, {
	__index = function(self, index)
		self[index] = Instance.new('BindableEvent')
		return self[index]
	end
});
local vapetarget: table = shared.VapeTargetInfo;
local vapeInjected: boolean = true;

local store: table = setmetatable({}, {})

local combat: vapewindow = vape.ObjectsThatCanBeSaved.CombatWindow;
local blatant: vapewindow = vape.ObjectsThatCanBeSaved.BlatantWindow;
local visual: vapewindow = vape.ObjectsThatCanBeSaved.RenderWindow;
local exploit: vapewindow = vape.ObjectsThatCanBeSaved.ExploitWindow;
local utility: vapewindow = vape.ObjectsThatCanBeSaved.UtilityWindow;
local world: vapewindow = vape.ObjectsThatCanBeSaved.WorldWindow;
local hudwindow: vapewindow = vape.ObjectsThatCanBeSaved.TargetHUDWindow;
local minigames: vapewindow = vape.objects.MinigamesWindow;
local inventory: vapewindow = vape.objects.InventoryWindow;

task.spawn(function()
    for i: number, v: table in {'SilentAim', 'Reach', 'TriggerBot', 'SafeWalk', 'AntiVoid'} do
        vape.RemoveObject(`{v}OptionsButton`)
    end;
    vape.RemoveObject('MinigamesWindow');
end);

store = setmetatable({
    damagetab = {
        M9 = 10,
        ['Remington 870'] = 15,
        ['AK-47'] = 30,
        ['M431'] = 35
    }
}, {
    __index = function(self: table, index: string): (table, string) -> (table?)
        if index == 'getitems' then
            return function(equip_check: boolean): (boolean) -> {Tool}
                local items: table = {};
                if not equip_check then
                    for i: number, v: Tool? in lplr.Backpack:GetChildren() do
                        table.insert(items, v);
                    end;
                end;
                if isAlive() then
                    for i: number, v: Tool?  in lplr.Character:GetChildren() do
                        if v.ClassName == 'Tool' then
                            table.insert(items, v);
                        end;
                    end;
                end;
                return items;
            end;
        end;
        if index == 'getweapons' then
            return function(): () -> {Tool}
                local weapons: table = {}
                for i: number, v: Tool in store.getitems() do
                    if v:FindFirstChild('GunStates') then
                        table.insert(weapons, v);
                    end;
                end;
                return weapons;
            end;
        end;
        if index == 'getdamage' then
            return function(name: string): (string) -> (number)
                return store.damagetab[name] or 0;
            end;
        end;
        if index == 'getgun' then
            return function(): (Tool) | {Tool}
                local weapon: Tool = nil;
                local damage: number = 0;
                for i: number, v: {Tool} in store.getitems(true) do
                    local weapondamage: number = store.getdamage(v.Name);
                    if v:FindFirstChild('GunStates') and weapondamage > damage then
                        damage = weapondamage;
                        weapon = v;
                    end;
                end;
                return weapon;
            end;
        end;
        return function() end;
    end
});

local playAnimation = function(id: number): (number) -> ()
  	if isAlive() then 
  	    local animation = Instance.new('Animation');
    	animation.AnimationId = `rbxassetid://{id}`;
    	local animation2 = lplr.Character.Humanoid.Animator;
    	animation2:LoadAnimation(animation):Play();
  	end;
end;

run(function()
    local silentaim: vapemodule = {}
    local namecall: (any, ...any) -> (any)
    silentaim = combat.Api.CreateOptionsButton({
        Name = 'SilentAim',
        Function = void
    })
    namecall = hookmetamethod(game, '__namecall', newcclosure(function(self: any, ...): (any, ...any) -> (any)
        local args: {any} = {...};
        if not checkcaller() and getnamecallmethod() == 'FireServer' and silentaim.Enabled and self == replicatedstorage.ShootEvent then
            local plr = GetTarget({radius = 50});
            if plr then
                args[1][2].Hit = plr.RootPart;
            end;
            return namecall(self, unpack(args));
        end;
        return namecall(self, ...);
    end));
end);

run(function()
    local killaura: vapemodule = {Enabled = false};
    local killaurarange: vapeslider = {Value = 10};
    local killaurabox: vapeminimodule = {Enabled = false};
    local killauraboxcolor: vapecolorslider = newcolor();
    local killauraboxmaterial: vapedropdown = {Value = 'Neon'};
    local killauraboxtransparency: vapeslider = {Value = 0.5}

    local killauraboxes: {Part} = {};

    killaura = blatant.Api.CreateOptionsButton({
        Name = 'Killaura',
        Function = function(call: bool): (bool) -> ()
            if call then
                repeat
                    local plrs: {rendertarget} = GetAllTargets(killaurarange.Value);
                    if #plrs > 0 then
                        for i: number, v: rendertarget in plrs do
                            if killaurabox.Enabled then
                                if killauraboxes[v.Player.Name] and killauraboxes[v.Player.Name].Parent then
                                    killauraboxes[v.Player.Name].CFrame = v.RootPart.CFrame;
                                    killauraboxes[v.Player.Name].Color = Color3.fromHSV(killauraboxcolor.Hue, killauraboxcolor.Sat, killauraboxcolor.Value);
                                    tween:Create(killauraboxes[v.Player.Name], TweenInfo.new(0.5), {Transparency =  0.1 * killauraboxtransparency.Value}):Play();
                                elseif killauraboxes[v.Player.Name].Parent == nil then
                                    table.remove(killauraboxes, table.find(killauraboxes, v.Player.Name));
                                else
                                    local killaurabox: Part = Instance.new('Part', v.RootPart.Parent);
                                    killaurabox.Anchored = true;
                                    killaurabox.Transparency = 1;
                                    killaurabox.Material = Enum.Material[killauraboxmaterial.Value];
                                    killaurabox.CanCollide = false;
                                    killaurabox.Size = Vector3.new(4, 6, 4);
                                    killaurabox.Color = Color3.fromHSV(killauraboxcolor.Hue, killauraboxcolor.Sat, killauraboxcolor.Value);
                                    killaurabox.CFrame = v.RootPart.CFrame;
                                    killauraboxes[v.Player.Name] = killaurabox;
                                    tween:Create(killaurabox, TweenInfo.new(0.5), {Transparency =  0.1 * killauraboxtransparency.Value}):Play();
                                end;
                            end;
                            replicatedstorage.meleeEvent:FireServer(v.Player);
                            playAnimation(484926359);
                            vapetarget.Targets.Killaura = {
                                Humanoid = {
                                    Health = v.Humanoid.Health,
                                    MaxHealth = v.Humanoid.MaxHealth
                                },
                                Player = v.Player
                            };
                            render.targets:updatehuds(v);
                        end;
                    else
                        for i: string, v: Part in killauraboxes do
                            pcall(function()
                                tween:Create(killaurabox, TweenInfo.new(0.3), {Transparency = 1}):Play();
                            end);
                        end;
                    end;
                    task.wait()
                until not killaura.Enabled
            else
                for i: string, v: Part in killauraboxes do 
                    table.clear(killauraboxes);
                    pcall(v.Destroy);
                end;
            end;    
        end
    });
    killaurarange = killaura.CreateSlider({
        Name = 'Range',
        Min = 1,
        Max = 200,
        Function = void,
        Default = 100
    });
    killaurabox = killaura.CreateToggle({
        Name = 'Show target',
        Function = function(call: bool): (bool) -> ()
            pcall(function()
                killauraboxcolor.Object.Visible = call;
                killauraboxmaterial.Object.Visible = call;
                killauraboxtransparency.Object.Visible = call
            end);
        end,
        HoverText = 'Shows a box over the opponent.'
    });
    killauraboxcolor = killaura.CreateColorSlider({
        Name = 'Box Color',
        Function = void
    });
    killauraboxmaterial = killaura.CreateDropdown({
        Name = 'Material',
        Function = void,
        List = GetEnumItems('Material')
    });
    killauraboxtransparency = killaura.CreateSlider({
        Name = 'Transparency',
        Min = 1,
        Max = 9,
        Function = void,
        Default = 6
    });
end)


run(function()
    local autopickup = {}
    autopickup = utility.Api.CreateOptionsButton({
        Name = 'AutoPickUp',
        Function = function(call)
            if call then
                repeat
                    for i: number, v: Instance in workspace.Prison_ITEMS.giver:GetChildren() do
                        workspace.Remote.ItemHandler:InvokeServer(v:FindFirstChild('ITEMPICKUP'));
                    end;
                    for i: number, v: Instance in workspace.Prison_ITEMS.single:GetChildren() do
                        workspace.Remote.ItemHandler:InvokeServer(v:FindFirstChild('ITEMPICKUP'));
                    end;
                    task.wait(0.5);
                until (not autopickup.Enabled);
            end;
        end
    });
end);

run(function()
    local gunmod = {}
    local firerate = {}
    local maxammo = {}
    local range = {}
    gunmod = exploit.Api.CreateOptionsButton({
        Name = 'GunMod',
        Function = function(call)
            if call then
                repeat
                    local weapons = store.getweapons(false)
                    for i,v in weapons do
                        require(v.GunStates).MaxAmmo = maxammo.Value
                        require(v.GunStates).Range = range.Value
                    end
                    task.wait(1)
                until (not gunmod.Enabled)
            end
        end
    })
    maxammo = gunmod.CreateSlider({
        Name = 'MaxAmmo',
        Min = 0,
        Max = 1000,
        Function = void,
        Default = math.huge
    })
    range = gunmod.CreateSlider({
        Name = 'Range',
        Min = 0,
        Max = 100,
        Function = void,
        Default = 50
    })
end)
--[[
run(function()
    local autoarrest = {}
    local arresting = false
    local oldroot
    local newroot
    local function createclone()
        repeat task.wait(.1) until isAlive(lplr, true)
        lplr.Character.Parent = game
        lplr.Character.HumanoidRootPart.Archivable = true
        oldroot = lplr.Character.HumanoidRootPart 
        newroot = oldroot:Clone()
        newroot.Parent = lplr.Character
        oldroot.Parent = workspace
        oldroot.Transparency = 0.4
        lplr.Character.PrimaryPart = newroot
        lplr.Character.Parent = workspace
    end
    local function removeclone() 
		oldroot.CFrame = newroot.CFrame
        oldroot.Transparency = 1
        lplr.Character.Parent = game
        oldroot.Parent = lplr.Character
        newroot.Parent = workspace
        lplr.Character.PrimaryPart = oldroot
        lplr.Character.Parent = workspace
        newroot:Remove()
        newroot = {} 
        oldroot = {}
    end
    autoarrest = blatant.Api.CreateOptionsButton({
        Name = 'AutoArrest',
        Function = function(call)
            if call then
                pcall(createclone)
                table.insert(autoarrest.Connections, runservice.Stepped:Connect(function()
                    if oldroot then
                        oldroot.Velocity = Vector3.zero
                        if not arresting then
                            oldroot.CFrame = newroot.CFrame
                        end
                    end
                end))
                repeat
                    if lplr.Team ~= 'Guards' then return end
                    for i,v in players:GetPlayers() do
                        if isAlive(v) and v.Team == 'Crimianals' then
                            arresting = true
                            oldroot.CFrame = v.Character.HumanoidRootPart.CFrame
                            task.wait(0.12)
                            for i = 1,4 do workspace.Remote.arrest:InvokeServer(v) end
                            arresting = false
                            task.wait(1)
                        end
                    end
                    task.wait(0.5)
                until (not autoarrest.Enabled)
            else
                pcall(removeclone)
            end
        end
    })
end)]]


run(function()
    local deathtp: vapemodule = {Enabled = false};
    local deathtpthread: thread;
    local oldcf: CFrame;
    deathtp = blatant.Api.CreateOptionsButton({
        Name = 'AntiDeath',
        Function = function(call)
            if call then
                deathtpthread = task.spawn(function()
                    repeat
                        if not isAlive() then
                            oldcf = lplr.Character.HumanoidRootPart.CFrame
                            task.wait(0.12)
                            workspace.Remote.TeamEvent:FireServer(tostring(lplr.TeamColor))
                            task.wait(0.2)
                            lplr.Character.HumanoidRootPart.CFrame = oldcf
                        end
                        task.wait(0.2)
                    until (not deathtp.Enabled)
                end)
                table.insert(deathtp.Connections, lplr.CharacterAdded:Connect(function()
                    lplr.Character.HumanoidRootPart.CFrame = oldcf;
                end));
            else
                pcall(task.cancel, deathtpthread)
            end
        end,
        HoverText = 'Teleports to your old position after respawns.'
    })
end)
