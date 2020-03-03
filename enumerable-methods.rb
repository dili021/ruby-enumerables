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
        hash_result = []
        while n < (self.to_a.length)
            yield(self.to_a[n], n)
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
    end

    #my_any?
    def my_any?
        result= false
        self.my_each do |i|
            break if result
            result = (block_given? && yield(i)) || (!block_given? && i) ? true : false
        end
        result
    end

    #my_none?
    def my_none?
        result = true
        self.my_each do |i|
            break if result
            result = (!block_given? && i) || (block_given? && yield(i)) ? false : true
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
        result
    end
    
    #Proc for my_map as requested in the project assignment 
    cubed = Proc.new {|i| i**3}

    #my_inject
    def my_inject(start = nil)
        acc = start ? start : 0
        self.my_each do |i|
            acc = yield(acc, i)
        end
    end
    
    #multiply_els method for testing my_inject
    def multiply_els
        self.my_inject(1) {|acc, i| acc * i}
    end
end