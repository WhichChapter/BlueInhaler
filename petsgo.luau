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
   CustomModules/18901165922.lua (Pets GO aka gambling game) - Selunar and Maxlasertech            
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
local cheatenginetrash = cheatenginetrash
local rendervape: vapemain = gui;
local vape: vapemain = rendervape;
local players: Players = getservice('Players');
local textservice: TextService = getservice('TextService');
local lighting: Lighting = getservice('Lighting');
local textchat: TextChatService = getservice('TextChatService');
local inputservice: UserInputService = getservice('UserInputService');
local runservice: RunService = getservice('RunService');
local pathfinding: PathfindingService = getservice('PathfindingService');
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

local store: table = {
    pets = {},
    client = {},
    consumableids = {
        fruit = {
            shiny = {
                watermelon = 'e481359ac386418faab4e12c44d8a212',
                pineapple = 'c7fffe995db24147805eef72d7f4d104',
                orange = 'a89e25236d9545f5b35283a9a2c007d1',
                banana = 'b55e528fbe6d43f4bda3bba5b73fc0a5',
                apple = 'e4618a5c09e442db84cf960cde128cbf'
            },
            normal = {
                rainbow = 'b06aa9924b9f4e51819d552d02647805',
                watermelon = 'ee9c7912bf3140e1afcac07ebd1ca2f1',
                pineapple = 'bc752aa44f9f493fbe73f0e70d78f13c',
                banana = '84c2de7c1aa24b0d917272c4f07b153e',
                apple = 'b1271964b567485389862bda01f01fce'
            }
        },
        potions = {}
    } --> have to do this poorly :(    
};

run(function()
    local suc, res = pcall(function()
        return require(replicatedstorage.Library.Client:FindFirstChildWhichIsA('ModuleScript'));
    end)
    
    if not suc then
        cheatenginetrash = true;
        alertNotification('Render', res, 10)
    end    
end)

if not firesignal then
    alertNotification('Render', 'All of the features might not be supported due to main function not working.', 10)
end;

for i: number, v: ModuleScript? in replicatedstorage.Library.Client:GetDescendants() do
    if v.ClassName == 'ModuleScript' then
        store.client[v.Name] = not cheatenginetrash and require(v) or nil;
    end
end;

local getorbs = function(distance: number): (table)
    local tab: table = {};
    for i: number, v: Instance in workspace.__THINGS.Breakables:GetDescendants() do
        if v.Name == 'Hitbox' then
            local mag: number = (lplr.Character.HumanoidRootPart.Position - v.Position).magnitude
            if mag <= distance then
                table.insert(tab, v.Parent.Parent);
            end;
        end;
    end
    return tab;
end;

task.spawn(function()
    repeat
        task.wait(1)
        if cheatenginetrash then
            table.clear(store.pets)
            for i: number, v: Model in workspace.__THINGS.Pets:GetChildren() do
                if tonumber(v.Name) ~= nil then
                    table.insert(store.pets, v); --> gets everyone pet instead!!
                end;
            end;
            continue;
        end;
        table.clear(store.pets);
        for i: string, v: table in store.client.PlayerPet.GetByPlayer() do
            table.insert(store.pets, i);
        end;
    until not vapeInjected;
end)

run(function()
    local autoroll: vapemodule = {Enabled = false};
    autoroll = minigames.Api.CreateOptionsButton({
        Name = 'AutoRoll',
        HoverText = 'Automatically rolls for you',
        Function = function(call: boolean)
            if call then
                repeat
                    replicatedstorage.Network.Eggs_Roll:InvokeServer();
                    task.wait();
                until (not autoroll.Enabled);
            end;
        end;
    });
end);

run(function()
    local autorelic: vapemodule = {Enabled = false};
    autorelic = minigames.Api.CreateOptionsButton({
        Name = 'AutoRelic',
        HoverText = 'Automatically gets all the relics for you',
        Function = function(call: boolean)
            if call then
                for i: number = 1, 100 do
                    replicatedstorage.Network.Relic_Found:InvokeServer(i);
                end;
            end;
        end;
    })
end);

run(function()
    local autofarm: vapemodule = {Enabled = false};
    local autofarmmode: vapedropdown = {Value = 'Multi'};
    local autofarmdistance: vapeslider = {Value = 210};
    autofarm = utility.Api.CreateOptionsButton({
        Name = 'AutoFarm',
        HoverText = 'Automatically farms the breakables for you.',
        Function = function(call: boolean)
            if call then
                if cheatenginetrash then
                    warningNotification('Render', `This feature might work really slowly with {identifyexecutor() or 'cheat engine trash'}`, 7)
                end
                repeat
                    local orb: table = autofarmmode == 'Single' and getorbs(autofarmdistance.Value)[1] or getorbs(autofarmdistance.Value)
                    if type(orb) ~= 'table' and orb then
                        for i: number, v: string in store.pets do
                            replicatedstorage.Network.Breakables_JoinPetBulk:FireServer({
                                [v] = tonumber(orb.Name)
                            });
                        end;
                    elseif type(orb) == 'table' then
                        for i: number, v: Instance in orb do
                            for i2: number, v2: string in store.pets do
                                replicatedstorage.Network.Breakables_JoinPetBulk:FireServer({
                                    [v2] = tonumber(v.Name)
                                });
                            end;
                        end;
                    end;
                    task.wait(cheatenginetrash and 3 or 0.5);
                until not autofarm.Enabled;
            end
        end
    });
    autofarmmode = autofarm.CreateDropdown({
        Name = 'Mode',
        List = {'Single', 'Multi'},
        Function = void
    });
    autofarmdistance = autofarmdistance.CreateSlider({
        Name = 'Distance',
        Min = 1,
        Max = 300,
        Default = 300,
        Function = void
    });
end);

run(function()
    local autocollect: vapemodule = {Enabled = false};
    autocollect = utility.Api.CreateOptionsButton({
        Name = 'AutoCollect',
        HoverText = 'Automatically Collects all coins for you.',
        Function = function(call: boolean)
            store.client.Orb.CollectDistance = call and math.huge or 10;
        end
    });
end);

run(function()
    local autoshoot: vapemodule = {Enabled = false};
    autoshoot = minigames.Api.CreateOptionsButton({
        Name = 'AutoShoot',
        HoverText = 'Automatically shoots the giftboxes for you',
        Function = function(call: boolean)
            if call then
                repeat
                    for i: number, v: Instance in workspace.__THINGS.FlyingGifts:GetChildren() do
                        local attribute: number? = v:FindFirstChild('Giftbox'):GetAttribute('FlyingGiftUID')
                        if attribute then
                            replicatedstorage.Network.FlyingGifts_Claim:FireServer(tonumber(attribute));
                            v:Remove();
                        end;
                    end;
                    task.wait();
                until not autoshoot.Enabled;
            end
        end
    });
end);

run(function()
    local autoconsume: vapemodule = {Enabled = false};
    local autoconsumefruit: vapeminimodule = {Enabled = false};
    local autoconsumepotion: vapeminimodule = {Enabled = false};
    local autoconsumeAmount: vapeslider = {Enabled = 50}
    local autoconsumeSeconds: vapeslider = {Value = 100};
    autoconsume = utility.Api.CreateOptionsButton({
        Name = 'AutoConsume',
        HoverText = 'Automatically shoots the giftboxes for you',
        Function = function(call: boolean)
            if call then
                repeat
                    if autoconsumefruit.Enabled then
                        for i2, v2 in store.consumableids.fruit do     
                            for i,v in v2 do
                                replicatedstorage.Network['Fruits: Consume']:InvokeServer(v, autoconsumeAmount.Value)   
                            end
                        end
                    end
                    task.wait(autoconsumeSeconds.Value)
                until not autoconsume.Enabled;
            end
        end
    });
    autoconsumefruit = autoconsume.CreateToggle({
        Name = 'Fruit',
        Function = void
    })
    autoconsumepotion = autoconsume.CreateToggle({
        Name = 'Potion',
        Function = void
    })
    autoconsumeAmount = autoconsume.CreateSlider({
        Name = 'Amount',
        Min = 1,
        Max = 500,
        Default = 50,
        Function = void
    })
    autoconsumeSeconds = autoconsume.CreateSlider({
        Name = 'Seconds',
        Min = 1,
        Max = 500,
        Default = 50,
        Function = void
    })
end);

run(function()
    local autofruit: vapemodule = {Enabled = false};
    autofruit = utility.Api.CreateOptionsButton({
        Name = 'AutoFruit',
        HoverText = 'Automatically collects fruits around the world.',
        Function = function(call: boolean)
            if call then
                repeat
                    for i: number, v: Instance in workspace.__THINGS.Breakables:GetChildren() do
                        if v:FindFirstChild('base') then
                            local interest: TouchTransmitter? = v.base.Hitbox:FindFirstChild('TouchInterest')
                            if interest then
                                pcall(firetouchinterest, v.base.Hitbox, interest, false)
                            end
                        end
                    end
                    task.wait()
                until not autofruit.Enabled;
            end
        end
    });
end);

run(function()
    local autogift: vapemodule = {Enabled = false};
    autogift = utility.Api.CreateOptionsButton({
        Name = 'AutoGift',
        HoverText = 'Automatically collects gifts around the world.',
        Function = function(call: boolean)
            if call then
                repeat
                    for i: number, v: TouchTransmitter? in workspace.__THINGS.HiddenGifts:GetDescendants() do
                        if v.Name == 'TouchInterest' then
                            pcall(firetouchinterest, v.Parent, v, false)
                        end
                    end
                    task.wait()
                until not autogift.Enabled;
            end
        end
    });
end)

run(function()
    local automerchant: vapemodule = {Enabled = false};
    automerchant = utility.Api.CreateOptionsButton({
        Name = 'AutoMerchant',
        HoverText = 'Automatically buys everything that the merchant sells.',
        Function = function(call: boolean)
            if call then
                repeat
                    for _: number = 1, 20 do
                        replicatedstorage.Network.CustomMerchants_Purchase:InvokeServer('StandardMerchant', _)          
                    end      
                    task.wait(5)
                until (not automerchant.Enabled)
            end
        end
    });
end);
run(function()
    local autobuy: vapemodule = {Enabled = false};
    autobuy = utility.Api.CreateOptionsButton({
        Name = 'AutoBuy',
        Function = function(call: boolean)
            if call then
                repeat
                    replicatedstorage.Network.VendingMachines_Purchase:InvokeServer('PotionVendingMachine');
                    task.wait(1)
                until (not autobuy.Enabled)
            end
        end
    });
end)

run(function()
    local replicesp: vapemodule = {Enabled = false};
    replicesp = visual.Api.CreateOptionsButton({
        Name = 'RelicESP',
        Function = function(call: boolean)
            if call then
                for i: number, v: Instance in workspace.__THINGS.Relics:GetChildren() do
                    if v.Name == 'Relic' then
                        local highlight: Highlight = Instance.new('Highlight', v);
                        highlight.FillColor = Color3.fromRGB(255, 0, 0);
                        highlight.FillTransparency = 0.3;
                    end;
                end;
            end;
        end
    });
end)
run(function()
    
end)
run(function()
    local autodig: vapemodule = {Enabled = false};
    local pathchecking: () -> () = function(newpath: any, Position: Vector3): (boolean?)
        local suc, res = pcall(function()
            return newpath:ComputeAsync(lplr.Character.HumanoidRootPart.Position, Position);
        end)
        if suc then
            return true;
        else
            error(res, 8);
        end;
    end;
    autodig = minigames.Api.CreateOptionsButton({
        Name = 'AutoDig',
        Function = function(call: boolean)
            if call then
                repeat
                    local digpart: Part? = workspace.__THINGS.Digging:FindFirstChild('DigPart');
                    if digpart then
                        local newpath: any = pathfinding:CreatePath();
                        if pathchecking(newpath, digpart.Position) then
                            for i: number, v: table in newpath:GetWaypoints() do
                                lplr.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position);
                            end;
                        end;
                    end;
                    task.wait(1);
                until (not autodig.Enabled);
            end
        end
    });
end)

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
        'PlayerAttach',
        'Swim'
    };
    for i: number, v: string in uselessmodules do 
        rendervape.RemoveObject(`{v}OptionsButton`);
    end;

    repeat task.wait() until shared.VapeFullyLoaded;
    rendervape.RemoveObject('CombatWindow');
end);