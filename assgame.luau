
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
   CustomModules/18879239467.luau (Bloody-playground) - SystemXVoid/BlankedVoid          
   https://renderintents.lol                                                                                                                                                                                                                                                                     
]]

type vapeminimodule = {
	Enabled: boolean,
	Object: Instance,
	ToggleButton: (boolean | nil, boolean | nil) -> ()
};

type kickscreenapi = {
    instance: Frame?,
    activate: (kickscreenapi, string, string?) -> ()
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

type rendertarget = {
    RootPart: BasePart | Part | nil,
    Player: Player | Model | nil,
    Humanoid: Humanoid | nil,
    Human: boolean | nil
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

type vapemain = {
    objects: {{Api: vapemodule}};
    ObjectsThatCanBeSaved: {{Api: vapemodule}}
};

type vapewindow = {
	Api: {
		CreateOptionsButton: (table) -> vapemodule,
		SetVisible: (boolean | nil) -> ()
	}
};

type gamestore = {
    map: Model?,
    active: boolean,
    computersValue: number,
    status: string,
    escaped: boolean
}; 

type bool = boolean;

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

run(function()
    local killaura: vapemodule = {Enabled = false};
    local killaurarange: vapeslider = {Value = 200};
    killaura = blatant.Api.CreateOptionsButton({
        Name = 'Killaura',
        Function = function(calling: bool): ()
            if calling then 
                repeat
                    local target: (rendertarget) = GetTarget({
                        radius = killaurarange.Value
                    });
                    if isAlive(lplr, true) and target and lplr.Character:FindFirstChild('Combat') then
                        replicatedstorage.Remotes.Swing:FireServer(lplr.Character.Combat, 'Hit', target.RootPart);                       
                    end;
                    task.wait();
                until (not killaura.Enabled);
            end;
        end
    });
    killaurarange = killaura.CreateSlider({
        Name = 'Range',
        Function = void,
        Min = 1,
        Max = 80
    });
end);

run(function()
    local autoshoot: vapemodule = {Enabled = false};
    local autoshootrange: vapeslider = {Value = 1};
    local getweapon: () -> () = function(): (string)
        local tool: Tool? = nil;
        if isAlive(lplr, true) then
            for i: number, v: BasePart? in lplr.Character:GetChildren() do
                if v.ClassName == 'Tool' then
                    tool = v;
                    break;
                end;
            end;
        end;
        return tool;
    end;
    autoshoot = blatant.Api.CreateOptionsButton({
        Name = 'AutoShoot',
        HoverText = 'Automatically shoots players.',
        Function = function(callinng: bool): ()
            if calling then 
                repeat
                    local target: (rendertarget) = GetTarget({
                        radius = autoshootrange.Value
                    });
                    if getweapon() and target then
                        replicatedstorage.Remotes.Fire:FireServer(getweapon().Name, 'Hit', {
                            normal = target.RootPart.Position,
                            velocity = target.RootPart.Velocity,
                            hit = target.RootPart,
                            position = lplr.Character.HumanoidRootPart.Position
                        });
                    end;
                    task.wait();
                until (not autoshoot.Enabled);
            end;
        end
    });
    autoshootrange = autoshoot.CreateSlider({
        Name = 'Range',
        Function = void,
        Min = 1,
        Max = 80
    });
end);