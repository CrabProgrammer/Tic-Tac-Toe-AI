
Player = Class{__includes = Opponent}

local mouseX = 0 
local mouseY = 0
local isMousePressed = false


function Player:setSymbol(symbol)
	self.symbol = symbol
end

function Player:getSymbol()
	return self.symbol
end

function Player:setName(name)
	self.name = name .. ": Human"
end


function Player:getName()
	return self.name
end


function Player:makeTurn(field)
	if isMousePressed == true then --calculate cell position
		local cellY = math.floor((mouseY - (VIRTUAL_HEIGHT/2 - field:getCellSize()*(field:getSize()/2)))/field:getCellSize()) + 1  
		local cellX = math.floor((mouseX - (VIRTUAL_WIDTH/2 - field:getCellSize()*(field:getSize()/2)))/field:getCellSize()) + 1
		
		--if cell exist
		if cellX > 0 and cellX <= field:getSize() and cellY > 0 and cellY <= field:getSize() then
			if field:isCellEmpty(cellX, cellY) == true then
					field:inputSymbol(cellX,cellY, self.symbol)
					isMousePressed = false
					return true
			end
		end
		isMousePressed = false
		return false
	end
end

function love.mousepressed(x, y, button, istouch)
    if button == 1 then
		isMousePressed = true
		-- convert global coordinates to local
		mouseX , mouseY = push:toGame(x, y)
	end
end
