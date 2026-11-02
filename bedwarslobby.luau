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
   games/6872265039.luau (Bedwars lobby) - SystemXVoid/Blankedvoid & MaxlaserTech     
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
local rendervape: vapemain = vape;
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
	__index = function(self, index)
		self[index] = Instance.new('BindableEvent')
		return self[index]
	end
});
local vapeTargetInfo: table = shared.VapeTargetInfo;
local vapeInjected: boolean = true;
local bedwars: table = {};

local cheatenginetrash = cheatenginetrash or false;
local require = require;

run(function()
	local knitgotten, knitclient
    for i = 1, 5 do 
		knitgotten, knitclient = pcall(function()
			return debug.getupvalue(require(lplr.PlayerScripts.TS.knit).setup, 6)
		end);
		if knitclient then 
			break;
		else
			task.wait(0.1)
		end
	end;
    if not knitgotten then
        cheatenginetrash = true;
        require = function(): () -> (table)
            return {};
        end;
    end;

    local flamework: table = ({pcall(function() return require(replicatedstorage['rbxts_include']['node_modules']['@flamework'].core.out).Flamework end)})[2];
    local client: table = ({pcall(function() return require(replicatedstorage.TS.remotes).default.Client end)})[2];

    repeat task.wait() until flamework.isInitialized or cheatenginetrash;

    bedwars = setmetatable({
        bedwarskits = require(replicatedstorage.TS.games.bedwars.kit['bedwars-kit-shop']).BedwarsKitShop,
        Client = client,
        clientstore = require(lplr.PlayerScripts.TS.ui.store).ClientStore,
        emoteMeta = require(replicatedstorage.TS.locker.emote['emote-meta']).EmoteMeta,
        queryUtil = require(replicatedstorage['rbxts_include']['node_modules']['@easy-games']['game-core'].out).GameQueryUtil,
        kitMeta = require(replicatedstorage.TS.games.bedwars.kit['bedwars-kit-meta']).BedwarsKitMeta,
        lobbyclient = knitclient.Controllers.QueueController,
        sprintTable = knitclient.Controllers.SprintController,
        weldTable = require(replicatedstorage.TS.util['weld-util']).WeldUtil,
        queueMeta = require(replicatedstorage.TS.game['queue-meta']).QueueMeta,
        getEntityTable = require(replicatedstorage.TS.entity['entity-util']).EntityUtil,
    }, {})
end);

for i: number, v: {string} in {'SilentAim', 'AutoClicker', 'Reach', 'ClientKickDisabler', 'MouseTP', 'Killaura', 'TriggerBot', 'SafeWalk', 'LongJump'} do
    rendervape.RemoveObject(`{v}OptionsButton`);
end;

run(function()
    local sprint: vapemodule = {Enabled = false};
    local oldconstructor;
    sprint = rendervape.objects.CombatWindow.Api.CreateOptionsButton({
        Name = 'Sprint',
        HoverText = 'Sets your sprinting to true.',
        Function = function(call: bool): (bool) -> ()
            if call then
                oldconstructor = getmetatable(bedwars.sprintTable).stopSprinting;
                getmetatable(bedwars.sprintTable).stopSprinting = function() end;
                getmetatable(bedwars.sprintTable).startSprinting(bedwars.sprintTable);
            else
                getmetatable(bedwars.sprintTable).stopSprinting = oldconstructor;
            end;
        end
    });
end)

run(function()
    local autoqueue: vapemodule = {Enabled = false};
    local autoqueuemode: vapedropdown = {Value = 'Squad'};
    autoqueue = rendervape.objects.UtilityWindow.Api.CreateOptionsButton({
        Name = 'AutoQueue',
        HoverText = 'Automatically queues you to a selected mode.',
        Function = function(call: bool): (bool) -> ()
            if call then
                repeat
                    if autoqueue.Enabled then break end;
                    if autoqueuemode.Value ~= '' then
                        if bedwars.clientstore:getState().Party.queueState > 0 then
                            bedwars.lobbyclient:leaveQueue();
                        end;
                        bedwars.lobbyclient:joinQueue(autoqueuemode.Value);
                        repeat task.wait() until bedwars.clientstore:getState().Party.queueState == 3;
                    end;
                    task.wait()
                until not autoqueue.Enabled;
            end;
        end
    })
	local list = {}
	for i: number, v: table in bedwars.queueMeta do
		if v.title:find("Test") == nil then
			table.insert(list, v.title..(i:find('voice') and ' (VOICE)' or ''))
		end
	end
    autoqueuemode = autoqueue.CreateDropdown({
        Name = 'Mode',
        Function = void,
        List = list
    })
end);


run(function()
	local playerThreads: securetable = Performance.new();
	renderconnections[#renderconnections + 1] = RenderLibrary.runtime.events.PlayerTagCreated:Connect(function(player: Player, text: string, hex: string)
		pcall(task.cancel, playerThreads[player]);
		playerThreads[player] = task.spawn(function()
			repeat 
				pcall(function()
					player.Character.Head.Nametag.DisplayNameContainer.DisplayName.Text = "<font color='#"..hex.."'>["..text.."] </font> " ..player.DisplayName;
				end)
				task.wait()
			until (not getgenv().render)
		end);
	end);

	renderconnections[#renderconnections + 1] = RenderLibrary.runtime.events.PlayerTagRemoved:Connect(function(player: Player, text: string, hex: string)
		pcall(function()
			player.Character.Head.Nametag.DisplayNameContainer.DisplayName.Text = player.DisplayName;
		end);
		pcall(task.cancel, playerThreads[player]);
	end);

	playerThreads.oncleanevent:Connect(function(loop: thread)
		pcall(task.cancel, loop)
	end)
end);

run(function()
	local HotbarVisuals = {};
	local HotbarRounding = {};
	local HotbarHighlight = {};
	local HotbarColorToggle = {};
	local HotbarHideSlotIcons = {};
	local HotbarSlotNumberColorToggle = {};
	local HotbarSpacing = {Value = 0};
	local HotbarInvisibility = {Value = 4};
	local HotbarRoundRadius = {Value = 8};
	local HotbarColor = {};
	local HotbarHighlightColor = {};
	local HotbarSlotNumberColor = {};
	local hotbarcoloricons = Performance.new();
	local hotbarsloticons = Performance.new();
	local hotbarobjects = Performance.new();
	local HotbarVisualsGradient = {};
	local hotbarslotgradients = Performance.new();
	local HotbarVisualsGradientColor = {};
	local HotbarVisualsGradientColor2 = {};
	local inventoryiconobj;
	local function hotbarFunction()
		local inventoryicons = ({pcall(function() return lplr.PlayerGui.hotbar['1'].ItemsHotbar end)})[2]
		if inventoryicons and type(inventoryicons) == 'userdata' then
			inventoryiconobj = inventoryicons;
			pcall(function() inventoryicons:FindFirstChildOfClass('UIListLayout').Padding = UDim.new(0, HotbarSpacing.Value) end);
			for i,v in inventoryicons:GetChildren() do 
				local sloticon = ({pcall(function() return v:FindFirstChildWhichIsA('ImageButton'):FindFirstChildWhichIsA('TextLabel') end)})[2]
				if type(sloticon) ~= 'userdata' then 
					continue
				end
				table.insert(hotbarcoloricons, sloticon.Parent);
				sloticon.Parent.Transparency = (0.1 * HotbarInvisibility.Value);
				if HotbarColorToggle.Enabled and not HotbarVisualsGradient.Enabled then 
					sloticon.Parent.BackgroundColor3 = Color3.fromHSV(HotbarColor.Hue, HotbarColor.Sat, HotbarColor.Value)
				end
				if HotbarVisualsGradient.Enabled then 
					sloticon.Parent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					if sloticon.Parent:FindFirstChildWhichIsA('UIGradient') == nil then 
						local gradient = Instance.new('UIGradient') 
						local color = Color3.fromHSV(HotbarVisualsGradientColor.Hue, HotbarVisualsGradientColor.Sat, HotbarVisualsGradientColor.Value)
						local color2 = Color3.fromHSV(HotbarVisualsGradientColor2.Hue, HotbarVisualsGradientColor2.Sat, HotbarVisualsGradientColor2.Value)
						gradient.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, color), ColorSequenceKeypoint.new(1, color2)})
						gradient.Parent = sloticon.Parent
						table.insert(hotbarslotgradients, gradient)
						table.insert(hotbarcoloricons, sloticon.Parent) 
					end
				end
				if HotbarRounding.Enabled then 
					local uicorner = Instance.new('UICorner')
					uicorner.Parent = sloticon.Parent
					uicorner.CornerRadius = UDim.new(0, HotbarRoundRadius.Value)
					table.insert(hotbarobjects, uicorner)
				end
				if HotbarHighlight.Enabled then
					local highlight = Instance.new('UIStroke')
					highlight.Color = Color3.fromHSV(HotbarHighlightColor.Hue, HotbarHighlightColor.Sat, HotbarHighlightColor.Value)
					highlight.Thickness = 1.3 
					highlight.Parent = sloticon.Parent
					table.insert(hotbarobjects, highlight)
				end
				if HotbarHideSlotIcons.Enabled then 
					sloticon.Visible = false 
				end
				table.insert(hotbarsloticons, sloticon)
			end 
		end
	end
	HotbarVisuals = vape.objects.RenderWindow.Api.CreateOptionsButton({
		Name = 'HotbarVisuals',
		HoverText = 'Add customization to your hotbar.',
		Function = function(calling)
			if calling then 
				task.spawn(function()
					table.insert(HotbarVisuals.Connections, lplr.PlayerGui.DescendantAdded:Connect(function(v)
						if v.Name == 'hotbar' then
							hotbarFunction()
						end
					end))
					hotbarFunction()
				end)
				table.insert(HotbarVisuals.Connections, runservice.RenderStepped:Connect(function()
					for i,v in hotbarcoloricons do 
						pcall(function() v.Transparency = (0.1 * HotbarInvisibility.Value) end); 
					end	
				end))
			else
				for i,v in hotbarsloticons do 
					pcall(function() v.Visible = true end)
				end
				for i,v in hotbarcoloricons do 
					pcall(function() v.BackgroundColor3 = Color3.fromRGB(29, 36, 46) end)
				end
				for i,v in hotbarobjects do
					pcall(function() v:Destroy() end)
				end
				for i,v in hotbarslotgradients do 
					pcall(function() v:Destroy() end)
				end
				table.clear(hotbarobjects)
				table.clear(hotbarsloticons)
				table.clear(hotbarcoloricons)
			end
		end
	})
	HotbarColorToggle = HotbarVisuals.CreateToggle({
		Name = 'Slot Color',
		Function = function(calling)
			pcall(function() HotbarColor.Object.Visible = calling end)
			pcall(function() HotbarColorToggle.Object.Visible = calling end)
			if HotbarVisuals.Enabled then 
				HotbarVisuals.ToggleButton(false)
				HotbarVisuals.ToggleButton(false)
			end
		end
	})
	HotbarVisualsGradient = HotbarVisuals.CreateToggle({
		Name = 'Gradient Slot Color',
		Function = function(calling)
			pcall(function() HotbarVisualsGradientColor.Object.Visible = calling end)
			pcall(function() HotbarVisualsGradientColor2.Object.Visible = calling end)
			if HotbarVisuals.Enabled then 
				HotbarVisuals.ToggleButton(false)
				HotbarVisuals.ToggleButton(false)
			end
		end
	})
	HotbarVisualsGradientColor = HotbarVisuals.CreateColorSlider({
		Name = 'Gradient Color',
		Function = function(h, s, v)
			for i,v in hotbarslotgradients do 
				pcall(function() v.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(HotbarVisualsGradientColor.Hue, HotbarVisualsGradientColor.Sat, HotbarVisualsGradientColor.Value)), ColorSequenceKeypoint.new(1, Color3.fromHSV(HotbarVisualsGradientColor2.Hue, HotbarVisualsGradientColor2.Sat, HotbarVisualsGradientColor2.Value))}) end)
			end
		end
	})
	HotbarVisualsGradientColor2 = HotbarVisuals.CreateColorSlider({
		Name = 'Gradient Color 2',
		Function = function(h, s, v)
			for i,v in hotbarslotgradients do 
				pcall(function() v.Color = ColorSequence.new({ColorSequenceKeypoint.new(0, Color3.fromHSV(HotbarVisualsGradientColor.Hue, HotbarVisualsGradientColor.Sat, HotbarVisualsGradientColor.Value)), ColorSequenceKeypoint.new(1, Color3.fromHSV(HotbarVisualsGradientColor2.Hue, HotbarVisualsGradientColor2.Sat, HotbarVisualsGradientColor2.Value))}) end)
			end
		end
	})
	HotbarColor = HotbarVisuals.CreateColorSlider({
		Name = 'Slot Color',
		Function = function(h, s, v)
			for i,v in hotbarcoloricons do
				if HotbarColorToggle.Enabled then
					pcall(function() v.BackgroundColor3 = Color3.fromHSV(HotbarColor.Hue, HotbarColor.Sat, HotbarColor.Value) end) -- for some reason the 'h, s, v' didn't work :(
				end
			end
		end
	})
	HotbarRounding = HotbarVisuals.CreateToggle({
		Name = 'Rounding',
		Function = function(calling)
			pcall(function() HotbarRoundRadius.Object.Visible = calling end)
			if HotbarVisuals.Enabled then 
				HotbarVisuals.ToggleButton(false)
				HotbarVisuals.ToggleButton(false)
			end
		end
	})
	HotbarRoundRadius = HotbarVisuals.CreateSlider({
		Name = 'Corner Radius',
		Min = 1,
		Max = 20,
		Function = function(calling)
			for i,v in hotbarobjects do 
				pcall(function() v.CornerRadius = UDim.new(0, calling) end)
			end
		end
	})
	HotbarHighlight = HotbarVisuals.CreateToggle({
		Name = 'Outline Highlight',
		Function = function(calling)
			pcall(function() HotbarHighlightColor.Object.Visible = calling end)
			if HotbarVisuals.Enabled then 
				HotbarVisuals.ToggleButton(false)
				HotbarVisuals.ToggleButton(false)
			end
		end
	})
	HotbarHighlightColor = HotbarVisuals.CreateColorSlider({
		Name = 'Highlight Color',
		Function = function(h, s, v)
			for i,v in hotbarobjects do 
				if v:IsA('UIStroke') and HotbarHighlight.Enabled then 
					pcall(function() v.Color = Color3.fromHSV(HotbarHighlightColor.Hue, HotbarHighlightColor.Sat, HotbarHighlightColor.Value) end)
				end
			end
		end
	})
	HotbarHideSlotIcons = HotbarVisuals.CreateToggle({
		Name = 'No Slot Numbers',
		Function = function()
			if HotbarVisuals.Enabled then 
				HotbarVisuals.ToggleButton(false)
				HotbarVisuals.ToggleButton(false)
			end
		end
	})
	HotbarInvisibility = HotbarVisuals.CreateSlider({
		Name = 'Invisibility',
		Min = 0,
		Max = 10,
		Default = 4,
		Function = function(value)
			for i,v in hotbarcoloricons do 
				pcall(function() v.Transparency = (0.1 * value) end); 
			end
		end
	})
	HotbarSpacing = HotbarVisuals.CreateSlider({
		Name = 'Spacing',
		Min = 0,
		Max = 5,
		Function = function(value)
			if HotbarVisuals.Enabled then 
				pcall(function() inventoryiconobj:FindFirstChildOfClass('UIListLayout').Padding = UDim.new(0, value) end)
			end
		end
	})
	HotbarColor.Object.Visible = false
	HotbarRoundRadius.Object.Visible = false
	HotbarHighlightColor.Object.Visible = false
end);

run(function()
	local autogamble: vapemodule = {Enabled = false};
	local autogamblenotify: vapeminimodule = {Enabled = false};
	local autogamblethread: thread;
	local autogambleids: table = {};
	autogamble = vape.objects.InventoryWindow.Api.CreateOptionsButton({
		Name = 'AutoGamble',
		Function = function(call: boolean)
			if call then
				autogamblethread = task.spawn(function()
					repeat
						task.wait(0.5);
						for i: number = 0, 1 do
							replicatedstorage.rbxts_include.node_modules['@rbxts'].net.out._NetManaged['RewardCrate/SpawnRewardCrate']:FireServer({
								crateType = 'level_up_crate',
								altarId = i
							})
							local model: Model? = workspace[`CrateAltar_{i}`]:FindFirstChildWhichIsA('Model')
							if model then
								replicatedstorage.rbxts_include.node_modules['@rbxts'].net.out._NetManaged['RewardCrate/OpenRewardCrate']:FireServer({
									crateId = model:GetAttribute('crateId')
								});
								model:Remove();
							end;
						end;
					until not autogamble.Enabled;
				end);
				table.insert(autogamble.Connections, workspace.DescendantAdded:Connect(function(v: Instance): ()
					if autogamblenotify.Enabled and v.Name == 'CrateRewardTitle' then
						warningNotification('AutoGamble', `You got {v['1']['1'].Text} from the crate!`, 7);
					end;
				end));
			else
				pcall(task.cancel, autogamblethread)
			end;
		end
	});
	autogamblenotify = autogamble.CreateToggle({
		Name = 'Notify',
		HoverText = 'Notifys which item did u get from gambling',
		Function = void
	});
end);
