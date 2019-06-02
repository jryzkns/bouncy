local ball = {}

ball.x, ball.y = 250,30
ball.rad = 10

ball.weight = 15 -- kg
ball.gravity = -100 -- m/s^2

ball.yvel = 0 -- m/s
ball.elastic_coeff = 0.8

function ball:update(dt)

        -- gravity is in effect when the ball is not on the ground
        if ball.rad + ball.y < ball.ground then
                -- gravity is a change in velocity
                ball.yvel = ball.yvel + ball.gravity 
        end

        -- the change in y is the change in time (dt) multiplied by the y velocity
        local dy = ball.yvel*dt 
        
         -- and we update the position of the ball, since the velocity
        ball.y = ball.y - dy

        -- if the ball touches the ground
        if ball.rad + ball.y >= ball.ground then
                ball.y = ball.ground - ball.rad -- stay on the ground
                ball.yvel = -1*ball.elastic_coeff*ball.yvel -- bounce
        end

        -- when the ball is really close to the ground and dribbling, 
        -- stop dribbling and stay on the ground
        if math.abs(ball.yvel) < 5 and (ball.ground - ball.y) < 2*ball.rad then
                ball.y = ball.ground - ball.rad -- stay on the ground
                ball.yvel = 0   -- no more moving
        end

end

function ball:draw()
        love.graphics.circle('fill',ball.x,ball.y,ball.rad)
end

function ball:jump()
        ball.yvel = ball.yvel + 600
end

function ball:keypressed(key,scancode,isrepeat)

        if key == 'j' then
                ball:jump()
        end
end

return ball