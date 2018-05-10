require_relative '../src/fumeology_point'

gem 'pry'
require 'pry'

# This class represent the player using the memorizer.
# Player will be able to keep a record of fumeology points,
# update the record, and load a list of records from its herb names.
# Changes made of the record will be kept in memory, as they may
# individually be inserted in a spreadsheet in future implementation.
class Player

  attr_reader :name, :fumeology_score, :fumeology_record, :fumeology_changes

  def initialize(name = 'NotTeppy')
    @name = name
    @fumeology_record = []
    @fumeology_score = @fumeology_record.length
    @fumeology_changes = []
  end

  def update_record(point, method = nil)
    if is_valid?(point)
      @fumeology_record << point
      @fumeology_changes << point unless method == :load
      @fumeology_score = @fumeology_record.length
    else
      return
    end
    return point
  end

  # THIS IS FAULTY?
  def update_record_from_list_of_herbs(list_of_names)
    list_of_names.each do |herb_list|
      point = nil
      herb_list.each do |herb_name|
        unless point
          point = FumeologyPoint.new([herb_name])
        else
          point.add(herb_name)
        end
      end
      update_record(point)
    end
  end

  def load_points_from_file(file_name)
    failed_data = []
    # puts Dir.pwd, file_name
    return unless File.file?(file_name)
    file = File.open(file_name)
    file.each do |line|
      next if line.empty?
      combination = line.split(',').map! {|x| x.chomp.strip}.reject { |x| x == '' || x.nil? } # removed "\n", leading/trailing whitespace, and nil herbs
      combination.each do |herb|
        if Herbs.correct_case(herb).nil?
          failed_data << combination
          combination = [] # this is dodgy, mid-each loop
          break
        end
      end
      update_record(FumeologyPoint.new(combination), :load) unless combination.empty?
    end
    return nil if failed_data.empty?
    failed_data
  end

  # Player may save their points
  # - After adding herbs only
  # - After loading then adding herbs
  # - After ... adding herbs, saving, and adding more herbs
  def save_points_to_file(file_name, options = {operation: 'w'}) # w for write
    record = @fumeology_record
    record = @fumeology_changes if options[:operation] == 'a'
    open(file_name, options[:operation]) do |f|
      record.each do |point|
        line = ''
        point.herb_combination.each do |herb|
          line << "#{herb}"
          line << ', ' unless point.herb_combination.last == herb
        end
        f << "#{line}\n"
      end
    end
    file_name
  end

  private

  def is_valid?(point)
    # Compare with other points in record
    @fumeology_record.each do |fume_point|
      return false if fume_point == point || fume_point.equal?(point)
    end
    # Ensure the point can be created?
    true
  end

end