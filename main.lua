function love.load()
    anim8 = require 'Libraries/anim8'
    sti = require "Libraries/sti"
    GameMap = sti('Maps/map2.lua')
    camera = require "Libraries/camera"
    cam = camera()
    love.graphics.setDefaultFilter('nearest', 'nearest')
    player={}
    player.x = 200
    player.y = 200
    player.speed=5
    -- player.sprite = love.graphics.newImage("sprites/butterfly.png")
    player.shadow = love.graphics.newImage('sprites/Shadow.png')
    player.SpriteSheet = love.graphics.newImage("sprites/PlayerSheet.png")
    player.grid = anim8.newGrid(12, 18, player.SpriteSheet:getWidth(), player.SpriteSheet:getHeight())
    -- background = love.graphics.newImage("sprites/Green Background.png")
    
    player.animations = {}
    player.animations.down = anim8.newAnimation(player.grid('1-4', 1), 0.2)
    player.animations.up = anim8.newAnimation(player.grid('1-4', 4), 0.2)
    player.animations.right = anim8.newAnimation(player.grid('1-4', 3), 0.2)
    player.animations.left = anim8.newAnimation(player.grid('1-4', 2), 0.2)
    
    player.anim = player.animations.left
    
end
function love.update(dt)
    local ismoving = false
    if love.keyboard.isDown("right") then
        player.x=player.x + player.speed
        player.anim=player.animations.right
        ismoving=true
    end
    if love.keyboard.isDown("left") then
        player.x=player.x - player.speed
        player.anim=player.animations.left
        ismoving=true
    end
    if love.keyboard.isDown("down") then
        player.y=player.y + player.speed
        player.anim=player.animations.down
        ismoving=true
    end

    if love.keyboard.isDown("up") then
        player.y=player.y - player.speed
        player.anim=player.animations.up
        ismoving=true
    
    end
    if ismoving==false then
        player.anim:gotoFrame(2)
                                
    end
    
    player.anim:update(dt)
    cam:lookAt(player.x, player.y)

    local w = love.graphics.getWidth()
    local h = love.graphics.getHeight()
    local mapW = GameMap.width * GameMap.tilewidth
    local maph = GameMap.height * GameMap.tileheight

    if cam.x < w/2 then
        cam.x=w/2
    end    
    if cam.y < h/2 then
        cam.y=h/2
    end    
    if cam.y > (maph -h/2) then
        cam.y = (maph -h/2)
    end    
    if cam.x > (mapW - w/2) then
        cam.x = (mapW - w/2)
    end    
    

     
end
function love.draw()
-- love.graphics.circle('fill',player.x,player.y,70)
-- love.graphics.draw(background, 0, 0)
-- love.graphics.draw(player.sprite,player.x,player.y)
    cam:attach()

        GameMap:drawLayer(GameMap.layers['Tile Layer 1'])
        GameMap:drawLayer(GameMap.layers["tre"])
        GameMap:drawLayer(GameMap.layers["Trees"])
        player.anim:draw(player.SpriteSheet,player.x,player.y,nil,5,nil,6,9)
        love.graphics.draw(player.shadow,player.x-55,player.y-12,nil,0.225,nil)
    cam:detach()
end

