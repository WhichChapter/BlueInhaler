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
   CustomModules/18901165922.lua (A Dusty Trip) - Maxlasertech            
   https://renderintents.lol                                                                                                                                                                                                                                                                            
]]

type vapemain = {
    ObjectsThatCanBeSaved: table,
    objects: table
};
   
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

local cloneref = cloneref or function(data) return data end;
local getservice = function(service)
	return cloneref(game:GetService(service))
end;
local rendervape: vapemain = gui;
local vape: vapemain = rendervape;
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
local vapeTargetInfo: table = shared.VapeTargetInfo;
local vapeInjected: boolean = true;

local blatant: table = vape.ObjectsThatCanBeSaved.BlatantWindow;
local visual: table = vape.ObjectsThatCanBeSaved.RenderWindow;
local exploit: table = vape.ObjectsThatCanBeSaved.ExploitWindow;
local utility: table = vape.ObjectsThatCanBeSaved.UtilityWindow;
local world: table = vape.ObjectsThatCanBeSaved.WorldWindow;
local inventory: table = vape.ObjectsThatCanBeSaved.InventoryWindow;
local minigames: table = vape.ObjectsThatCanBeSaved.MinigamesWindow;

local store: table = setmetatable({}, {
    __index = function(self: table, index: string)
        self[index] = Performance.new();
        return rawget(self, index);
    end
});

run(function()
    store.functions.findchild = function(child: string): (string) -> (Instance?)
        assert(type(child) == 'string', `Argument 1 String expected, got {typeof(child)}`);
        local child: Part? = nil;
        for i: number, v: Instance in store.blocks do
            if v.Name == child then
                child = v;
                break;
            end;
        end;
        return child;
    end;
    store.functions.getvalue = function(instance: Instance): (Instance) -> (boolean?)
        assert(typeof(instance) == 'string' or typeof(instance) ~= nil);
        return instance.Value or instance:FindFirstChild('Value').Value;
    end;
    store.functions.getchildren = function(instance: Instance): (Instance) -> {Instance}
        local instances: {Instance} = {};
        for i,v in instance:GetChildren() do
            table.insert(instances, v);
        end;
        return instances;
    end
    store.functions.getcurrentcar = function(): () -> (Model?) 
        local car: Model? = nil;
        for i: number, v: Instance in store.blocks do
            if v.Name:find('Car') then
                local mag: number = (lplr.Character.HumanoidRootPart.Position - v:FindFirstChildWhichIsA('Part').Position).magnitude;
                if mag <= 35 then
                    car = v;
                    break;
                end;
            end;
        end;
        return car
    end;
    table.insert(vapeConnections, workspace.DescendantAdded:Connect(function(v: Instance): () -> ()
        table.insert(store.blocks, v)
    end));

    for i: number, v: Instance in workspace:GetDescendants() do
        table.insert(store.blocks, v)
    end

    vape.RemoveObject('CombatWindow');
    vape.RemoveObject('MinigamesWindow');
end)

--> utility tab <--

run(function() --> pasted from 2023 just with types
    local removeEngine: vapemodule = {}
    local vehicle: vapedropdown = {Value = 'Sedan'}
    local oldison: number
    local oldmaxspeed: number
    local oldtorque: number
    local oldturnspeed: number
    removeEngine = utility.Api.CreateOptionsButton({
        Name = 'AutoDrive',
        Function = function(call)
            if call then
                oldison = workspace[vehicle.Value].values.ison.Value
                oldmaxspeed = workspace[vehicle.Value].DriveSeat.MaxSpeed
                oldtorque = workspace[vehicle.Value].DriveSeat.Torque
                oldturnspeed = workspace[vehicle.Value].DriveSeat.TurnSpeed
                workspace[vehicle.Value].DriveSeat.MaxSpeed = math.huge
                workspace[vehicle.Value].DriveSeat.TurnSpeed = 0.1
                workspace[vehicle.Value].values.ison.Value = true
                workspace[vehicle.Value].DriveSeat.Torque = math.huge
            else
                workspace[vehicle.Value].DriveSeat.MaxSpeed = oldmaxspeed
                workspace[vehicle.Value].DriveSeat.TurnSpeed = oldturnspeed
                workspace[vehicle.Value].values.ison.Value = oldison
                workspace[vehicle.Value].DriveSeat.Torque = oldtorque
            end
        end,
        ExtraText = function()
            return vehicle.Value
        end,
        HoverText = "This makes you drive without needing engine (only wheels)"
    })
    vehicle = removeEngine.CreateDropdown({
        Name = 'Vehicle',
        List = {'Sedan', 'Van', 'FlameTruck'},
        Function = void
    })
end)

--> exploit tab <--

run(function()
    local fillexploit: vapemodule = {Enabled = false};
    fillexploit = exploit.Api.CreateOptionsButton({
        Name = 'FillExploit',
        HoverText = 'Automatically multiply your gas/oil by 100x',
        Function = void
    });
    local fillcall; fillcall = hookmetamethod(game, '__namecall', newcclosure(function(self: any, ...): (any, ...any)
        if fillexploit.Enabled and not checkcaller() and getnamecallmethod():find('Server') and tostring(self) == 'Fill' then
            for _: number = 1, 400 do
                fillcall(self, ...);
            end;
        end;
        return fillcall(self, ...);
    end));
end);

task.spawn(function()
    local uselessmodules: {string} = {
        'AutoClicker',
        'Reach',
        'HitBoxes',
        'Killaura',
        'TargetStrafe',
        'Clipper',
        'BoostJump',
        'SafeWalk',
        'Swim'
    };
    for i: number, v: string in uselessmodules do 
        rendervape.RemoveObject(`{v}OptionsButton`);
    end;

    repeat task.wait() until shared.VapeFullyLoaded;
    rendervape.RemoveObject('CombatWindow');
end);

--> inventory tab <--
