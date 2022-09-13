
VictoryState = Class{__includes = BaseState}

function VictoryState:enter(params)
    self.winnerName = params.winnerName
end

function VictoryState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('start', { })
    end
end

function VictoryState:render()

    love.graphics.setFont(gFonts['large'])
    love.graphics.printf(self.winnerName .. " WON", 0, VIRTUAL_HEIGHT / 2-50,
        VIRTUAL_WIDTH, 'center')
    love.graphics.setFont(gFonts['medium'])
    love.graphics.printf("(Press Enter to continue!)", 0, VIRTUAL_HEIGHT / 2,
        VIRTUAL_WIDTH, 'center')
        
end