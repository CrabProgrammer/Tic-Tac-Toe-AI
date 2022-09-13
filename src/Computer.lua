Computer = Class{__includes = Opponent}

function Computer:setSymbol(symbol)
	self.symbol = symbol
end

function Computer:getSymbol()
	return self.symbol
end

function Computer:setName(name)
	self.name = name .. ": Computer"
end

function Computer:getName()
	return self.name
end


function Computer:makeTurn(field)
	local newMove = self:findBestMove(field)
	field:inputSymbol(newMove.col, newMove.row,self.symbol)
	return true
end

function Computer:evaluate(board)
	local winnerSymbol = board:checkVictory()
	if winnerSymbol == self.symbol then
		return 10
	elseif winnerSymbol == "None" then
		return 0
	else
		return -10
	end
end


function Computer:minimax(board, depth, isMax)
	local currentBoard = board
	local score = self:evaluate(currentBoard)
	
	if score == 10 then
		return score - depth
	end
	if score == -10 then
		return score + depth
	end
	if currentBoard:isFull() or (depth == 3 and currentBoard:getSize() == 5) then
		return 0
	end
	
	--If this maximizer's move
	if isMax then
		local best = -1000
		-- Traverse all cells
		for i = 1, currentBoard:getSize(), 1 do
			for j = 1, currentBoard:getSize(), 1 do
				if currentBoard:isCellEmpty(j,i) then
					currentBoard:inputSymbol(j,i,self.symbol)
					-- Call minimax recursively and choose the maximum value
					best = math.max( best, self:minimax(currentBoard, depth+1, not isMax) )
					--undo the move
					currentBoard:inputSymbol(j,i,"")
				end
			end
		end
		return best
	else --If this minimizer's move
		local best = 1000
		for i = 1, currentBoard:getSize(), 1 do
			for j = 1, currentBoard:getSize(), 1 do
				if currentBoard:isCellEmpty(j,i) then
					-- Make the move for opponent
					if self.symbol== "X" then
						currentBoard:inputSymbol(j,i,"0")
					else
						currentBoard:inputSymbol(j,i,"X")
					end
					-- Call minimax recursively and choose the minimum value
					best = math.min(best, self:minimax(currentBoard, depth+1, not isMax))
					-- Undo the move
					currentBoard:inputSymbol(j,i,"")
				end
			end
		end
		return best
	end
end

function Computer:findBestMove(board)
	local currentBoard = board
	local bestVal = -1000
	local bestMove = {}
	bestMove.row = -1
	bestMove.col = -1
    -- calculate value for every cell
	for i = 1, currentBoard:getSize(), 1 do
		for j = 1, currentBoard:getSize(), 1 do
			if currentBoard:isCellEmpty(j,i) then
				-- Make the move
				currentBoard:inputSymbol(j,i,self.symbol)

				local moveVal = self:minimax(currentBoard, 0, false)
				-- Undo the move
				currentBoard:inputSymbol(j,i,"")

				if moveVal > bestVal then
					bestMove.row = i
					bestMove.col = j
					bestVal = moveVal
				end
			end
		end
	end

	return bestMove
end

