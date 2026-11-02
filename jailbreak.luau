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
   CustomModules/606849621.lua (Jailbreak) - SystemXVoid/BlankedVoid 
   https://renderintents.lol                                                                                                                                                                                                                                                                     
]]

type vapeobjectsapi = {
    Api: table
};

type vapelegitmoduleargs = {
	Name: string,
	Function: (boolean) -> ()
};

type vapegui = {
    ObjectsThatCanBeSaved: vapeobjectsapi,
	SelfDestructEvent: BindableEvent
};

type vapemoduleargs = {
    Name: string,
    HoverText: string | nil,
    ExtraText: (() -> string) | nil,
    Function: (boolean) -> any
};

type vapedropdownargs = {
    Name: string,
    List: table,
    Function: (string) -> any
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

type vapelegitmodule = {
	GetCustomChildren: Instance,
	Object: Instance
};

type vapemodule = {
    Connections: table,
    Enabled: boolean,
    Object: Instance,
    ToggleButton: (boolean | nil, boolean | nil) -> (),
	CreateTextList: (table) -> vapetextlist,
	CreateColorSlider: (table) -> vapeslider,
	CreateToggle: (table) -> vapeminimodule,
	CreateDropdown: (vapedropdownargs) -> vapedropdown,
	CreateSlider: (table) -> vapeslider,
	CreateTextBox: (table) -> vapetextbox,
	GetCustomChildren: (table) -> vapecustomwindow,
    CreateLegitModule: (vapelegitmoduleargs) -> vapelegitmodule
};

type vapewindowapi = {
	CreateOptionsButton: (vapemoduleargs) -> vapemodule,
	SetVisible: (boolean | nil) -> ()
};

type vapewindow = {
    Api: vapewindowapi
};

type rendertarget = {
    RootPart: BasePart | Part | nil,
    Player: Player | Model | nil,
    Humanoid: Humanoid | nil,
    Human: boolean | nil
};

type rendertable = {
    utils: table
};

type rendertag = {
    text: string,
    hex: string
};

type jailbreakinvitem = {
    _maid: table?,
    obj: BoolValue,
    onAttemptDrop: (...any) -> any,
    onAttempSelect: (...any) -> any
};

for i,v in render.utils do 
    getfenv()[i] = v 
end;

local run: (() -> any) -> () = run;
local renderconnections: table = renderconnections;
local RenderLibrary: table = RenderLibrary;

local vape: vapegui = shared.rendervape;
local render: rendertable = render;
local players: Players = getservice('Players');
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
local camera: Camera = workspace.CurrentCamera;
local lplr: Player = players.LocalPlayer;

local combat: vapewindow = vape.ObjectsThatCanBeSaved.CombatWindow;
local blatant: vapewindow = vape.ObjectsThatCanBeSaved.BlatantWindow;
local visual: vapewindow = vape.ObjectsThatCanBeSaved.RenderWindow;
local exploit: vapewindow = vape.ObjectsThatCanBeSaved.ExploitWindow;
local utility: vapewindow = vape.ObjectsThatCanBeSaved.UtilityWindow;
local world: vapewindow = vape.ObjectsThatCanBeSaved.WorldWindow;

local store: table; store = {
    constants = setmetatable({}, {
        __index = function(self: table, index: string)
            local attribute: Instance = lplr:FindFirstChild(index);
            return (attribute and attribute.ClassName:find('Value') and attribute.Value)
        end
    }),
    inventory = {},
    controllers = {},
};

pcall(function() store.controllers.InventoryItemSystem = require(replicatedstorage.Inventory.InventoryItemSystem) end);

function store:getinventory(player: Player?)
    assert(player == nil or typeof(player) == 'Instance' and player.ClassName == 'Player', `Player expected for argument #1, got {typeof(player) == 'Instance' and player.ClassName or typeof(player)}`);
    local player: Player = player or lplr;
    local success: boolean, inventory: table | string = pcall(self.controllers.InventoryItemSystem.getInventoryItemsFor, player);
    if success then 
        return inventory;
    end;
    return {};
end;

function store:getgun(): jailbreakinvitem?
    for i: number, v: jailbreakinvitem in self:getinventory() do 
        if v.obj:FindFirstChild('Reload') then 
            return v 
        end
    end;
end;

run(function()
    local autoreload: vapemodule = {};
    autoreload = utility.Api.CreateOptionsButton({
        Name = 'AutoReload',
        HoverText = 'Automatically reloads weapons.',
        Function = function(calling: boolean)
            if calling then 
                repeat 
                    local gun: jailbreakinvitem? = store:getgun();
                    if gun and gun.obj:FindFirstChild('Reload') and not gun.obj:GetAttribute('IsReloading') then 
                        gun.obj.Reload:FireServer()
                    end;
                    task.wait()
                until (not autoreload.Enabled)
            end
        end
    })
end);

run(function()
    local autoarrest: vapemodule = {};
end);

