require_relative 'cell'

module GameOfLife
  class Board
    attr_reader :cells, :board_limit

    def initialize cell_quantity
      
      set_board_limit(cell_quantity)
      cells = (0..cell_quantity - 1).to_a.map do |y|
        (0..cell_quantity - 1).to_a.map do |x|
          Cell.new(x, y,self)
        end
      end
      @cells = cells
    end

    def setup_seed(seed)
        seed.each do |seed|
          puts get_cell(seed[0],seed[1])
          get_cell(seed[0],seed[1]).revive
        end
    end

    def display
      system "clear"
      puts @cells.map {|row| row.map {|cell| cell.status == 1 ? '#' : '.'}.join(' ')}
    end

    def get_cell x, y
      @cells.flatten.find { |cell| cell.x == x && cell.y == y }
    end

    def next_generation_status 
      next_status_map = @cells.flatten.map do |cell|
        {
          x: cell.x,
          y: cell.y,
          next: cell.decide_status
        }
      end
    end

    def next_generation
      next_generation_status.map do |status|
        get_cell(status[:x], status[:y]).set(status[:next])
      end
      display()
    end

    private def set_board_limit cell_quantity
      @board_limit = cell_quantity-1
    end
  end
end