module My_Enumerables

    #my each method
    def my_each
        puts "Please provide an array" unless self.is_a? Array 
        return to_enum unless block_given?

        self.size.times do |n|
            yield self[n]
        end  
    end

    #my each with index method
    def my_each_with_index
        return to_enum unless block_given?

        # if self.is_a? Array do |n, i|
            n = 0
                while n < (self.length)
                    yield(self[n], n)  
                    n += 1     
                end
            # end
        # end
    end


end
    
    
# def my_select(arr)
#     my_each(arr) do |n|
#         yield if (arr[n])
#     end
# end

class Array
    include My_Enumerables
end

obj = {a: 1, b: 2, c: 3, d: 4}

arr = [3, 56, 8, 4, 1, 7, 34]

[3, 56, 8, 4, 1, 7, 34].my_each_with_index {|item, index| puts "#{item} is located at index #{index}"}

