
StartState = Class{__includes = BaseState}

local highlighted = 0

function StartState:enter(params)
end

function StartState:update(dt)
    -- toggle highlighted option if we press an arrow key up or down
    if love.keyboard.wasPressed('up') then
		highlighted = (highlighted - 1) % 3
        gSounds['select']:play()
	elseif love.keyboard.wasPressed('down') then
		highlighted = (highlighted + 1) % 3
		gSounds['select']:play()
    end

    -- confirm whichever option we have selected to change screens
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gSounds['confirm']:play()

        if highlighted == 0 then
			self.opponent1 = Player()
			self.opponent2 = Computer()
        elseif highlighted == 1 then
			self.opponent1 = Player()
			self.opponent2 = Player()
		elseif highlighted == 2 then
			self.opponent1 = Computer()
			self.opponent2 = Computer()
        end
		
		gStateMachine:change('field-select', {
                opponent1 = self.opponent1,
                opponent2 = self.opponent2,
            })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function StartState:render()
    -- title
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf("TIC-TAC-TOE", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')
    
    love.graphics.setFont(gFonts['medium'])

    -- if we're highlighting, render that option blue
    if highlighted == 0 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("Player VS Computer", 0, VIRTUAL_HEIGHT / 2 + 50,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("Player VS Player", 0, VIRTUAL_HEIGHT / 2 + 70,
        VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1, 1)
	
	if highlighted == 2 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("Computer VS Computer", 0, VIRTUAL_HEIGHT / 2 + 90,
        VIRTUAL_WIDTH, 'center')
		
    love.graphics.setColor(1, 1, 1, 1)

end