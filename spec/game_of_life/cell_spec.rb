require 'game_of_life/cell'

RSpec.describe GameOfLife::Cell do
  let(:board) { GameOfLife::Board.new(3) }
  let(:cell) { board.get_cell(1,1) }

  context "When initialize manage state" do
    describe '#status' do
      it 'Is created dead' do
        expect(cell.status).to eq(GameOfLife::Cell::DEAD)
      end

      it "Revive cell" do
        expect { cell.revive }.to change { cell.status }.to(GameOfLife::Cell::ALIVE)
      end

      it "Kills cell" do
        cell.revive
        expect { cell.kill }.to change { cell.status }.to(GameOfLife::Cell::DEAD)
      end
    end
  end

  context "When requested return neighbor information" do
    describe "#count_live_neighbors" do
      it "return live neighbors quantity" do
        board.get_cell(0,0).revive
        board.get_cell(1,0).revive
        board.get_cell(1,1).revive
        expect(cell.count_live_neighbors).to eq(2)
      end
    end
  end
end
