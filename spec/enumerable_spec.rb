require './enumerable_methods'

describe Enumerable do
  let(:array1) { [1, 2, 3, 4, 5, 6, 7] }
  let(:array2) { [1, 4, 5151, -15, -300, 10] }
  let(:array3) { [1, '1', 'one', false, nil] }
  let(:hash1) { { one: 1, two: 2, three: 3, four: 4 } }
  let(:demo) { [] }

  describe '#my_each' do
    it 'iterates through all the items in an enumerable object' do
      expect(array1.my_each { |n| n }).to eq(array1.each { |i| i })
    end
    it 'can apply methods and operations on the item' do
      expect(array2.my_each { |n| demo.push(n) }). to eq(demo)
    end
  end

  describe 'my_each_with_index' do
    it 'can apply methods on the indexes in an enumerable object' do
      array1.my_each_with_index { |_i, ind| demo << ind }
      expect(demo).to eq([0, 1, 2, 3, 4, 5, 6])
    end

    it 'can apply methods on items and their indexes in an enumerable object' do
      expect(hash1.my_each_with_index { |key, val| key.to_s + val.to_s }).to eq(hash1.each_with_index { |n, i| n.to_s + i.to_s })
    end
  end

  describe 'my_select' do
    it 'can select items based on criteria passed in a block' do
      demo = array3.my_select { |item| item }
      expect(demo).to eq([1, '1', 'one'])
    end
    it 'raises en error when used on a non-enumerable object' do
      error_case = 100
      expect{error_case.my_select{|item| item < 200}}.to raise_error(NoMethodError)
    end
  end

  describe 'my_all?' do
    it 'returns true if all items passed to a block evaluate to true' do
      expect(array3.my_all? { |item| item.is_a?(Integer) }).to eq(false)
    end
    it 'returns true if all items match a pattern when a pattern is given' do
      expect(array1.my_all?(/\d/)).to eq(true)
    end
  end

  describe 'my_any?' do
    it 'returns true if any item passed to a block evaluates to true' do
      expect(array3.my_any?(&:positive?)).to eq(true)
    end
    it 'returns true if any item matches a pattern when a pattern is given' do
      expect(array2.my_all?(String)).to eq(false)
    end
  end

  describe 'my_none?' do
    it 'returns true if no item passed to a block evaluates to true' do
      expect(hash1.my_none? { |item| item.include?(Symbol) }).to eq(true)
    end
    it 'returns true if no item matches a pattern when a pattern is given' do
      expect(array3.my_none?(nil)).to eq(false)
    end
    it 'raises an error when more than one argument is given' do
      expect{array2.my_none?(1,2)}.to raise_error(ArgumentError)
    end
  end

  describe 'my_count' do
    it 'returns the number of items in a enumerable if no block or pattern is given' do
      expect(array3.my_count).to eq(5)
    end
    it 'returns the number of items that are equal to a passed argument' do
      expect(array3.my_count(1)).to eq(1)
    end
    it 'returns the number of items that evaluate to true when a block is given' do
      expect(array1.my_count(&:odd?)).to eq(4)
    end
  end

  describe 'my_map' do
    it 'return the enumerator if no block is given' do
      expect(array1.my_map).to be_an(Enumerator)
    end
    it 'performs the operation provided in a block on each item in an array and returns a new one' do
      expect(array2.my_map { |item| item**2 }).to eq([1, 16, 26_532_801, 225, 90_000, 100])
    end
  end

  describe 'my_inject' do
    it 'combines all items using the operator passed as an argument' do
      expect(array1.my_inject(:+)).to eq(28)
    end
    it 'passes all items to the operation passed as a block' do
      expect(array2.my_inject { |acc, comparator| acc.to_s.length > comparator.to_s.length ? acc : comparator }).to eq(-300)
    end
    it 'takes an accumulator argument as a starting point and adds each item onto it using the operation passed as second argument or block' do
      expect(array1.my_inject(5, :+)).to eq(33)
    end
  end

  describe 'my_multiply_els' do
    it 'combines all items by multiplying them using the my_inject method' do
      expect(array1.my_multiply_els).to eq(5040)
    end
    it 'raises en error when used on a non-enumerable object' do
      error_case = 'Hello World'
      expect{error_case.my_multiply_els}.to raise_error(NoMethodError)
    end
  end

  

end
