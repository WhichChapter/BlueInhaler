-- Blue Inhaler bootstrap installer
-- Uses cached Lua files when available; downloads missing files from GitHub.

local Directory = "inhalerone"
local BaseURL = "https://raw.githubusercontent.com/WhichChapter/BlueInhaler/main/"

local Files = {
    "games/106431012459431.lua",
    "games/115875349872417.lua",
    "games/122425529900803.lua",
    "games/123804558118054.lua",
    "games/126691165749976.lua",
    "games/126987974021910.lua",
    "games/131465939650733.lua",
    "games/13246639586.lua",
    "games/132768098780837.lua",
    "games/135564683255158.lua",
    "games/139566161526375.lua",
    "games/155615604.lua",
    "games/16483433878.lua",
    "games/17164617414.lua",
    "games/1962086868.lua",
    "games/4468711919.lua",
    "games/5253186791.lua",
    "games/5938036553.lua",
    "games/606849621.lua",
    "games/6872265039.lua",
    "games/6872274481.lua",
    "games/77790193039862.lua",
    "games/80041634734121.lua",
    "games/83413351472244.lua",
    "games/8444591321.lua",
    "games/8542259458.lua",
    "games/8542275097.lua",
    "games/8560631822.lua",
    "games/8592115909.lua",
    "games/8768229691.lua",
    "games/893973440.lua",
    "games/8951451142.lua",
    "games/94987506187454.lua",
    "games/universal.lua",
    "gui/new.lua",
    "init.lua",
    "libraries/assistant.lua",
    "libraries/cheatengine.lua",
    "libraries/communication.lua",
    "libraries/drawing.lua",
    "libraries/entity.lua",
    "libraries/hash.lua",
    "libraries/main.lua",
    "libraries/navigation.lua",
    "libraries/prediction.lua",
    "libraries/render.lua",
    "libraries/replay.lua",
    "libraries/swordtiming.lua",
    "libraries/vm.lua",
    "main.lua",
}

local function EnsureFolder(path)
    if isfolder and isfolder(path) then
        return
    end

    if makefolder then
        pcall(makefolder, path)
    end
end

local function EnsureParentFolders(path)
    local current = Directory
    EnsureFolder(current)

    for part in string.gmatch(path, "[^/]+") do
        if not part:match("%.%w+$") then
            current = current .. "/" .. part
            EnsureFolder(current)
        end
    end
end

local function GetURL(url)
    local ok, result = pcall(function()
        return game:HttpGet(url)
    end)

    if ok and type(result) == "string" and result ~= "" then
        return result
    end

    local requestFunction = request or http_request or (syn and syn.request)

    if requestFunction then
        local response = requestFunction({
            Url = url,
            Method = "GET"
        })

        if response
            and response.StatusCode == 200
            and type(response.Body) == "string"
            and response.Body ~= ""
        then
            return response.Body
        end

        error("HTTP request failed: " .. tostring(response and response.StatusCode))
    end

    error("No supported HTTP request function is available: " .. tostring(result))
end

if not writefile or not readfile or not loadstring then
    error("Blue Inhaler installer requires writefile, readfile and loadstring")
end

EnsureFolder(Directory)

local downloaded = 0
local cached = 0

for _, path in ipairs(Files) do
    EnsureParentFolders(path)

    local destination = Directory .. "/" .. path
    local fileExists = false

    -- Check whether the file is already stored locally.
    if isfile then
        local existsOk, existsResult = pcall(isfile, destination)
        fileExists = existsOk and existsResult == true
    end

    if fileExists then
        -- Keep using the existing local copy.
        cached = cached + 1
        print("[Blue Inhaler] Using cached file: " .. path)
    else
        -- Download only when the local file is missing.
        local ok, contents = pcall(GetURL, BaseURL .. path)

        if not ok or type(contents) ~= "string" or contents == "" then
            error(
                "Blue Inhaler download failed for "
                .. path
                .. ": "
                .. tostring(contents)
            )
        end

        local writeOk, writeError = pcall(writefile, destination, contents)

        if not writeOk then
            error(
                "Blue Inhaler could not save "
                .. destination
                .. ": "
                .. tostring(writeError)
            )
        end

        downloaded = downloaded + 1
        print("[Blue Inhaler] Downloaded: " .. path)
    end
end

-- Load main.lua from the local filesystem.
local mainPath = Directory .. "/main.lua"
local mainContents = readfile(mainPath)

local chunk, compileError = loadstring(mainContents, "main")

if not chunk then
    error(
        "Blue Inhaler main.lua failed to compile: "
        .. tostring(compileError)
    )
end

print(
    "[Blue Inhaler] Ready. Cached: "
    .. tostring(cached)
    .. " | Downloaded: "
    .. tostring(downloaded)
)

return chunk({})
