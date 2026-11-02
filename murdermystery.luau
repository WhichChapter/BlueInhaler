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
   CustomModules/142823291.lua (Murder Mistery 2) - SystemXVoid/BlankedVoid 
   https://renderintents.lol.xyz                                                                                                                                                                                                                                                                     
]]

type vapeobjectsapi = {
    Api: table
};

type vapelegitmoduleargs = {
	Name: string,
	Function: (boolean) -> ()
};

type vapegui = {
    ObjectsThatCanBeSaved: vapeobjectsapi
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

for i,v in render.utils do 
    getfenv()[i] = v 
end;

local run: (() -> any) -> () = run;
local renderconnections: table = renderconnections;
local RenderLibrary: table = RenderLibrary;

local rendervape: vapegui = shared.rendervape;
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

local combat: vapewindow = rendervape.ObjectsThatCanBeSaved.CombatWindow;
local blatant: vapewindow = rendervape.ObjectsThatCanBeSaved.BlatantWindow;
local visual: vapewindow = rendervape.ObjectsThatCanBeSaved.RenderWindow;
local exploit: vapewindow = rendervape.ObjectsThatCanBeSaved.ExploitWindow;
local utility: vapewindow = rendervape.ObjectsThatCanBeSaved.UtilityWindow;
local world: vapewindow = rendervape.ObjectsThatCanBeSaved.WorldWindow;

local store; store = {
    coins = setmetatable({}, {
        __index = function(self: number, index: number?)
            local success: boolean, result: table = pcall(function()
                return workspace.Normal.CoinContainer:GetChildren()
            end);
            return (success and result[index] or nil)
        end,
        __iter = function()
            local success: boolean, result: table = pcall(function()
                return workspace.Normal.CoinContainer:GetChildren()
            end);
            return next, (success and result or {})
        end
    })
};

function store:getmurder(): Player | nil
    for i: number, v: Player in players:GetPlayers() do 
        if v.Backpack:FindFirstChild('Knife') or v.Character and v.Character:FindFirstChild('Knife') then 
            return v
        end
    end
end;

function store:getsheriff(): Player | nil
    for i: number, v: Player in players:GetPlayers() do
        if v.Backpack:FindFirstChild('Gun') or v.Character and v.Character:FindFirstChild('Gun') then 
            return v
        end
    end
end;

getgenv().MurderMistery = store;
rendervape.RemoveObject('KillauraOptionsButton');

run(function()
    local murderchances: vapelegitmodule = {};
    local murderdisplay: TextLabel = Instance.new('TextLabel');
    murderchances = rendervape.CreateLegitModule({
        Name = 'Murderer Chance',
        Function = function(calling)
            if calling then 
                task.spawn(function()
                    repeat
                        task.wait(0.4);
                        murderdisplay.Text = `{replicatedstorage.Remotes.Extras.GetChance:InvokeServer()}% Murderer Chance`;
                    until (not murderchances.Enabled)
                end)
            end
        end
    })
    murderdisplay = Instance.new('TextLabel', murderchances.GetCustomChildren());
    murderdisplay.Size = UDim2.new(0, 187, 0, 41);
    murderdisplay.BackgroundTransparency = 0.5;
    murderdisplay.TextSize = 15;
    murderdisplay.Font = Enum.Font.Gotham;
    murderdisplay.Text = '0% Murderer Chance';
    murderdisplay.TextColor3 = Color3.new(1, 1, 1);
    murderdisplay.BackgroundColor3 = Color3.new();
    Instance.new('UICorner', murderdisplay).CornerRadius = UDim.new(0, 4)
end);

renderconnections[#renderconnections + 1] = task.spawn(function()
    local oldmurderer: Player = nil;
    local oldsherrif: Player = nil;
    repeat 
        local murderer: Player | nil = store:getmurder();
        local sheriff: Player | nil = store:getsheriff();
        if oldmurderer ~= nil and oldmurderer ~= murderer then 
            getmetatable(RenderLibrary.tags)[oldmurderer] = nil;
            oldmurderer = nil;
        end;
        if oldsherrif ~= nil and oldsherrif ~= sheriff then 
            getmetatable(RenderLibrary.tags)[oldsherrif] = nil;
            oldsherrif = nil;
        end;
        if murderer and murderer ~= lplr then 
            local oldtag: rendertag | nil = RenderLibrary:getplayertag(murderer);
            if RenderLibrary.whitelist:get(3, murderer) < 2 and (oldtag == nil or oldtag.text ~= 'MURDERER') then 
                oldmurderer = murderer;
                RenderLibrary:tagplayer(murderer, 'MURDERER', 'FF0000')
            end;
        end;
        if oldsherrif and sheriff ~= lplr then 
            local oldtag: rendertag | nil = RenderLibrary:getplayertag(sheriff);
            if RenderLibrary.whitelist:get(3, sheriff) < 2 and (oldtag == nil or oldtag.text ~= 'SHERIFF') then 
                oldsherrif = sheriff;
                RenderLibrary:tagplayer(sheriff, 'SHERIFF', '00008B')
            end;
        end;
        task.wait()
    until (not render)
end);

run(function()
    local coinesp: vapemodule = {};
    local coinhighlights: securetable = Performance.new();
    local coinespthread;
    coinesp = visual.Api.CreateOptionsButton({
        Name = 'CoinESP',
        HoverText = 'Adds a highlight to coins on the map.',
        Function = function(calling: boolean)
            if calling then 
                coinespthread = task.spawn(function()
                    repeat 
                        for i: number, v: Part in store.coins do 
                            local coinpart: Part | nil = v:FindFirstChild('CoinVisual') and v.CoinVisual:FindFirstChild('MainCoin') or v;
                            if not coinpart then 
                                continue
                            end;
                            local highlight: Highlight = coinhighlights[v] or Instance.new('Highlight', coinpart);
                            highlight.FillTransparency = 0.1;
                            highlight.FillColor = Color3.fromRGB(245, 205, 48);
                            highlight.OutlineTransparency = 1;
                            highlight.Adornee = nil;
                            highlight.Adornee = coinpart;
                            coinhighlights[v] = highlight;
                        end
                        task.wait()
                    until (not coinesp.Enabled)
                end)
            else
                pcall(task.cancel, coinespthread);
                coinhighlights:clear(function(highlight: Highlight)
                    highlight:Destroy()
                end)
            end
        end
    });
end);

run(function()
    local autoshoot: vapemodule = {};
    autoshoot = blatant.Api.CreateOptionsButton({
        Name = 'AutoShoot',
        HoverText = 'Automatically shoots the murderer.',
        Function = function(calling: boolean)
            if calling then 
                repeat 
                    if isAlive(lplr, true) and store:getsheriff() == lplr then 
                        local murder: Player | nil = store:getmurder();
                        if murder and murder.Character.PrimaryPart and (lplr.Character.PrimaryPart.Position - murder.Character.PrimaryPart).Magnitude < 25 then 
                            if lplr.Character:FindFirstChild('Gun') == nil then 
                                lplr.Character.Humanoid:EquipTool(lplr.Backpack.Gun)
                            end;
                            lplr.RemoteFunction:InvokeServer(1, CFrame.lookAt(lplr.Character.PrimaryPart.Position, murder.Character.PrimaryPart.Position).Position, 'AH2')
                        end;
                    end;
                    task.wait()
                until (not autoshoot.Enabled)
            end
        end
    })
end);

run(function()
    local killaura: vapemodule = {};
    local killaurarange: vapeslider = {Value = 12};
    local lastcloneTeleport: number = tick() - 0.3;
    killaura = blatant.Api.CreateOptionsButton({
        Name = 'AutoStab',
        HoverText = 'Automatically murders players.',
        Function = function(calling: boolean)
            if calling then 
                repeat
                    if isAlive(lplr, true) and store:getmurder() == lplr then
                        local target: rendertarget = GetTarget({radius = killaurarange.Value, friendly = true});
                        if target.RootPart then 
                            if render.clone.old and (tick() - lastcloneTeleport) < 0.3 then 
                                render.clone.old.CFrame = target.RootPart.CFrame;
                                lastcloneTeleport = tick();
                            end;
                            lplr.Stab:FireServer('Down');
                            render.target:updatehuds(target);
                        end;
                    else
                        render.target:updatehuds();
                    end;
                    task.wait();
                until (not killaura.Enabled)
            end
        end
    })
end);

