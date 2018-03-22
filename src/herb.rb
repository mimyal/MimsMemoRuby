require_relative 'herbs'

# This class will instanciate for herbs as they are included
# It will raise an exception if herb is not known
class Herb
  attr_reader :name

  def initialize(herb_name)
    if is_valid?(herb_name)
      @name = herb_name
    else
      raise Exception, "This is not a valid herb: #{herb_name}"
    end
  end

  def equal?(herb)
    return false unless @name == herb.name
    true
  end

  private

  # @QUESTION Should this method be made public - or should this method be available in Herbs as #self.is_valid?
  def is_valid?(name)
    return true if Herbs.names.include?(name)
    false
  end

end