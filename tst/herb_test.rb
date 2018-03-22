require_relative '../src/herb'
require 'minitest/autorun'

class HerbTest < Minitest::Test

  describe '#initialize' do
    it 'should have a name attribute belonging to the known herbs in class Herbs' do
      name = 'Peppermint'
      herb = Herb.new(name)
      assert_equal 'Peppermint', herb.name
      assert_equal true, Herbs.names.include?(herb.name)
    end

    it 'should raise an exception if the name attribute is invalid' do
      invalid_name = 'daffodil'
      proc { Herb.new(invalid_name) }.must_raise Exception, 'Herbs should be known'
    end
  end

  describe '#equal?' do
    let(:mint) { 'Peppermint' }
    let(:herb) { Herb.new(mint) }

    it 'should identify herb true as input if they have the same name' do
      duplicate_herb = Herb.new(mint)
      assert_equal true, herb.equal?(duplicate_herb)
    end

    it 'should identify herb false as input if their names are different' do
      another_herb = Herb.new('Aloe')
      assert_equal false, herb.equal?(another_herb)
    end
  end
end