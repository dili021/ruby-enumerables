module My_Enumerables

    #my each 
    def my_each
        to_enum if !block_given?
        self.size.times do |n|
            yield self[n]
        end  
        self
    end

    #my_each_with_index
    def my_each_with_index
        to_enum if !block_given?
        n = 0
        while n < (self.length)
            yield(self[n], n)  
            n += 1     
        end
        self
    end

    #my_select
    def my_select
        to_enum if !block_given?
        selected = []
        self.my_each do |i|
            selected.push(i) if yield(i)
        end
        selected
    end

    #my_all?
    def my_all?
        result = true
        self.my_each do |i|
            result = false unless yield(i)
        end        
        result
    end

    #my_any?
    def my_any?
        result= false
        self.my_each do |i|
            break if result
            (block_given? && yield(i)) || (!block_given? && i) ? result = true : result = false
        end
        p result
    end

    #my_none?
    def my_none?
        result = true
        self.my_each do |i|
            break if result
            (!block_given? && i) || (block_given? && yield(i)) ? result = false : result = true
        end
    end

    #my_count
    def my_count(n= nil)
        counter= 0
        self.my_each do |i|
            if block_given? && yield(i) 
                counter += 1
            elsif n == nil && block_given? == false
                counter = self.size
            elsif n.is_a?(Integer) && n == i
                counter += 1 
            end
        end
        counter
    end

    #my_map
    def my_map
        result= []
        self.my_each do |i|
            block_given? ? result.push(yield(i)) : to_enum
        end
    p result
    end

    #my_inject
    def my_inject(accumulator = self[0])
        self.size.times do |previous, current|
            yield 
        end
    end
end

#Proc for my_map as requested in the project assignment 
cubed = Proc.new {|i| i**3}

class Array
    include My_Enumerables
end

obj = {a: 1, b: 2, c: 3, d: 4}

arr = [3, 56, 8, 4, 5, 5, 5, 1, 2, 5]
words = ["ant", "bear", "cat"]
arr.my_inject {|a, b| a+b}