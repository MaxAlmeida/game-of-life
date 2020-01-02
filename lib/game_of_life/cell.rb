module GameOfLife
  class Cell
    DEAD = 0
    ALIVE = 1
    attr_reader :status, :x, :y, :board

    def initialize(x, y, board)
      @x = x
      @y = y
      @status = DEAD
      @board = board
    end

    def set status
      @status = status
    end

    def kill
      set(DEAD)
    end

    def revive
      set(ALIVE)
    end

    def neighbors
      neighbors = []
      neighbors_position
      .map { |position| { x: position[:x] + self.x, y: position[:y] + self.y } }
      .reject { |position| invalid_position?(position) }
      .map { |position| neighbors.push(@board.get_cell(position[:x],position[:y])) }
      neighbors
    end

    def decide_status
      case count_live_neighbors
      when 0..1
        DEAD
      when 2
        self.status == DEAD ? DEAD : ALIVE
      when 3
        ALIVE
      when 4..8
        DEAD
      end
    end

    def neighbors_position
      [
        { x: - 1, y: - 1 },
        { x: + 0, y: - 1 },
        { x: + 1, y: - 1 },
        { x: - 1, y: + 0 },
        { x: + 1, y: + 0 },
        { x: - 1, y: + 1 },
        { x: + 0, y: + 1 },
        { x: + 1, y: + 1 },
      ]
    end

    def count_live_neighbors
      neighbors.map(&:status).reduce(:+)
    end

    def invalid_position? position
      position[:x] < 0 || position[:x] > @board.board_limit || position[:y] < 0 || position[:y] > @board.board_limit
    end
  end
end
