require "./connect_four.rb"

describe Game do

  describe "#game_over?" do
    subject(:game_over) { described_class.new() }

    context "when there are not four tokens in a row" do
      it "returns false" do
        expect(game_over.game_over?).to be false
      end
    end

    context "when there are four in a row horizontally" do
      it "returns true" do
        game_over.board = [ [" ", " ", " ", " ", " ", " ", " "],
                            [" ", " ", " ", " ", " ", " ", " "],
                            [" ", " ", " ", " ", " ", " ", " "],
                            [" ", " ", " ", " ", " ", " ", " "],
                            [" ", " ", " ", " ", " ", " ", " "],
                            ["x", "x", "x", "x", " ", " ", " "] ]
        expect(game_over.game_over?).to be true
      end
    end

    context "when there are four in a row vertically" do
      it "returns true" do
        game_over.board = [ [" ", " ", " ", " ", " ", " ", " "],
                            [" ", " ", " ", " ", " ", " ", " "],
                            ["x", " ", " ", " ", " ", " ", " "],
                            ["x", " ", " ", " ", " ", " ", " "],
                            ["x", " ", " ", " ", " ", " ", " "],
                            ["x", " ", " ", " ", " ", " ", " "] ]
        expect(game_over.game_over?).to be true
      end
    end

    context "when there are four in a row diagonally descending" do
      it "returns true" do
        game_over.board = [ [" ", " ", " ", " ", " ", " ", " "],
                            ["x", " ", " ", " ", " ", " ", " "],
                            [" ", "x", " ", " ", " ", " ", " "],
                            [" ", " ", "x", " ", " ", " ", " "],
                            [" ", " ", " ", "x", " ", " ", " "],
                            [" ", " ", " ", " ", " ", " ", " "] ]
        expect(game_over.game_over?).to be true
      end
    end

    context "when there are four in a row diagonally ascending" do
      it "returns true" do
        game_over.board = [ [" ", " ", " ", " ", " ", " ", " "],
                            [" ", " ", " ", " ", " ", " ", " "],
                            [" ", " ", " ", " ", " ", "x", " "],
                            [" ", " ", " ", " ", "x", " ", " "],
                            [" ", " ", " ", "x", " ", " ", " "],
                            [" ", " ", "x", " ", " ", " ", " "] ]     
        expect(game_over.game_over?).to be true   
      end
    end

  end

  describe "#find_empty_square" do
    subject(:game) { described_class.new() }

    context "when the bottom row is empty" do
      it "returns the coordinates of the bottom-row square" do
        expect(game.find_empty_square(4)).to eq(5)
      end
    end

    context "when the bottom row is full and the second row is empty" do
      it "returns the coordinates of the second-row square" do
        game.board = [ [" ", " ", " ", " ", " ", " ", " "],
                       [" ", " ", " ", " ", " ", " ", " "],
                       [" ", " ", " ", " ", " ", " ", " "],
                       [" ", " ", " ", " ", " ", " ", " "],
                       [" ", " ", " ", " ", " ", " ", " "],
                       [" ", " ", " ", "x", " ", " ", " "] ]
        expect(game.find_empty_square(3)).to eq(4)
      end
    end

    context "when the whole column is full" do
      it "returns nil" do
        game.board = [ [" ", " ", " ", "x", " ", " ", " "],
                       [" ", " ", " ", "x", " ", " ", " "],
                       [" ", " ", " ", "x", " ", " ", " "],
                       [" ", " ", " ", "x", " ", " ", " "],
                       [" ", " ", " ", "x", " ", " ", " "],
                       [" ", " ", " ", "x", " ", " ", " "] ]
        expect(game.find_empty_square(3)).to be_nil
      end
    end

  end

  describe "#place_token" do
    subject(:game) { described_class.new() }

    it "places the player's token at the indicated space" do
      game.place_token(5, 1)
      expect(game.board[5][1]).to eql("x")
    end

  end

end