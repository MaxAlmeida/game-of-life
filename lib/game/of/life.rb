require_relative '../../game_of_life/board'

class Life
    QUANTITY = ARGV[0].to_i
    SEED = ARGV[1]

    def initialize(board)
        @board = board
        @seeds = init_seeds
        check_args
        @board.setup_seed(get_seed)
    end

    def run
      @board.display()
      loop do
        @board.next_generation
        sleep 0.01

        trap "SIGINT" do
          puts "Exiting"
          exit 130
        end
      end
    end

    def check_args
       if ARGV.count == 0
          puts "Available seeds: \n\n"
          puts @seeds.keys
          exit 128
       elsif ARGV.count != 2
        puts "Its necessary pass quantity cells and seed name."
        exit 128
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
end

life = Life.new(GameOfLife::Board.new(Life::QUANTITY))
life.run