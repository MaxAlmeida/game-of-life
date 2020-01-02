require_relative '../../game_of_life/board'

class Life
    QUANTITY = ARGV[0].to_i
    SEED = ARGV[1]

    def initialize(board)
        @board = board
        @seeds = init_seeds
        check_args
        setup_seed(get_seed)
    end

    def run
      display()
      loop do
        @board.next_generation
        display()
        capture_exit
      end
    end

    def check_args
       if ARGV.count == 0
          puts "Available seeds: "
          puts @seeds.keys
          puts "\n\nType bin/console [quantity cells] [seed name]"
          exit 128
       elsif ARGV.count != 2
        puts "Its necessary pass quantity cells and seed name."
        exit 128
       end
    end

    def display
      system "clear"
      puts @board.cells.map {|row| row.map {|cell| cell.status == 1 ? '#' : '.'}.join(' ')}
    end

    def setup_seed(seed)
      begin
       seed.each do |seed|
         @board.get_cell(seed[0],seed[1]).revive
       end
      rescue NoMethodError
        puts "Board is smaller than seed informed"
        exit
      end
    end

    def get_seed
      begin
        name = SEED
        if @seeds[name.downcase] == nil
          raise NoMethodError
        else
          @seeds[name.downcase]
        end
      rescue NoMethodError
        puts "This seed doesn't exist"
        exit 128
      end
    end

    def init_seeds
      {
        "blinker" => [[3,0],[3,1],[3,2]],
        "glider" => [[1,0],[2,1],[0,2],[1,2],[2,2]],
        "acorn" => [[0,1],[1,3],[2,0],[2,1],[2,4],[2,5],[2,6]],
        "diehard" => [[6,0],[0,1],[1,1],[1,2],[5,2],[6,2],[7,2]],
      }
    end

    def capture_exit
      trap "SIGINT" do
        puts "Exiting"
        exit 130
      end
    end
end

life = Life.new(GameOfLife::Board.new(Life::QUANTITY))
life.run