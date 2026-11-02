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
   This is a template for a custom render module.             
   https://renderintents.lol                                                                                                                                                                                                                                                                     
]]


export type vapemain = {
    ObjectsThatCanBeSaved: table,
    objects: table
};
   
export type vapeminimodule = {
	Enabled: boolean,
	Object: Instance,
	ToggleButton: (boolean | nil, boolean | nil) -> ()
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

export type vapewindow = {
	CreateOptionsButton: (table) -> vapemodule,
	SetVisible: (boolean | nil) -> ()
};

export type rendertarget = {
    Player: Player | nil,
    Humanoid: Humanoid | nil,
    RootPart: BasePart | nil,
    NPC: boolean | nil
};

export type connectionobject = {
    Disconnect: (connectionobject) -> (),
    Enable: (connectionobject) -> (),
    Disable: (connectionobject) -> (),
    Callback: (any) -> any,
    Connected: boolean
};

export type connectionconstructor = {
    Connect: (connectionconstructor, (...any) -> ...any) -> connectionobject,
    Once: (connectionconstructor, (...any) -> ...any) -> connectionobject,
    listconnections: () -> table
};

export type runtimeobject = {
    waitforevent: (runtimeobject, string, number | nil) -> (),
    events: {{Connect: ((...any) -> (...any)) -> {Disconnect: () -> ()}, Once: {Disconnect: () -> ()}}},
    initiate: (runtimeobject) -> ()
};

export type tagobject = {
    text: string,
    hex: string
};

export type httprequestrargs = {
    headers: table,
    path: string,
    subdomain: string | nil,
    method: string | nil,
    params: table | nil,
    body: string | nil,
    json: table | nil
};

export type httpresponseobject = {
    headers: table,
    status: number,
    time: number,
    body: string,
    statustype: string,
    ok: boolean,
    json: () -> table?
};

export type httpobject = {
    request: (self: httpobject, payload: httprequestrargs) -> httpresponseobject,
    getdiscord: (self: httpobject, multiple: boolean | nil, key: string | nil) -> table?,
    getfilefromcloud: (self: httpobject, file: string) -> string,
    publishtocloud: (self: httpobject, files: {name: string, contents: string}) -> number
};

export type whitelistattributes = {
    rank: string,
    attackable: boolean,
    priority: number,
    tagtext: string,
    tagcolor: string,
    taghidden: boolean,
    autokick: boolean,
    account: string | nil,
    prefix: string
};

export type whitelistobject = {
    get: (whitelistobject, number | nil, Player | nil) -> (any)
};

export type cryptobject = {
    getSecretValueAsync: (self: cryptobject, name: string) -> (string),
    storeSecretValueAsync: (self: cryptobject, name: string, value: string, base64: boolean?) -> (),
    secretExists: (self: cryptobject, secret: string) -> (boolean)
};

export type constructorobject = {
    runtime: runtimeobject,
    http: httpobject,
    crypt: cryptobject,
    whitelist: whitelistobject,
    tagplayer: (self: constructorobject, Player | nil, string, string) -> tagobject,
    getplayertag: (self: constructorobject, Player | nil) -> tagobject,
    removeplayertag: (self: constructorobject, Player | nil) -> (),
};

local gui: vapemain = shared.rendervape;
local render: table = render or warn('❌ Failed to fetch the render main table.') or {};

for i: (any), v: (...any) -> (...any) in render.utils do --> sideloads all render global utility functions from libraries/utils.lua
    getfenv()[i] = v;
end;

--> defining mostly used (by most people) variables

local rendervape: vapemain = gui;
local runFunction: (() -> (any)) -> () = run;
local runcode: (() -> (any)) -> () = run;
local bedwarsStore: table = store;

--> my favorite variables

local cloneref = cloneref or function(data) return data end;
local getservice = function(service)
	return cloneref(game:FindService(service))
end;

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
local renderlib: constructorobject = shared.renderconstructor;
local vapeEvents: table = setmetatable({}, {
	__index = function(self, index)
		self[index] = Instance.new('BindableEvent')
		return self[index]
	end
});
local vapeTargetInfo: table = shared.VapeTargetInfo;
local vapeInjected: boolean = true;

local combat: vapewindow = rendervape.objects.CombatWindow;
local blatant: vapewindow = rendervape.objects.BlatantWindow;
local visual: vapewindow = rendervape.objects.RenderWindow;
local utility: vapewindow = rendervape.objects.UtilityWindow;
local world: vapewindow = rendervape.objects.WorldWindow;
local exploit: vapewindow = rendervape.objects.ExploitWindow;
local minigames: vapewindow = rendervape.objects.MinigamesWindow;

run(function()
    local projectileaura: vapemodule = {};
    local projectileaurarange: vapeslider = {Value = 200};
    projectileaura = blatant.Api.CreateOptionsButton({
        Name = 'ShootAura',
        HoverText = 'Automatically shoots enemies.',
        Function = function(calling: boolean): ()
            if calling then 
                repeat
                    if isAlive(lplr, true) then 
                        local target: rendertarget = GetTarget({radius = projectileaurarange.Value});
                        if target.RootPart then 
                            replicatedstorage.Events.Remote.ShotTarget:FireServer(target.RootPart.Position, 'Sniper');
                        end;
                    end;
                    task.wait(0.2);
                until (not projectileaura.Enabled);
            end;
        end;
    });
end);

run(function()
    
end);