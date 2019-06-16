local ball = {}

ball.x, ball.y = 250,30
ball.rad = 10

ball.weight = 35 -- kg
ball.gravity = -90 -- m/s^2

ball.yvel = 0 -- m/s
ball.elastic_coeff = 0.8

ball.xvel = 1000

function ball:update(dt)
        
        -- gravity is in effect when the ball is not on the ground
        if ball.rad + ball.y < ball.ground then
                -- gravity is a change in velocity
                ball.yvel = ball.yvel + ball.gravity 
        end
        
        local dy = ball.yvel*dt 
        local dx = ball.xvel*dt
        
        ball.x = ball.x + dx
        ball.y = ball.y - dy

        -- bouncing
        if ball.rad + ball.y >= ball.ground then
                ball.y = ball.ground - ball.rad
                ball.yvel = -1*ball.elastic_coeff*ball.yvel
        end

        if (ball.x + ball.rad > ball.wall) then 
                ball.x = ball.wall - ball.rad
                ball.xvel = -1*ball.elastic_coeff*ball.xvel
        elseif (ball.x - ball.rad < 0) then
                ball.x = ball.rad
                ball.xvel = -1*ball.elastic_coeff*ball.xvel
        end

        -- if the ball is dribbing on the ground, it'll stop soon
        if math.abs(ball.yvel) < 5 and (ball.ground - ball.y) < 2*ball.rad then
                ball.y = ball.ground - ball.rad -- stay on the ground
                ball.yvel = 0   -- no more moving
        end

        -- if the ball is rolling on the ground, it'll stop soon
        if (ball.yvel == 0) then
                ball.xvel = ball.xvel*0.95
        end

end

function ball:draw() love.graphics.circle('fill',ball.x,ball.y,ball.rad) end

function ball:jump() ball.yvel = ball.yvel + 600 end

function ball:boost() ball.xvel = ball.xvel + ((ball.xvel > 0) and 500 or -500) end

function ball:keypressed(key,scancode,isrepeat)

        if key == 'j' then ball:jump() end
        if key == 'b' then ball:boost() end

end

return ball