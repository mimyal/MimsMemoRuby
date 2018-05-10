require_relative 'herb'

# This class represents each point gained from smoking. It contains the combination of herbs.
# Each point should initialize with a valid combination of herbs.
# The herb names must be loaded as an array of lower case strings.
class FumeologyPoint

  attr_reader :herb_combination

  def initialize(herbs)
    if herbs.class != Array
      raise Exception, 'Herbs must be loaded as Array'
    elsif !valid_combination?(herbs)[0]
      raise Exception, valid_combination?(herbs)[1]
    else
      @herb_combination = herbs.map! { |herb| Herbs.correct_case(herb) }
    end
    raise Exception, 'Fumeology points must include herbs' if herbs.empty?
  end

  def add(herb) # herb name string
    begin
      Herbs.correct_case(herb)
    rescue Exception
      # Will return without adding the new herb unless found in Herbs.
      return @herb_combination
    end
    combination = @herb_combination + [herb] # to avoid a string shuffle
    valid = valid_combination?(combination)
    unless valid[0]
      raise Exception, valid[1]
    end
    @herb_combination << Herbs.correct_case(herb)
  end

  # Compares another point with this point
  # Returns true if the two points carry the same combination
  # Returns false if the two points are different
  def equal?(point)
    output = false
    herb_names = []
    return false if @herb_combination.length != point.herb_combination.length
    @herb_combination.each do |herb|
      herb_names << herb
    end
    point.herb_combination.each do |included_herb|
      if herb_names.include?(included_herb)
        output = true
      else
        return false
      end
    end
    return output
  end

  private

  # The combination of herbs are loaded by herb name, not their object.
  def valid_combination?(combination)
    names = []
    return false, 'Herb combinations cannot include more than three herbs' if combination.length > 3
    combination.each do |included_herb|
      return false, 'Herb cannot be empty string' if included_herb == ''
      return false, "This herb is unknown: '#{included_herb}' and the combination failed" unless Herbs.correct_case(included_herb)
      names << included_herb unless names.include?(included_herb)
    end
    return false, 'Herb cannot be used twice' if names.length != combination.length

    return true, 'This herb was added to the combination.'
  end


end