local p = clink.promptfilter(30)
function p:filter(prompt)
    return os.getcwd().."\n> "
end
