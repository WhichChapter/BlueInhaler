
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
   games/893973440.luau (Flee the facility) - MaxlaserTech & SystemXVoid/Blankedvoid
   https://renderintents.lol                                                                                                                                                                                                                                                                     
]]

export type vapeminimodule = {
	Enabled: boolean,
	Object: Instance,
	ToggleButton: (boolean | nil, boolean | nil) -> ()
};

export type kickscreenapi = {
    instance: Frame?,
    activate: (kickscreenapi, string, string?) -> ()
};

export type vapeslider = {
	Value: number,
	Object: Instance,
	SetValue: (number) -> ()
};

export type vapecolorslider = {
	Hue: number,
	Sat: number,
	Value: number,
	Object: Instance,
	SetRainbow: (boolean | nil) -> (),
	SetValue: (number, number, number) -> ()
};

export type rendertarget = {
    RootPart: BasePart | Part | nil,
    Player: Player | Model | nil,
    Humanoid: Humanoid | nil,
    Human: boolean | nil
};

export type vapedropdown = {
	Value: string,
	Object: Instance,
	SetValue: (table) -> ()
};

export type vapetextlist = {
	ObjectList: table,
	Object: Instance,
	RefreshValues: (table) -> table
};

export type vapetextbox = {
	Value: string,
	Object: Instance,
	SetValue: (string) -> ()
};

export type vapecustomwindow = {
	GetCustomChildren: (table) -> Frame,
	SetVisible: (boolean | nil) -> ()
};

export type securetable = {
	clear: (securetable, (any, any) -> ()) -> (),
	len: (securetable) -> number,
	shutdown: (securetable) -> (),
	getplainarray: (securetable) -> table
};

export type vapemodule = {
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

export type vapemain = {
    objects: {{Api: vapemodule}};
    ObjectsThatCanBeSaved: {{Api: vapemodule}}
};

export type vapewindow = {
	Api: {
		CreateOptionsButton: (table) -> vapemodule,
		SetVisible: (boolean | nil) -> ()
	}
};

export type gamestore = {
    map: Model?,
    active: boolean,
    computersValue: number,
    status: string,
    escaped: boolean,
    mapcreated: BindableEvent;
};

type entitylib = {
    LocalPosition: Vector3;
};

local gui: vapemain = shared.rendervape;
local render: table = render;

for i: (any), v: (...any) -> (...any) in render.utils do
    getfenv()[i] = v;
end;

--> defining mostly used (by most people) variables

local gui: vapemain = gui;
local runFunction: (() -> (any)) -> () = run;
local runcode: (() -> (any)) -> () = run;

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
local entity: entitylib = shared.vapeentity;

local combat: vapewindow = gui.objects.CombatWindow;
local blatant: vapewindow = gui.objects.BlatantWindow;
local visual: vapewindow = gui.objects.RenderWindow;
local utility: vapewindow = gui.objects.UtilityWindow;
local world: vapewindow = gui.objects.WorldWindow;
local exploit: vapewindow = gui.objects.ExploitWindow;
local minigames: vapewindow = gui.objects.MinigamesWindow;
local hudwindow: vapewindow = gui.objects.TargetHUDWindow;
local guiwindow: vapewindow = gui.objects.GUIWindow;

local store: gamestore = setmetatable({
    started = false;
    mapcreated = Instance.new('BindableEvent'),
}, {
    __index = function(self: gamestore, index: string): (any)
        if index == 'active' then 
            return replicatedstorage.IsGameActive.Value;
        end;
        if index == 'status' then 
            return (replicatedstorage.GameStatus.Value or 'GAME OVER');
        end;
        if index == 'map' then 
            return (replicatedstorage.CurrentMap.Value ~= 'Nil' and replicatedstorage.CurrentMap.Value or nil);
        end;
        if index == 'escaped' then 
            return lplr.TempPlayerStatsModule.Escaped.Value;
        end;
        return rawget(self, index);
    end;
});

function store:getbeast(): (Player?)
    for i: number, v: Player in players:GetPlayers() do 
        if v.Character and v.Character:FindFirstChild('BeastPowers') then 
            return v;
        end;
    end;
end;

table.insert(renderconnections, workspace.DescendantAdded:Connect(function(object: Model?): ()
    task.wait(0.2);
    if object == store.map then 
        store.mapcreated:Fire(object);
    end;
end));

run(function()
    local antierror: vapemodule = {};
    antierror = exploit.Api.CreateOptionsButton({
        Name = 'AntiError',
        HoverText = 'Stops you from messing up when hacking computers.',
        ExtraText = function() return 'Packet' end, 
        Function = function(calling: boolean): ()
            if calling then 
                repeat
                    replicatedstorage.RemoteEvent:FireServer('SetPlayerMinigameResult', true);
                    task.wait();
                until (not antierror.Enabled);
            end;
        end;
    });
end);

run(function()
    local antiragdoll: vapemodule = {};
    antiragdoll = exploit.Api.CreateOptionsButton({
        Name = 'AntiRagdoll',
        HoverText = 'Prevents you from ragdolling while knocked out.',
        ExtraText = function() return 'Attribute' end,
        Function = function(calling: boolean): ()
            if calling then 
                lplr.TempPlayerStatsModule.Ragdoll.Value = false;
                table.insert(antiragdoll.Connections, lplr.TempPlayerStatsModule.Ragdoll:GetPropertyChangedSignal('Value'):Connect(function()
                    lplr.TempPlayerStatsModule.Ragdoll.Value = false;
                end));
            end;
        end;
    });
end);

run(function()
    local autointeract: vapemodule = {};
    autointeract = utility.Api.CreateOptionsButton({
        Name = 'AutoInteract',
        HoverText = 'Automatically interact with things like doors/computers.',
        Function = function(calling: boolean): ()
            if calling then 
                repeat
                    replicatedstorage.RemoteEvent:FireServer('Input', 'Action', true);
                    task.wait();
                until (not autointeract.Enabled);
            end;
        end;
    });
end);

run(function()
    local autorope: vapemodule = {};
    autorope = blatant.Api.CreateOptionsButton({
        Name = 'AutoLead',
        HoverText = 'Automatically ropes knocked out players.',
        Function = function(calling: boolean): ()
            if calling then 
                repeat
                    if isAlive(lplr, true) and store:getbeast() == lplr and lplr.Character:FindFirstChild('Hammer') then 
                        local target: rendertarget = GetTarget({radius = 15, firendly = true});
                        if target.RootPart then 
                            lplr.Character.Hammer.HammerEvent:FireServer('HammerTieUp', target.Player.Character:FindFirstChild('Right Leg'), lplr.Character.PrimaryPart.CFrame.Position);
                        end;
                    end;
                    task.wait();
                until (not autorope.Enabled);
            end;
        end;
    });
end);

run(function()
    local hammeraura: vapemodule = {};
    local hammeraurabox: vapeminimodule = {};
    local hammeraurarange: vapeslider = {Value = 18};
    local hammerauraboxcolor: vapecolorslider = {Hue = 0, Sat = 0, Value = 0};
    local hammerauraboxmaterial: vapedropdown = {Value = 'SmoothPlastic'};
    local hammerauraboxinvis: vapeslider = {Value = 6};
    local hammerauraboxes: securetable = Performance.new();
    hammeraura = blatant.Api.CreateOptionsButton({
        Name = 'HammerAura',
        HoverText = 'Automatically knocks out players\nwithout any need of action.',
        Function = function(calling: boolean): ()
            if calling then 
                repeat
                    task.wait();
                    local target: rendertarget = GetTarget({radius = hammeraurarange.Value, friendly = true});
                    if store:getbeast() ~= lplr or lplr.Character:FindFirstChild('Hammer') == nil or target.RootPart == nil or target.Player.TempPlayerStatsModule.Ragdoll.Value then 
                        hammerauraboxes:clear(function(box: Instance): ()
                            tween:Create(box, TweenInfo.new(0.18), {Size = (box.Size + Vector3.new(3, 3, 3))}):Play();
                            task.wait(0.18);
                            local fadeout: Tween = tween:Create(box, TweenInfo.new(0.4), {Size = Vector3.zero});
                            fadeout:Play();
                            fadeout.Completed:Wait();
                            box:Destroy();
                        end);
                        continue;
                    end;
                   -- lplr.Character.Hammer:Activate();
                    lplr.Character.Hammer.HammerEvent:FireServer('HammerHit', target.RootPart);
                    for i: number, v: Part in hammerauraboxes do 
                        if i ~= target.RootPart then 
                            tween:Create(v, TweenInfo.new(0.15), {Transparency = 1}):Play();
                            v:Destroy();
                        end;
                    end;
                    if hammeraurabox.Enabled then 
                        local box: Part = hammerauraboxes[target.RootPart] or Instance.new('Part', workspace);
                        box.Transparency = 0.1 * hammerauraboxinvis.Value;
                        box.Material = Enum.Material[hammerauraboxmaterial.Value];
                        box.Color = Color3.fromHSV(hammerauraboxcolor.Hue, hammerauraboxcolor.Sat, hammerauraboxcolor.Value);
                        box.Size = target.RootPart.Size + Vector3.new(3, 5, 3);
                        box.Position = target.RootPart.Position;
                        box.Anchored = true;
                        box.CanCollide = false;
                        if hammerauraboxes[target.RootPart] == nil then 
                            box.Size = Vector3.zero;
                            tween:Create(box, TweenInfo.new(0.35), {Size = target.RootPart.Size + Vector3.new(3, 5, 3)}):Play();
                        end;
                        hammerauraboxes[target.RootPart] = box;
                    end;
                until (not hammeraura.Enabled);
            else
                hammerauraboxes:clear(game.Destroy);
            end;
        end;
    });
    hammeraurarange = hammeraura.CreateSlider({
        Name = 'Radius',
        Min = 1,
        Max = 18,
        Default = 18,
        Function = void
    });
    hammeraurabox = hammeraura.CreateToggle({
        Name = 'Box',
        Function = function(calling: boolean): ()
            hammerauraboxcolor.Object.Visible = calling;
            hammerauraboxinvis.Object.Visible = calling;
            hammerauraboxmaterial.Object.Visible = calling;
        end;
    });
    hammerauraboxcolor = hammeraura.CreateColorSlider({
        Name = 'Box Color',
        Function = void
    });
    hammerauraboxinvis = hammeraura.CreateSlider({
        Name = 'Invisibility',
        Min = 0,
        Max = 9,
        Default = 6,
        Function = void
    });
    hammerauraboxmaterial = hammeraura.CreateDropdown({
        Name = 'Material',
        List = GetEnumItems('Material'),
        Function = void
    });

    hammerauraboxcolor.Object.Visible = false;
    hammerauraboxinvis.Object.Visible = false;
    hammerauraboxmaterial.Object.Visible = false;
end);


run(function()
    local computeresp: vapemodule = {};
    local computerespbackground: vapeminimodule = {};
    local computerespfinishcheck: vapeminimodule = {};
    local currentmap: Model?
    local addcomputertag = function(pc: Model): ()
        local image: ImageLabel = pc:WaitForChild('Screen', 9e9):FindFirstChildOfClass('BillboardGui'):FindFirstChildOfClass('ImageLabel');
        image.ImageColor3 = pc.Screen.Color;
        image.Parent.Enabled = true;
        table.insert(computeresp.Connections, image.Parent:GetPropertyChangedSignal('Enabled'):Connect(function()
            image.Parent.Enabled = true;
        end));
        table.insert(computeresp.Connections, pc.Screen:GetPropertyChangedSignal('Color'):Connect(function()
            image.ImageColor3 = pc.Screen.Color;
        end));
    end;
    computeresp = visual.Api.CreateOptionsButton({
        Name = 'ComputerESP',
        HoverText = 'Enables icons at computer locations.',
        Function = function(calling: boolean): ()
            if calling then 
                if store.map then 
                    for _: number, v: Model? in store.map:GetChildren() do 
                        if v.Name == 'ComputerTable' then 
                            task.spawn(addcomputertag, v);
                        end;
                    end;
                end;
                table.insert(computeresp.Connections, store.mapcreated.Event:Connect(function(): ()
                    repeat task.wait() until store.active;
                    computeresp:retoggle();
                end));
            end;
        end;
    });
end);