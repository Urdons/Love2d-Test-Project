function love.load()
    width, height, flags = love.window.getMode( )
    BaseFps = 10
    Score = 0
    Player = {
        Position = {X = 0, Y = 0},
        Size = {X = 100, Y = 100},
        Color = {R = 0.5, G = 0.5, B = 0.5}
    }
    Cubes = {}
    for i = 1, 5 do
        table.insert(Cubes, {
            Position = {
            X = love.math.random(0, width - 50), 
            Y = love.math.random(0, height - 50)
        },
            Size = {X = 50, Y = 50},
            Color = {R = 1, G = 0, B = 0}
        })
    end
end

function love.update()
    --player
    local FpsMod = love.timer.getFPS() / BaseFps
    speed = 10 / BaseFps
    if love.keyboard.isDown("up") then
        Player.Position.Y = Player.Position.Y - speed
    end
    if love.keyboard.isDown("down") then
        Player.Position.Y = Player.Position.Y + speed
    end
    if love.keyboard.isDown("left") then
        Player.Position.X = Player.Position.X - speed
    end
    if love.keyboard.isDown("right") then
        Player.Position.X = Player.Position.X + speed
    end
    --check if Cube is being touched
    for i, cube in ipairs(Cubes) do
        if Player.Position.X < cube.Position.X + cube.Size.X and 
            Player.Position.X + Player.Size.X > cube.Position.X and 
            Player.Position.Y < cube.Position.Y + cube.Size.Y and 
            Player.Position.Y + Player.Size.Y > cube.Position.Y
        then
            cube.Position = {X = love.math.random(0, width - 50), Y = love.math.random(0, height - 50)}
            Score = Score + 1
        end
    end
end

function love.draw()
     --draw the object
    love.graphics.setColor(Player.Color.R, Player.Color.G, Player.Color.B)
    love.graphics.rectangle("fill", Player.Position.X, Player.Position.Y, Player.Size.X, Player.Size.Y)

    for i, cube in ipairs(Cubes) do
        love.graphics.setColor(cube.Color.R, cube.Color.G, cube.Color.B)
        love.graphics.rectangle("fill", cube.Position.X, cube.Position.Y, cube.Size.X, cube.Size.Y)
    end

    love.graphics.setColor(1, 1, 1)
    love.graphics.print("Score: " .. Score)
end
