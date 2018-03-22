require_relative '../src/fumeology_point'
require 'minitest/autorun'

class TestFumeologyPoint < Minitest::Test

  describe '#initialize' do
    let(:herb) { 'Peppermint' }
    let(:herb2) { 'Bee Balm' }
    it 'should initialize an array of herb combinations' do
      fume_point = FumeologyPoint.new([herb])
      assert_equal [herb], fume_point.herb_combination
    end
    it 'should be possible to initialize with an array of completed herbs' do
      fume_point = FumeologyPoint.new([herb, herb2])
      assert_equal [herb, herb2], fume_point.herb_combination
    end
    it 'should throw an error if the initialization parameter is not an array' do
      proc { FumeologyPoint.new(herb) }.must_raise Exception
    end

    it 'should throw an error if the initialization parameter is empty' do
      proc { FumeologyPoint.new([]) }.must_raise Exception
    end

    it 'should throw an error if the same type of herb is used twice' do
      proc { FumeologyPoint.new([herb, 'Peppermint']) }.must_raise Exception, 'Same type of herb can only be used once'
    end

    it 'should throw an error if the input has more than three herbs' do
      herb3 = 'Cardamom'
      herb4 = 'Aloe'
      proc { FumeologyPoint.new( [herb, herb2, herb3, herb4]) }.must_raise Exception, 'Cannot combine more than three herbs.'
    end

    it 'should correct case for herb names with incorrect case' do
      herb3 = 'ALOE'
      fp1 = FumeologyPoint.new([herb3])
      herb4 = 'aloe'
      fp2 = FumeologyPoint.new([herb4])
      assert_equal fp1.herb_combination, fp2.herb_combination
      assert_equal ['Aloe'], fp1.herb_combination
    end

    it 'should throw an error if combination includes herbs with nil name' do
      proc { FumeologyPoint.new([nil]) }.must_raise Exception, 'Herbs must be named'
      proc { FumeologyPoint.new(['Peppermint',nil]) }.must_raise Exception, 'All herbs in combination must be named'
    end

    # This did not throw new exceptions at the time
    it 'should throw an error if combination includes herbs with no name (and empty string)' do
      proc { FumeologyPoint.new( ['']) }.must_raise Exception, 'Herbs must be named'
      proc { FumeologyPoint.new( [' ']) }.must_raise Exception, 'Herbs must be named with more than space'
    end

  end

  describe '#add(herb)' do
    let(:herb) { 'Peppermint' }
    let(:herb2) { 'Bee Balm' }
    let(:herb3) { 'Cardamom' }
    let(:herb4) { 'Aloe' }
    let(:fume_point) { FumeologyPoint.new([herb]) }

    it 'should add the herb to the list of herb combinations' do
      fume_point.add(herb2)
      assert_equal [herb, herb2], fume_point.herb_combination
    end

    it 'should raise an exception if herb combinations would become longer than than three' do
      fume_point.add(herb2)
      fume_point.add(herb3)
      assert_equal 3, fume_point.herb_combination.length
      proc { fume_point.add(herb4) }.must_raise Exception, 'Fumeology points can have max three herbs.'
    end

    it 'should raise an error if the same type of herb is added twice' do
      peppermint = 'Peppermint'
      proc { fume_point.add(peppermint) }.must_raise Exception, 'The same type of herb was used twice'
    end

    it 'should not add herbs that are unknown/invalid' do
      fp_length = fume_point.herb_combination.length
      fume_point.add('Daffodil')
      assert_equal fp_length, fume_point.herb_combination.length
    end

    it 'should correct case when herbs are added incorrectly' do
      fume_point.add('ALOE')
      fp2 = FumeologyPoint.new(['Peppermint', 'Aloe'])
      assert_equal fp2.herb_combination, fume_point.herb_combination
    end
  end

  describe '#equal?'  do
    let(:herb) { 'Peppermint' }
    let(:herb2) { 'Bee Balm' }
    let(:herb3) { 'Cardamom' }
    let(:herb4) { 'Aloe' }
    let(:fume_point) { FumeologyPoint.new([herb]) }
    let(:fume_point2) { FumeologyPoint.new([herb3]) }

    it 'should return true for herb combinations that are same' do
      fume_point3 = FumeologyPoint.new([herb])
      assert_equal true, fume_point.equal?(fume_point3), 'Obejcts are same'
      mint = 'Peppermint'
      fume_point4 = FumeologyPoint.new([mint])
      assert_equal true, fume_point.equal?(fume_point4), 'Names are same'
      fume_point.add(herb3)
      fume_point2.add(herb)
      assert_equal true, fume_point.equal?(fume_point2), 'Same herbs, different order'
    end

    it 'should return false for herb combinations that are different' do
      fume_point2.add(herb)
      fume_point3 = FumeologyPoint.new([herb2, herb3])
      assert_equal false, fume_point3.equal?(fume_point2), 'BB/Card vs Card/PM'
      assert_equal false, fume_point.equal?(fume_point2), 'PM only vs Card/PM'
      assert_equal false, fume_point3.equal?(fume_point), 'BB/Card vs PM only'
      assert_equal false, fume_point.equal?(fume_point2), 'PM only vs Card/PM'
    end

  end

end