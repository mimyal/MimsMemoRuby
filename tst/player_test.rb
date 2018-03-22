require_relative '../src/player'
require 'minitest/autorun'

class PlayerTest < Minitest::Test

  describe '#initialize' do
    let(:player) { Player.new }

    it 'should initialize a player name' do
      is_nil = player.name.class == NilClass
      assert_equal false, is_nil
    end

    it 'should have a player fumeology score starting at zero' do
      assert_equal 0, player.fumeology_score
    end

    it 'should list the empty player fumeology record before any changes are made' do
      result = player.fumeology_record
      assert_equal [], result
    end

  end

  describe '#update_record' do
    let(:player) { Player.new }
    let(:herb_combo1) { ['Peppermint'] }
    let(:herb_combo2) { ['Cardamom'] }
    let(:point) { FumeologyPoint.new(herb_combo1)}
    let(:point2) { FumeologyPoint.new(herb_combo2) }

    it 'should add one to the fumeology score' do
      assert_equal 0, player.fumeology_score, 'Before updating the record'
      player.update_record(point)
      assert_equal 1, player.fumeology_score, 'After updating the record'
    end

    it 'should update the players fumeology record with the new point' do
      player.update_record(point)
      assert_equal true, player.fumeology_record.include?(point)
    end

    it 'should return nil if it tries to update the record with same point twice' do
      player.update_record(point)
      assert_nil player.update_record(point), 'Tried to include the same fume point twice'
    end

    it 'should return nil if it tries to update the record with the same point object twice' do
      duplicate_herb = 'Peppermint'
      duplicate_point = FumeologyPoint.new([duplicate_herb])
      player.update_record(point)
      assert_nil player.update_record(duplicate_point), 'Attempted to add duplicate herbs to record'
    end

    it 'should return nil if it tries to update the record with the same herb_combination twice (more than one herb)' do
      point.add('Aloe')
      duplicate_point = FumeologyPoint.new(['Peppermint', 'Aloe'])
      player.update_record(point)
      assert_nil player.update_record(duplicate_point), 'A player cannot have two points with the same herb combination'
    end

    it 'should keep track of changes' do
      assert_equal [], player.fumeology_changes
      player.update_record(point)
      assert_equal [point], player.fumeology_changes
    end

    it 'should not cause loading from file to add points to fumeology changes' do
      player.update_record(point, :load)
      assert_equal [], player.fumeology_changes
    end

    # The validity of the combination is only checked on the grounds of it already having been created.
    # Testing this creation is valid should be done elsewhere.
    # Capturing the error throw should be handled AT creation.

  end

  describe '#update_record_from_list_of_herbs' do
    let(:player) { Player.new }

    it 'should load points from a list to a player profile' do
      names = [['Peppermint', 'Aloe'], ['Aloe'], ['Cardamom', 'Aloe', 'Peppermint']]
      player.update_record_from_list_of_herbs(names)
      assert_equal 3, player.fumeology_score
    end

  end

  describe '#load_points_from_file' do
    let(:player) { Player.new }
    let(:file_path) { 'seeds/' }

    it 'should load herb records into the player object' do
      player.load_points_from_file("#{file_path}combinations1.csv")
      assert_equal 5, player.fumeology_record.length
    end

    it 'should not add records from an empty file' do
      player.load_points_from_file("#{file_path}empty.csv")
      assert_equal 0, player.fumeology_record.length
    end

    it 'should strip new line \n from reading file' do
      player.load_points_from_file("#{file_path}mint.csv")
      point = player.fumeology_record.first
      assert_equal 'Peppermint', point.herb_combination.first, 'Herbs should not trail new lines'
    end

    it 'should be case independent' do
      player.load_points_from_file("#{file_path}combinations2.csv")
      assert_equal 5, player.fumeology_record.length
    end

    it 'should not throw an error or add duplicates when file contains them' do
      player.load_points_from_file("#{file_path}combinations3.csv")
      assert_equal 3, player.fumeology_record.length
    end

    it 'should not allow duplicate fumeology points in file, due to case' do
      player.load_points_from_file("#{file_path}combinations4.csv")
      assert_equal 4, player.fumeology_record.length, 'It loaded the herb aloe and Aloe as different valid herbs'
    end

    # Specifically:-
    # Load no empty lines
    # Load no nil herbs
    # Load no white space herbs
    it 'should not let nil values in file interfere with Fumeology records' do
      player.load_points_from_file("#{file_path}combinations5.csv")
      player.fumeology_record.each do |point|
        assert_equal 2, point.herb_combination.length, "This line: #{point.herb_combination.to_s} did not load correctly"
      end
      assert_equal 4, player.fumeology_record.length, 'Empty lines may have been loaded'
    end

    it 'should not load a non-existing file' do
      assert_nil player.load_points_from_file("#{file_path}nosuchfile"), 'Should not load non-existing files'
    end

    it 'should not add to fumeology changes variable on loading from file' do
      player.load_points_from_file("#{file_path}combinations5.csv")
      assert_equal [], player.fumeology_changes, 'Loading fumeology points is not a change in the record'
    end

    it 'should not load points that is in the player fumeology record already' do
      fp = FumeologyPoint.new(['Cardamom', 'Aloe'])
      player.update_record(fp)
      player.load_points_from_file("#{file_path}combinations3.csv")
      player.fumeology_record.each_with_index do |current, i|
        current_herbs = current.herb_combination
        player.fumeology_record.each_with_index do |verify, j|
          # binding.pry
          if i != j && current_herbs == verify.herb_combination
            assert false
          end
        end
      end
    end

    it 'should not load combinations where herbs are not valid herbs' do
      player.load_points_from_file("#{file_path}invalid-combinations.csv")
      assert_equal 1, player.fumeology_record.length
    end

    it 'should return nil if all records loaded correctly' do
      assert_nil player.load_points_from_file("#{file_path}combinations1.csv")
    end

    it 'should return the faulty herb combinations where the records did not load correctly' do
      output = player.load_points_from_file("#{file_path}invalid-combinations-brief.csv")
      assert_equal [['not valid']], output
    end

  end

  describe '#save_points_to_file' do
    let(:player) { Player.new }
    let(:file_path) { 'seeds/' }
    let(:fp1) { FumeologyPoint.new(['Aloe']) }
    let(:fp2) { FumeologyPoint.new(['Cardamom']) }
    let(:fp3) { FumeologyPoint.new(['Cardamom', 'Aloe']) }
    let(:fume_change) { [fp3] }

    it 'should save a file with players fumeology record, listing herb names and combinations per row' do
      player.update_record(fp1)
      player.update_record(fp2)
      player.save_points_to_file("#{file_path}player_combinations.csv") # I could break file handling out as a different class
      player2 = Player.new
      player2.load_points_from_file("#{file_path}player_combinations.csv")
      assert_equal 2, player2.fumeology_record.length
    end

    it 'should add new points to an existing file, if requested' do
      path = "#{file_path}player_combinations2.csv"
      player.update_record(fp1)
      player.save_points_to_file(path)
      player2 = Player.new
      player2.update_record(fp2)
      player2.save_points_to_file(path, {operation: 'a'}) # a for append
      player2.load_points_from_file(path)
      assert_equal 2, player2.fumeology_record.length
      assert_equal 1, player.fumeology_record.length
      player3 = Player.new
      player3.update_record(fp3)
      player3.save_points_to_file(path, operation: 'a')
      player3.load_points_from_file(path)
      assert_equal 3, player3.fumeology_record.length
    end

    it 'should not create duplicate in file when adding to a file' do
      # assert false

      skip
      current_path = "#{file_path}combinations3.csv"
      player.update_record(fp3)
      player.load_points_from_file(current_path)

      skip
      ply2 = Player.new
      ply2.update_record(fp1)
      ply2.save_points_to_file(path, operation: 'a')
      ply3 = Player.new
      ply3.load_points_from_file(path)
      assert_equal 1, ply3.fumeology_record.length

    end
  end


  describe '#find_point_from_file' do
    let(:player) { Player.new }
    let(:file_path) { 'seeds/' }
    let(:fp1) { FumeologyPoint.new(['Aloe']) }
    let(:fp2) { FumeologyPoint.new(['Cardamom']) }
    let(:fp3) { FumeologyPoint.new(['Cardamom', 'Aloe']) }

    #maybe
  end

end
