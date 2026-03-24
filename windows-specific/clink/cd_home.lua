-- "cd" with no args goes to %USERPROFILE% (Unix behavior).

local function cd_home(text)
    local trimmed = text:match("^%s*(.-)%s*$")
    if trimmed == "cd" then
        return "cd /d \"" .. os.getenv("USERPROFILE") .. "\"", false
    end
end

if clink.onfilterinput then
    clink.onfilterinput(cd_home)
else
    clink.onendedit(cd_home)
end
