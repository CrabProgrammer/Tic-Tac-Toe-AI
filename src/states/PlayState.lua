
PlayState = Class{__includes = BaseState}


function PlayState:enter(params)
    self.opponent1 = params.opponent1
    self.opponent2 = params.opponent2
    self.field = params.field
	isMousePressed = false
	
	--randomize turns
	self.firstTurn = math.random(1,2)
	if self.firstTurn == 1 then
		self.opponent1:setSymbol("X")
		self.opponent1:setName("Player 1")
		self.opponent2:setSymbol("0")
		self.opponent2:setName("Player 2")
		self.turn = 1;
	else
		self.opponent1:setSymbol("0")
		self.opponent1:setName("Player 2")
		self.opponent2:setSymbol("X")
		self.opponent2:setName("Player 1")
		self.turn = 2;
	end
	
end

function PlayState:update(dt)
    
	if self.turn == 1 and self.opponent1:makeTurn(self.field) then
		self.turn = 2
		love.timer.sleep(0.2)
	elseif self.turn == 2 and self.opponent2:makeTurn(self.field) then
		self.turn = 1
		love.timer.sleep(0.2)	
	end
	
	
	-- change state if anyone win or matrix is full
	local winnerSymbol = self.field:checkVictory()
	if winnerSymbol ~= "None" then
		gSounds['victory']:play()
		if winnerSymbol == self.opponent1:getSymbol() then
			gStateMachine:change('victory', {winnerName = self.opponent1:getName()})
		else
			gStateMachine:change('victory', {winnerName = self.opponent2:getName()})
		end
	elseif self.field:isFull() then
		gSounds['victory']:play()
		gStateMachine:change('victory', {winnerName = "NO ONE"})
	end
    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function PlayState:render()
    self.field:render()
	
	--draw names
	love.graphics.printf(self.opponent1:getName(), 10, 10, 100, 'left')
	love.graphics.printf(self.opponent2:getName(), VIRTUAL_WIDTH-110, 10, 100, 'right')
end
