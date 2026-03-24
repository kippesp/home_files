-- "go <bookmark>" command for quick directory navigation.

local HOME = os.getenv("USERPROFILE")

local BOOKMARKS = {
    downloads = HOME .. "\\Downloads",
}

-- Merge bookmarks from ~/.clink.local/go_bookmarks.lua if it exists.
local clink_local = os.getenv("CLINK_PATH")
if clink_local then
    local f = loadfile(clink_local .. "\\go_bookmarks.lua")
    if f then
        local extra = f()
        if extra then
            for name, path in pairs(extra) do
                BOOKMARKS[name] = path
            end
        end
    end
end

local function go_handler(text)
    local trimmed = text:match("^%s*(.-)%s*$")
    if trimmed == "go" then
        print("Usage: go <bookmark>")
        print("Bookmarks:")
        for name, path in pairs(BOOKMARKS) do
            print("  " .. name .. " -> " .. path)
        end
        return "", false
    end
    local arg = trimmed:match("^go%s+(.+)$")
    if arg then
        arg = arg:match("^%s*(.-)%s*$"):lower()
        local path = BOOKMARKS[arg]
        if path then
            return "cd /d \"" .. path .. "\"", false
        else
            print("Unknown bookmark: " .. arg)
            return "", false
        end
    end
end

if clink.onfilterinput then
    clink.onfilterinput(go_handler)
else
    clink.onendedit(go_handler)
end

-- Tab completion for "go" (derived from BOOKMARKS keys).
local bookmark_names = {}
for name, _ in pairs(BOOKMARKS) do
    table.insert(bookmark_names, name)
end
local go_matcher = clink.argmatcher("go")
go_matcher:addarg(bookmark_names)
