local num = 1
while true do
    local event, key = os.pullEvent('key')
    print(num .. ' - ' .. keys.getName(key))
    num = num + 1
end
