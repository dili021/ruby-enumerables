module My_Enumerables

    #my each 
    def my_each
        return to_enum unless block_given?
        self.size.times do |n|
            yield self[n]
        end  
        self
    end

    #my_each_with_index
    def my_each_with_index
        return to_enum unless block_given?
        n = 0
        while n < (self.length)
            yield(self[n], n)  
            n += 1     
        end
        self
    end

    #my_select
    def my_select
        return to_enum unless block_given?
        selected = []
        self.my_each do |i|
            selected.push(i) if yield(i)
        end
        selected
    end

    #my_all?
    def my_all?
        return to_enum unless block_given?
        result = true
        self.my_each do |i|
            result = false unless yield(i)
        end        
        result
    end

    #my_any?
    def my_any?
        return to_enum unless block_given?
        result = false
        self.my_each do |i|
            if yield(i) 
                result = true
                break
            end
        end
        result
    end

    #my_none?
    def my_none?
        return to_enum unless block_given?
        result = true
        self.my_each do |i|
            if yield(i)
                result = false
                break
            end
        end
        result
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
        p counter
    end
end
    

class Array
    include My_Enumerables
end

obj = {a: 1, b: 2, c: 3, d: 4}

arr = [3, 56, 8, 4, 5, 5, 5, 1, 2, 5]

# arr.my_each_with_index {|item, index|  "#{item} is located at index #{index}"}

arr.my_count{|i| i.odd?}
