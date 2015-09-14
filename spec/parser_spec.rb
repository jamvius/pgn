require 'spec_helper'

describe PGN do
  describe "parsing a file" do
    it "should return a list of games" do
      games = PGN.parse(File.read("./examples/immortal_game.pgn"))
      expect(games.length).to eq(1)
      game = games.first
      expect(game.result).to eq("1-0")
      expect(game.tags["White"]).to eq("Adolf Anderssen")
      expect(game.moves.last).to eq("Be7#")
    end
  end

  context "alternate castling notation" do
    describe "parsing a file" do
      it "should return a list of games" do
        games = PGN.parse(File.read("./spec/pgn_files/alternate_castling.pgn"))
        game = games.first
        expect(game.tags["White"]).to eq("Somebody")
        expect(game.result).to eq("*")
        expect(game.moves.last).to eq("O-O-O")
      end
    end
  end

  context "annotations" do
    describe "parsing a file" do
      it "should return a list of games" do
        games = PGN.parse(File.read("./spec/pgn_files/annotations.pgn"))
        games.each do |game|
          expect(game.tags["White"]).to eq("Fool")
          expect(game.result).to eq("0-1")
          expect(game.moves.last).to eq("Qh4#")
        end
      end
    end

    describe "parsing a file" do
      it "should work with comments" do
        games = PGN.parse(File.read("./spec/pgn_files/comments.pgn"))
        game = games.first
        expect(game.tags["White"]).to eq("Scholar")
        expect(game.result).to eq("1-0")
        expect(game.moves.last).to eq("Qxf7#")
      end

      it "should work with multiline comments" do
        games = PGN.parse(File.read("./spec/pgn_files/multiline_comments.pgn"))
        game = games.first
        expect(game.tags["White"]).to eq("Scholar")
        expect(game.result).to eq("1-0")
        expect(game.moves.last).to eq("Qxf7#")
      end
    end

    describe "parsing a file" do
      it "should return a list of games" do
        games = PGN.parse(File.read("./spec/pgn_files/variations.pgn"))
        game = games.first
        expect(game.tags["Black"]).to eq("Petrov")
        expect(game.result).to eq("*")
        expect(game.moves.last).to eq("Nf6")
      end
    end
    
    describe "parsing a complex file" do
      it "should return a list of games" do
        games = PGN.parse(File.read("./spec/pgn_files/test.pgn"))
        game = games.first
        expect(game.tags["Black"]).to eq("Gelfand, Boris")
        expect(game.result).to eq("1-0")
        expect(game.moves[13]).to eq("Nfd7")
        expect(game.moves[34]).to eq("f3")
        expect(game.moves[35].annotation).to eq("$6")
        expect(game.moves[35].comment).to eq("{Gelfand\ndecide tomar medidas.}")
        expect(game.moves[35].variations.size).to eq(1)
        variation = game.moves[35].variations[0]
        expect(variation.size).to eq(2)
        expect(variation[0]).to eq("Nxf3")
      end
    end
  end
end
