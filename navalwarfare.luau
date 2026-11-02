
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
   CustomModules/2210085102.luau (Naval Warfare) - SystemXVoid/BlankedVoid          
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
    escaped: boolean
}; 

export type bool = boolean;

export type entitylib = {
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

run(function()
    local killaura: vapemodule = {Enabled = false};
    local killaurarange: vapeslider = {Value = 200};
    killaura = blatant.Api.CreateOptionsButton({
        Name = 'Killaura',
        HoverText = 'Automatically shoots players.',
        Function = function(calling: bool): ()
            if calling then 
                repeat
                    local targets: {rendertarget} = GetActiveTargets({radius = killaurarange.Value});
                    for i: number, v: rendertarget in targets do 
                        replicatedstorage.Event:FireServer('shootRifle', '', {v.Humanoid});
                        replicatedstorage.Event:FireServer('shootRifle', 'hit', {v.Humanoid});
                    end;
                    task.wait();
                until (not killaura.Enabled)
            end
        end
    })
end)

