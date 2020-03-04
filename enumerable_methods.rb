module Enumerable
  # my each
  def my_each
    to_enum unless block_given?
    size.times do |n|
      yield to_a[n]
    end
    self
  end

  # my_each_with_index
  def my_each_with_index
    to_enum unless block_given?
    n = 0
    while n < to_a.length
      yield(to_a[n], n)
      n += 1
    end
    self
  end

  # my_select
  def my_select
    to_enum unless block_given?
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

  # my_all?
  def my_all?(pattern = nil)
    result = true
    my_each do |i|
      if block_given?
        result = false unless yield(i)
      elsif pattern.is_a?(Regexp)
        result = false unless i.to_s.match(pattern)
      elsif pattern.is_a?(Class)
        result = false unless i.is_a?(pattern)
      else
        result = false unless i
      end
      break if result != true
    end
    result
  end

  # my_any?
  def my_any?(pattern = nil)
    result = true
    my_each do |i|
      if block_given?
        result = false unless yield(i)
      elsif pattern.is_a?(Regexp)
        result = false unless i.to_s.match(pattern)
      elsif pattern.is_a?(Class)
        result = false unless i.is_a?(pattern)
      else
        result = false unless i
      end
      break if result != true
    end
    result
  end

  # my_none?
  def my_none?(pattern = nil)
    result = true
    my_each do |i|
      if block_given?
        result = false if yield(i)
      elsif pattern.is_a?(Regexp)
        result = false if i.to_s.match(pattern)
      elsif pattern.is_a?(Class)
        result = false if i.is_a?(pattern)
      elsif i
        result = false
      end
      break if result
    end
    result
  end

  # my_count
  def my_count(check = nil)
    counter = 0
    my_each do |i|
      counter += 1 if block_given? && yield(i)
      counter += 1 if check == i
      counter = size if check.nil? && !block_given?
    end
    counter
  end

  # my_map
  def my_map
    result = []
    my_each do |i|
      block_given? ? result.push(yield(i)) : to_enum
    end
    result
  end

  # Proc for my_map as requested in the project assignment
  proc { |i| i**3 }

  # my_inject
  def my_inject(sym = nil, start = nil)
    start.nil? ? acc = first : start
    (1...to_a.length).my_each do |i|
      acc = yield(acc, to_a[i]) if block_given?
      acc = acc.send(sym, to_a[i]) if sym
    end
    acc
  end

  # multiply_els method for testing my_inject
  def multiply_els
    my_inject(1) { |acc, i| acc * i }
  end
end
