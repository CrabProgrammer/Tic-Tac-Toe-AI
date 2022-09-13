FieldSelectState = Class{__includes = BaseState}

local highlighted = 0

function FieldSelectState:enter(params)
    self.opponent1 = params.opponent1
	self.opponent2 = params.opponent2
end

function FieldSelectState:init()
    self.currentField = 1
end

function FieldSelectState:update(dt)
	
	if love.keyboard.wasPressed('up') then
		highlighted = (highlighted - 1) % 2
        gSounds['select']:play()
	elseif love.keyboard.wasPressed('down') then
		highlighted = (highlighted + 1) % 2
		gSounds['select']:play()
    end

    -- select paddle and move on to the serve state, passing in the selection
    if love.keyboard.wasPressed('return') or love.keyboard.wasPressed('enter') then
        gSounds['confirm']:play()

		if highlighted == 0 then
			self.field = Field(3)
		else
			self.field = Field(5)
		end
		
        gStateMachine:change('play', {
            opponent1 = self.opponent1,
            opponent2 = self.opponent2,
			field = self.field
        })
    end

    if love.keyboard.wasPressed('escape') then
        love.event.quit()
    end
end

function FieldSelectState:render()
    -- instructions
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("Select field to play!", 0, VIRTUAL_HEIGHT / 4,
        VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("(Press Enter to continue!)", 0, VIRTUAL_HEIGHT / 3,
        VIRTUAL_WIDTH, 'center')
        
		
	love.graphics.setFont(gFonts['medium'])	
    if highlighted == 0 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("3x3", 0, VIRTUAL_HEIGHT / 2 - 15,
        VIRTUAL_WIDTH, 'center')

    -- reset the color
    love.graphics.setColor(1, 1, 1, 1)

    -- render blue if we're highlighting that one
    if highlighted == 1 then
        love.graphics.setColor(103/255, 1, 1, 1)
    end
    love.graphics.printf("5x5", 0, VIRTUAL_HEIGHT / 2 + 15,
        VIRTUAL_WIDTH, 'center')

end