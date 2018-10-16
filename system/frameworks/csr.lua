-- Consistent Smooth Responsive UI Framework
-- for Hyper Operating System
-- Written by Zecradox

local csr = {}

local csr.objects = {}

function csr.newObject(objType, pt, x, y, xs, ys, bg, fg, text)
    local object = table.insert(csr.objects)
    object.x = x
    object.y = y
    object.xs = xs
    object.ys = ys
    object.bg = bg
    object.fg = fg
    object.text = text
    function object.draw()
        if object.window then
            object.window = nil
        end
        local objWindow = window.create(pt, object.x, object.y, object.xs, object.ys)
        object.window = objWindow
        objWindow.setBackgroundColor(object.bg)
        objWindow.setTextColor(object.fg)
        objWindow.clear()
        objWindow.setCursorPos(2, 1)
        objWindow.write(object.text)
    end
    object.draw()
    return object
end
csr.newObject('button', term.current(), 2, 2, 6, 1, colors.gray, colors.black, 'hi')
