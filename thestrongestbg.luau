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
   CustomModules/10449761463.luau (The Strongest battleground) - MaxlaserTech & YZFloppa.
   
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

local vape: vapemain = gui;
local rendervape: vapemain = gui;
 
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
local vapeEvents: table = setmetatable({}, {
	__index = function(self: table, index: string): (table, string) -> (BindableEvent)
		self[index] = Instance.new('BindableEvent');
		return self[index];
	end;
});
local vapeTargetInfo: table = shared.VapeTargetInfo;
local vapeInjected: boolean = true;

local store: table = setmetatable({},
{
    __index = function(self: table, index: string): (table, string) -> ()
        return index == 'animcontroller' and {
            ['Bald'] = {
                ['Normal Punch'] = 'rbxassetid://10468665991';
                ['Consecutive Punches'] = 'rbxassetid://10466974800';
                ['Shove'] = 'rbxassetid://10471336737';
                ['Uppercut'] = 'rbxassetid://112510170988';
                ['Ultimate'] = {
                    ['Deathcounter'] = 'rbxassetid://1';
                    ['TableFlip'] = 'rbxassetid://1';
                    ['SeriousPunch'] = 'rbxassetid://1';
                    ['DirectionalPunch'] = 'rbxassetid://1';
                };
            };
            ['Hunter'] = {
                ['Flowing Water'] = 'rbxassetid://12272894215';
                ['Lethal Whirlwind Stream'] = 'rbxassetid://12296882427';
                ['Hunter\'s Gasp'] = 'rbxassetid://12307656616';
                ['Prey\'s Peril'] = 'rbxassetid://12351854556';
                ['Ultimate'] = {
                    ['RockSmashing'] = 'rbxassetid://1';
                    ['FinalHunt'] = 'rbxassetid://1';
                    ['RockFist'] = 'rbxassetid://1';
                    ['CrushedRock'] = 'rbxassetid://1';
                };
            };
            ['Cyborg'] = {
                ['Machine Gun Blows'] = 'rbxassetid://12534735382';
                ['Ignition Burst'] = {
                    ['Coming'] = 'rbxassetid://12502664044';
                    ['BurstFire'] = 'rbxassetid://12509505723';
                };
                ['Blitz Shot'] = {
                    ['Idle'] = 'rbxassetid://12618271998';
                    ['Shot'] = 'rbxassetid://12618292188';
                };
                ['Jet Dive'] = {
                    ['Air'] = 'rbxassetid://12684390285';
                    ['Down'] = 'rbxassetid://12684185971';
                };
                ['Ultimate'] = {
                    ['ThunderKick'] = 'rbxassetid://1';
                    ['Dropkick'] = 'rbxassetid://1';
                    ['FlameCannon'] = 'rbxassetid://1';
                    ['Incinerate'] = 'rbxassetid://1';
                };
            };
            ['Ninja'] = {
                ['Flash Strike'] = 'rbxassetid://13376869471';
                ['Whirlwind Kick'] = 'rbxassetid://13294790250';
                ['Scatter'] = 'rbxassetid://13376962659';
                ['Explosive Shuriken'] = 'rbxassetid://13501296372';
                ['Ultimate'] = {
                    ['Rush'] = 'rbxassetid://1';
                    ['Straight'] = 'rbxassetid://1';
                    ['Carnage'] = 'rbxassetid://1';
                    ['FlashStrike'] = 'rbxassetid://1';
                };
            };
            ['Batter'] = {
                ['Homerun'] = 'rbxassetid://14003607057';
                ['Beatdown'] = 'rbxassetid://14046756619';
                ['GrandSlam'] = 'rbxassetid://14299135500';
                ['FourBall'] = 'rbxassetid://14351441234';
                ['Ultimate'] = {
                    ['Tornado'] = 'rbxassetid://1';
                    ['Beatdown'] = 'rbxassetid://1';
                    ['StrengthDiff'] = 'rbxassetid://1';
                    ['DeathBlow'] = 'rbxassetid://1';
                };
            };
            ['Blade'] = {
                ['Quick Slice'] = 'rbxassetid://15290930205';
                ['Atmos Cleave'] = 'rbxassetid://15145462680';
                ['Pinpoint Cut'] = 'rbxassetid://15295895753';
                ['Split Second Counter'] = 'rbxassetid://15311685628';
                ['Ultimate'] = {
                    ['Sunset'] = 'rbxassetid://1';
                    ['Cleave'] = 'rbxassetid://1';
                    ['Sunrise'] = 'rbxassetid://1';
                    ['Slash'] = 'rbxassetid://1';
                };
            };
        } or lplr:GetAttribute('Character');
    end;
});

--> autoblock init
loadstring(game:HttpGet('https://raw.githubusercontent.com/YZFloppa/YZFloppa/refs/heads/main/auto%20block.lua', true))();

getgenv().Settings.Autoparry.Toggle = false;

run(function()
    local aimassist: vapemodule = {Enabled = false};
    local aimassistrange: vapeslider = {Value = 5};
    local aimassistblock: vapeminimodule = {Enabled = false};
    aimassist = vape.objects.CombatWindow.Api.CreateOptionsButton({
        Name = 'AimAssist',
        HoverText = 'Automatically changes ur camera cframe when someone\n tries to attack you.',
        Function = function(call: bool): ()
            if call then
                getgenv().Settings.Autoparry.Fov = 360;
                repeat
                    local target: Model? = getgenv().Settings.Autoparry.enemy
                    if target and isAlive(players[target.Name]) then
                        if (lplr.Character.HumanoidRootPart.Position - target.HumanoidRootPart.Position).magnitude <= 13 then
                            for _: number = 1, 10 do camera.CFrame = CFrame.new(camera.CFrame.p, (target.HumanoidRootPart.Position - Vector3.new(0, 5, 0))); end;
                            getgenv().Settings.Autoparry.enemy = nil;
                        end;
                    end;
                    task.wait();
                until not aimassist.Enabled;
            end;
        end
    });
    aimassistblock = aimassist.CreateToggle({
        Name = 'AutoBlock',
        Function = function(call: bool): ()
            getgenv().Settings.Autoparry.Toggle = call;
        end
    });
    aimassistrange = aimassist.CreateSlider({
        Name = 'Range',
        Min = 1,
        Max = 30,
        Default = 20,
        Function = function(val: number): ()
            getgenv().Settings.Autoparry.Range = val;
        end;
    });
end);

run(function()
    local fakeability: vapemodule = {Enabled = false};
    local createanimation = function(animId: string): (string) -> (Animation)
        local anim: Animation = Instance.new('Animation');
        anim.AnimationId = animId;
        return anim;
    end;
    fakeability = vape.objects.ExploitWindow.Api.CreateOptionsButton({
        Name = 'FakeAbility',
        HoverText = 'Plays the ability while it\'s not usable\n (This deals zero damage)',
        Function = void
    });
    local abilityhook: (any, ...any) -> (...any) abilityhook = hookmetamethod(game, '__namecall', newcclosure(function(self: any, ...): (...any)
        local args: {string?} = {...};
        if fakeability.Enabled and getnamecallmethod() == 'FireServer' and tostring(self) == 'Communicate' and args[1].ToolName then
            task.spawn(function()
                lplr.Character.Humanoid.Animator:LoadAnimation(createanimation(store.animcontroller[store.char][args[1].ToolName])):Play();
            end);
        end;
        return abilityhook(self, ...);
    end));
end);

run(function()
    local nostun: vapemodule = {Enabled = false};
    local stuntypes: {string} = {'Freeze', 'RagdollSim', 'Ragdoll', 'RootAnchor', 'Small Debris', 'BeingGrabbed', 'NoRotate'};
    nostun = vape.objects.UtilityWindow.Api.CreateOptionsButton({
        Name = 'AntiStun',
        HoverText = 'Prevents you from getting stunned by attacks.',
        Function = function(call: bool): () -> ()
            if call then
                if isAlive(lplr, true) then
                    table.insert(nostun.Connections, lplr.Character.ChildAdded:Connect(function(v: Instance): ()
                        if table.find(stuntypes, v.Name) then
                            v:Remove();
                        end;
                    end));
                    table.insert(nostun.Connections, lplr.Character.PrimaryPart:GetPropertyChangedSignal('Anchored'):Connect(function()
                        lplr.Character.PrimaryPart.Anchored = false;
                    end))
                end;
                table.insert(nostun.Connections, lplr.CharacterAdded:Connect(function()
                    table.insert(nostun.Connections, lplr.Character.ChildAdded:Connect(function(v: Instance): ()
                        if table.find(stuntypes, v.Name) then
                            v:Remove();
                        end;
                    end));
                    table.insert(nostun.Connections, lplr.Character.PrimaryPart:GetPropertyChangedSignal('Anchored'):Connect(function()
                        lplr.Character.PrimaryPart.Anchored = false;
                    end))
                end));
            end;
        end
    })
end)