local p = clink.promptfilter(30)
function p:filter(prompt)
    -- Reset kitty keyboard protocol (drains the push stack).
    -- Fixes garbled input after apps that enable CSI u mode.
    io.write("\x1b[<10u")
    return os.getcwd().."\n> "
end
