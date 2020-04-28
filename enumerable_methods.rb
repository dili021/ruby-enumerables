module Enumerable
  def my_each
    return to_enum unless block_given?

    size.times do |n|
      yield to_a[n]
    end
    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    n = 0
    while n < to_a.length
      yield(to_a[n], n)
      n += 1
    end
    self
  end

  def my_select
    return to_enum unless block_given?

    selected = is_a?(Array || Range) ? [] : {}
    if is_a?(Array)
      my_each do |i|
        selected.push(i) if yield(i)
      end
    else
      my_each do |key, val|
        selected[key] = val if yield(key, val)
      end
    end
    selected
    end

  def my_all?(pattern = nil)
    result = true
    my_each do |i|
      case pattern
      when nil
        result = false unless i
      when Regexp
        result = false unless i.to_s.match(pattern)
      when Class
        result = false unless i.is_a?(pattern)
      when String, Numeric
        result = false unless i == pattern
      end
      result = yield(i) if block_given? && pattern.nil?
      break unless result
    end
    result
  end

  def my_any?(pattern = nil)
    result = false
    my_each do |i|
      case pattern
      when nil
        result = true if i
      when Regexp
        result = true if i.match(pattern)
      when Class
        result = true if i.is_a?(pattern)
      when String, Numeric
        result = true if i == pattern
      end
      result = yield(i) if block_given?
      break if result
    end
    result
  end

  def my_none?(pattern = nil)
    result = true
    my_each do |i|
      case pattern
      when nil
        result = false if i
      when Regexp
        result = false if i.match(pattern)
      when Class
        result = false if i.is_a?(pattern)
      when String, Numeric
        result = false if i == pattern
      end
      result = !yield(i) if block_given?
      break unless result
    end
    result
  end

  def my_count(check = nil)
    counter = 0
    my_each do |i|
      counter += 1 if block_given? && yield(i)
      counter += 1 if check == i
      counter = size if check.nil? && !block_given?
    end
    counter
  end

  def my_map(_arg = nil)
    return to_enum unless block_given?

    result = []
    my_each do |i|
      result.push(yield(i)) if block_given?
    end
    result
  end

  def my_inject(param1 = nil, param2 = nil)
    start = 0
    start = '' if self[0].is_a?(String)
    start = param1 if param1.is_a?(Numeric)
    start = param2 if param2.is_a?(Numeric)
    acc = start if start.is_a?(Numeric) || start.is_a?(String)
    sym = param1 if param1.is_a?(Symbol)
    sym = param2 if param2.is_a?(Symbol)
    to_a.length.times.my_each do |i|
      acc = yield(acc, to_a[i]) if block_given?
      acc = acc.send(sym, to_a[i]) if (param1.is_a?(Symbol) && param2.nil?) || (param2.is_a?(Symbol) && param1.nil?)
      acc = acc.send(sym, to_a[i]) if (param1.is_a?(Symbol) && !param2.nil?) || (param2.is_a?(Symbol) && !param1.nil?)
    end
    acc
  end

  def my_multiply_els
    my_inject(1){|acc, elem| acc * elem }
  end

end

cubed = proc { |n| n * 3 }

