require_relative 'src/player'

class Memorizer

  attr_reader :player, :herb_combination

  # Class initializes with a string of herbs feeding to it.
  def initialize(herb_combination)
    @player = Player.new
    @herb_combination = herb_combination

    load_result = @player.load_points_from_file('points.csv') if File.file?('points.csv')

    puts "Not all data loaded correctly: #{load_result} were not recorded" if load_result

    begin

      true_combo = false
      herb_combination.each do |herb|
        if Herbs.correct_case(herb)
          true_combo = true
        else
          true_combo = false
          break
        end
      end

      player.update(FumeologyPoint.new([herb_combination])) if true_combo

      result = @player.save_points_to_file('points.csv', operations: 'a')

      puts 'RESULT', result

      puts "Memorizer should have saved data to 'points'csv':"

      @player.fumeology_record.each do |point|
        puts point.herb_combination
      end

    rescue Exception => message
      puts "There was an error: #{message}"
    end
  end

end


puts 'Welcome to my Memorizer. I am Mimyal.'

exit = false

while exit == false do

  puts 'If you smoked and gained a point, add it here, use commas between herbs:'
  output = gets.chomp

  if output == 'e' || output == 'exit' || output == 'quit' || output == 'q'
    exit = true
  else
    begin
      Memorizer.new(output.split(',').map! {|x| x.strip})
      puts 'Memorizer initiated'
    rescue Exception
      puts 'Use valid herb names, comma-separated. Or type QUIT to leave the program'
      next
    end
  end
end

puts 'Thank you. Come again.'

# player = Player.new

# player.load_points_from_file(MUST PUT FILE NAME HERE)

# record = player.fumeology_record

# 2.3.1 :047 > def list(record)
#   2.3.1 :048?>   record.each do |combo|
#     2.3.1 :049 >       puts combo.herb_combination
#     2.3.1 :050?>     end
#   2.3.1 :051?>   nil
#   2.3.1 :052?>   end


# def point(player, herb = nil)
#   2.3.1 :074?>   f = FumeologyPoint.new([herb]) if herb
#   2.3.1 :075?>   player.update_record(f) if herb
#   2.3.1 :076?>   list(player.fumeology_record)
#   2.3.1 :077?>   return player.fumeology_score
#   2.3.1 :078?>   end

# def suggestion(player, herb=nil)
#   2.3.1 :105?>   number = rand(Herbs.names.length - 1)
#   2.3.1 :106?>   record = []
#   2.3.1 :107?>   player.fumeology_record.each do |point|
#     2.3.1 :108 >       record << point.herb_combination
#     2.3.1 :109?>     end
#   2.3.1 :110?>   if record.include?(Herbs.names[number])
#                    2.3.1 :111?>     suggestion(player,herb)
#                    2.3.1 :112?>     end
#   2.3.1 :113?>   return Herbs.names[number]
#   2.3.1 :114?>   end