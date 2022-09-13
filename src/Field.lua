
Field = Class{}

function Field:init(size)
	self.size = size
	self.matrix = {}
    for i = 1, self.size do
		self.matrix[i] = {}
		for j = 1, self.size do
			self.matrix[i][j] = ""
		end
    end
	
	--set pixel size of cells
	if self.size == 3 then
		self.cellSize = 60
	else 
		self.cellSize = 36
	end
end

function Field:getMatrix()
	return self.matrix
end

function Field:getSize()
	return self.size
end


function Field:drawCross(x,y)

    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(8)
	love.graphics.push()
	love.graphics.translate(VIRTUAL_WIDTH/2 - self.cellSize*math.floor(self.size/2) + x*self.cellSize, 
							VIRTUAL_HEIGHT/2 - self.cellSize*math.floor(self.size/2) + y*self.cellSize)
	love.graphics.rotate(math.rad(45))
    love.graphics.rectangle("line", 0, -self.cellSize/2, 1, self.cellSize)
	
	love.graphics.rotate(math.rad(90))
    love.graphics.rectangle("line", 0, -self.cellSize/2, 1, self.cellSize)
									
	love.graphics.pop()
end

function Field:drawZero(x,y)

    love.graphics.setLineStyle("smooth")
    love.graphics.setLineWidth(8)
	love.graphics.circle("line", VIRTUAL_WIDTH/2 - self.cellSize*math.floor(self.size/2) + x*self.cellSize,
								 VIRTUAL_HEIGHT/2 - self.cellSize*math.floor(self.size/2) + y*self.cellSize, self.cellSize/3, 500)
end

function Field:render()

	love.graphics.setColor(1, 1, 1, 1)
	love.graphics.setLineWidth(5)
	
	if self.size == 3 then
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2-30, VIRTUAL_HEIGHT/2-90, 1, 180, 0.5, 0.5)
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2+30, VIRTUAL_HEIGHT/2-90, 1, 180, 0.5, 0.5)
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2-90, VIRTUAL_HEIGHT/2-30, 180, 1, 0.5, 0.5)
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2-90, VIRTUAL_HEIGHT/2+30, 180, 1, 0.5, 0.5)	
	elseif self.size == 5 then
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2-54, VIRTUAL_HEIGHT/2-90, 1, 180, 0.5, 0.5)
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2-18, VIRTUAL_HEIGHT/2-90, 1, 180, 0.5, 0.5)
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2+18, VIRTUAL_HEIGHT/2-90, 1, 180, 0.5, 0.5)
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2+54, VIRTUAL_HEIGHT/2-90, 1, 180, 0.5, 0.5)

		love.graphics.rectangle("line", VIRTUAL_WIDTH/2-90, VIRTUAL_HEIGHT/2-54, 180, 1, 0.5, 0.5)
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2-90, VIRTUAL_HEIGHT/2-18, 180, 1, 0.5, 0.5)
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2-90, VIRTUAL_HEIGHT/2+18, 180, 1, 0.5, 0.5)
		love.graphics.rectangle("line", VIRTUAL_WIDTH/2-90, VIRTUAL_HEIGHT/2+54, 180, 1, 0.5, 0.5)		
	end
	for i = 1, self.size, 1 do
		for j = 1, self.size, 1 do
			if self.matrix[i][j] == "X" then
				self:drawCross(j-1,i-1)
			elseif self.matrix[i][j] == "0" then
				self:drawZero(j-1,i-1)
			end
		end
	end
end

function Field:getCellSize()
	return self.cellSize
end

function Field:isCellEmpty(cellX, cellY)
	if self.matrix[cellY][cellX] == "" then
		return true
	else 
		return false
	end
end

function Field:inputSymbol(cellX,cellY,symbol)
	self.matrix[cellY][cellX]=symbol
end



function Field:checkVictory()
	if self:findLine("X") then
		return "X"
	elseif self:findLine("0") then
		return "0"
	else
		return "None"
	end
end

function Field:isFull()
	for i = 1, self.size, 1 do
		for j = 1, self.size, 1 do
			if self.matrix[i][j] == "" then
				return false
			end
		end
	end
	return true
end

function Field:getMatrix()
	return self.matrix
end

function Field:findLine(symbol)
	local checkedDiagonal1 = 0
	local checkedDiagonal2 = 0
	for i = 1, self.size, 1 do
		local checkedX = 0
		local checkedY = 0

		for j = 1, self.size, 1 do
			if self.matrix[i][j] == symbol then
				checkedX = checkedX + 1
			end
			if self.matrix[j][i] == symbol then
				checkedY = checkedY + 1
			end
		end
		
		if self.matrix[i][i] == symbol then
			checkedDiagonal1 = checkedDiagonal1 + 1
		end
		if self.matrix[i][self.size - i + 1] == symbol then
			checkedDiagonal2 = checkedDiagonal2 + 1
		end
		
		if checkedX == self.size or checkedY == self.size or checkedDiagonal1 == self.size or checkedDiagonal2 == self.size then
			return true
		end
	end
	
	return false
end