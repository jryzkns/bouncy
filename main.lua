local unrequited = require("unrequited")

function love.load()
        game = {}
        game.xdim, game.ydim = 500,700
        game.title = ""
        unrequited:windowsetup(game.xdim,game.ydim,game.title)

        unrequited:closer_to_me('ball')
        unrequited.half_my_world['ball'].ground = game.ydim
        unrequited.half_my_world['ball'].wall = game.xdim

end

function love.update(dt)
        if not unrequited.waiting then
                unrequited:update(dt)
        end
end

function love.mousepressed(x,y,button,istouch,presses)
        unrequited:mousepressed(x,y,button,istouch,presses)
end

function love.mousereleased(x,y,button,istouch,presses)
        unrequited:mousereleased(x,y,button,istouch,presses)
end

function love.keypressed(key,scancode,isrepeat)
        if key == "space" then unrequited:wait_for_me()
        elseif key == "p" then unrequited:remember_me()
        end

        unrequited:keypressed(key,scancode,isrepeat)
end

function love.keyreleased(key,scancode)
        if key == "escape" then unrequited:heartbreak() end
        unrequited:keyreleased(key,scancode)
end

function love.draw()
        unrequited:draw()
end