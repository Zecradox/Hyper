-- Priority Multitasking Kernel
-- Hyper Operating System
--
-- If you use the method that Priority
-- Multitasking uses for multitasking,
-- please credit me.
--
-- [ *********************************** ] --
--    Written by Zecradox
-- [ *********************************** ] --

math.randomseed(os.time())
local tsx, tsy = term.getSize()
local tasks = {}
local windows = {}
local bar_top = window.create(term.current(), 1, 1, tsx, 1)
local bar_bottom = window.create(term.current(), 1, tsy, tsx, 1)
bar_bottom.setBackgroundColor(colors.gray)
bar_bottom.setTextColor(colors.white)
bar_top.setBackgroundColor(colors.gray)
bar_top.setTextColor(colors.white)
bar_bottom.clear()
bar_top.clear()
function newTask(app)
    -- the app string must end with /
    local coro = coroutine.create(loadfile(app .. 'main.lua'))
    table.insert(tasks, coro)
    tsx, tsy = term.getSize()
    local taskwin = window.create(term.current(), 1, 2, tsx, tsy - 2)
    taskwin.setTextColor(colors.black)
    taskwin.setBackgroundColor(colors.white)
    taskwin.clear()
    table.insert(windows, taskwin)
end
newTask('/system/apps/home/')
while true do
    -- Remove any dead coroutines from the tasks
    for i = 1, #tasks do
        if coroutine.status(tasks[i]) == 'dead' then
            tasks[i] = nil
            windows[i] = nil
        end
    end

    -- Create the queue
    local queue = {}
    local windowqueue = {}
    for tid = 1, #tasks do
        local priority = 1
        for i = 1, priority do
            table.insert(queue, tasks[tid])
            table.insert(windowqueue, windows[tid])
        end
    end

    -- Main loop
    local evt = {os.pullEvent()}
    local ql = #queue
    for i = 1, ql do
        local r = math.random(1, #queue)
        term.redirect(windowqueue[r])
        coroutine.resume(queue[r], unpack(evt))
        queue[r] = nil
    end
end
