require 'game_of_life/board'

RSpec.describe GameOfLife::Board do
  let(:board) { described_class.new(3) }
  let(:seed) { [[1,0]]}
  let(:seed_off_limits) {[[10,10]]}

  context "when game of life it started initialize board " do
    describe "#cells" do
      it 'create square board with nxn cells' do
        expect(board.cells.flatten.count).to eq(9)
      end
    end

    describe "#get_cell" do
      it 'returns a based on x and y' do
        expect(board.get_cell(1,1).class).to eq(GameOfLife::Cell)
      end
    end
  end

  context "when board receive seeds with cells alive" do
    describe '#next_generation' do
      it 'Living cell without neighbor will dies' do
        board.get_cell(0,0).revive
        expect { board.next_generation }.to change { board.get_cell(0,0).status }.to(GameOfLife::Cell::DEAD)
      end

      it 'Living cell with 1 neighbor will dies' do
        board.get_cell(0,0).revive
        board.get_cell(0,1).revive
        expect { board.next_generation }.to change { board.get_cell(0,0).status }.to(GameOfLife::Cell::DEAD)
      end

      it 'Living cell with 2 neighbors remains alive ' do
        board.get_cell(0,1).revive
        board.get_cell(1,1).revive
        board.get_cell(2,1).revive
        board.next_generation
        expect(board.get_cell(1,1).status).to eq(GameOfLife::Cell::ALIVE)
      end

      it 'Dead cell with 2 neighbors remains dead' do
        board.get_cell(0,1).revive
        board.get_cell(2,1).revive
        board.next_generation
        expect(board.get_cell(1,1).status).to eq(GameOfLife::Cell::DEAD)
      end

      it "Living cell with 3 neighbors remains alive" do
        board.get_cell(0,0).revive
        board.get_cell(1,0).revive
        board.get_cell(1,1).revive
        board.get_cell(0,1).revive
        board.next_generation
        expect(board.get_cell(1,1).status).to eq(GameOfLife::Cell::ALIVE)
      end

      it "Dead cell with 3 neighbors will stay alive" do
        board.get_cell(0,0).revive
        board.get_cell(1,0).revive
        board.get_cell(0,1).revive
        expect { board.next_generation }.to change { board.get_cell(1,1).status }.to(GameOfLife::Cell::ALIVE)
      end

      it "Living cell with more than 3 neighbors will dies " do
        board.get_cell(0,0).revive
        board.get_cell(1,0).revive
        board.get_cell(2,1).revive
        board.get_cell(1,1).revive
        board.get_cell(0,1).revive
        expect { board.next_generation }.to change { board.get_cell(1,1).status }.to(GameOfLife::Cell::DEAD)
      end
    end
  end
end
