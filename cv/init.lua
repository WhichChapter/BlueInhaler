--!nocheck
-- Catsix offline bootstrap. No CatVape server requests are made here.

local Directory = "catsix"

for _, Folder in {Directory, `${Directory}/games`, `${Directory}/profiles`, `${Directory}/assets`, `${Directory}/libraries`, `${Directory}/gui`} do
    if not isfolder(Folder) then
        makefolder(Folder)
    end
end

local MainPath = `${Directory}/main.lua`
if not isfile(MainPath) then
    error(`Catsix offline install is incomplete: missing ${MainPath}`)
end

local MainChunk, MainError = loadstring(readfile(MainPath), "main")
if not MainChunk then
    error(`Catsix failed to compile main.lua: ${MainError}`)
end

return MainChunk({})
