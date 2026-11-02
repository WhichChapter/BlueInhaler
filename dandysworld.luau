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
   CustomModules/17750024818.luau (Dandy's world) - Monia And MaxlaserTech
   https://renderintents.lol                                                                                                                                                                                                                                                                     
]]

for i,v in render.utils do 
    getfenv()[i] = v; 
end;

type vapeobjectsapi = {
    Api: table
};

type vapelegitmodule = {
	Name: string,
	Function: (boolean) -> ()
};

type vapegui = {
    ObjectsThatCanBeSaved: vapeobjectsapi
};

type vapemodule = {
    Name: string,
    HoverText: string | nil,
    ExtraText: (() -> string) | nil,
    Function: (boolean) -> any
};

type vapedropdown = {
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
	CreateDropdown: (vapedropdown) -> vapedropdown,
	CreateSlider: (table) -> vapeslider,
	CreateTextBox: (table) -> vapetextbox,
	GetCustomChildren: (table) -> vapecustomwindow,
    CreateLegitModule: (vapelegitmodule) -> vapelegitmodule
};

type vapewindowapi = {
	CreateOptionsButton: (vapemodule) -> vapemodule,
	SetVisible: (boolean | nil) -> ()
};

type vapewindow = {
    Api: vapewindowapi
};

type inventoryobject = {
    name: string,
    tool: Tool | nil,
    amount: number,
    class: string,
    slotType: string,
    rawmeta: table
}; 

type rendertarget = {
    RootPart: BasePart | Part | nil,
    Player: Player | Model | nil,
    Humanoid: Humanoid | nil,
    Human: boolean | nil,
    Distance: number?
};

type rendertable = {
    utils: table
};

type rendertag = {
    text: string,
    hex: string
};

local vape: vapewindow = shared.rendervape;
local combat: vapewindow = vape.ObjectsThatCanBeSaved.CombatWindow;
local blatant: vapewindow = vape.ObjectsThatCanBeSaved.BlatantWindow;
local visual: vapewindow = vape.ObjectsThatCanBeSaved.RenderWindow;
local exploit: vapewindow = vape.ObjectsThatCanBeSaved.ExploitWindow;
local utility: vapewindow = vape.ObjectsThatCanBeSaved.UtilityWindow;
local world: vapewindow = vape.ObjectsThatCanBeSaved.WorldWindow;
local inventory: vapewindow = vape.ObjectsThatCanBeSaved.InventoryWindow;
local minigames: vapewindow = vape.ObjectsThatCanBeSaved.MinigamesWindow;
local RenderLibrary: table = RenderLibrary;
local render: table = render;

local replicatedstorage: ReplicatedStorage = getservice('ReplicatedStorage');
local httpservice: HttpService = getservice('HttpService');
local teleport: TeleportService = getservice('TeleportService');
local players: Players = getservice('Players');
local lighting: Lighting = getservice('Lighting');
local startergui: StarterGear = getservice('StarterGui');
local inputservice: UserInputService = getservice('UserInputService');
local runservice: RunService = getservice('RunService');
local collection: CollectionService = getservice('CollectionService');
local tween: TweenService = getservice('TweenService');
local fakecam: Camera = Instance.new('Camera');
local camera: Camera = workspace.CurrentCamera;
local lplr: Player = players.LocalPlayer;
local vapetarget: table = shared.VapeTargetInfo;
local entityLibrary: table = shared.vapeentity;

local store: table = setmetatable({}, {
    __index = function(self: table, index: string): (table, string) -> (string?)
        if index == 'floor' or index:find('floor') then
            local floor: number = 0
            for i: number, v: Model in workspace.CurrentRoom:GetChildren() do
				floor = tonumber(v.Name)
			end
            return floor
        end;
        if index == 'prompts' or index:find('prompts') then
            local indexprompts: {ProximityPrompt} = {};
            for i: number, v: Instance in workspace.CurrentRoom[self.floor].Items:GetDescendants() do
                if v.ClassName == 'ProximityPrompt' then
                    table.insert(indexprompts, v);
                end;
            end;
            return indexprompts;
        end
    end
});

run(function()
    local autocollect: vapemodule = {Enabled = false};
    autocollect = inventory.Api.CreateOptionsButton({
        Name = 'AutoCollect',
        Function = function(call: boolean): ()
            if call then
                repeat
                    for i: number, v: ProximityPrompt in store.prompts do
                        fireproximityprompt(v);
                    end;
                    task.wait();
                until not autocollect.Enabled
            end;
        end
    })
end)

run(function()
    local autofix: vapemodule = {Enabled = false};
    local goldarea: Frame = lplr.PlayerGui.ScreenGui.Menu.SkillCheckFrame.GoldArea
	local requiredarea: Frame = lplr.PlayerGui.ScreenGui.Menu.SkillCheckFrame.RequiredArea
	local genmark: Frame = lplr.PlayerGui.ScreenGui.Menu.SkillCheckFrame.Marker
    autofix = minigames.Api.CreateOptionsButton({
        Name = 'AutoFix',
        Function = function(call: boolean): () 
            if call then
                if not firesignal then
                    return errorNotification('AutoFix', 'Missing firesignal function', 10);
                end;
                repeat
                    task.wait(0)
                    if lplr.PlayerGui.ScreenGui.Menu.SkillCheckFrame.Visible then
                        local mode = math.random(1,3)
                        if mode <= 2 or mode == 2 then
                            if genmark.Position.X.Scale >= requiredarea.Position.X.Scale then
                                firesignal(lplr.PlayerGui.ScreenGui.Menu.Calibrate.Activated)
                            end
                        elseif mode >= 2 then
                            if genmark.Position.X.Scale >= goldarea.Position.X.Scale then
                                firesignal(lplr.PlayerGui.ScreenGui.Menu.Calibrate.Activated)
                            end
                        end
                    end
                until not autofix.Enabled
            end;
        end
    })
end)
