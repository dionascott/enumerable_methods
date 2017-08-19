module Enumerable
  def my_each
    i = 0
    while i < self.length
      yield(self[i])
      i += 1
    end
  end

  def my_each_with_index
    i = 0
    while i < self.length
      yield(self[i],i)
      i+= 1
    end
  end

  def my_select
    new_array = []
    self.my_each do |x|
      if yield(x)
        new_array << x
      end
    end
    new_array
  end

  def my_all?
    array_false = self.my_select{|x| yield(x)}
    if array_false.length < self.length
      false
    else
      true
    end
  end

  def my_any?
    any = self.my_select{|x| yield(x)}
    if any[0] == nil
      false
    else
      true
    end
  end

  def my_none?
    none = self.my_select{|x| yield(x)}
    if none[0] == nil
      true
    else
      false
    end
  end

  def my_count
    self.length
  end

  def my_map(&proc)
    array = []
    self.each{|x| array << proc.call(x)}
    array
  end

  def my_inject(accumulator=0)
    self.my_each do |x|
      accumulator = yield(accumulator,x)
    end
    accumulator
  end

end

[1,2,3,4].my_each{|x| puts x}
[1,2,3,4].each{|x| puts x}
puts "\n"
[1,2,3,4].my_each_with_index{|x,y| puts "#{y}: #{x}"}
[1,2,3,4].each_with_index{|x,y| puts "#{y}: #{x}"}
puts "\n"
puts [1,2,3,4].my_select{|x| x%2==0}
puts [1,2,3,4].select{|x| x%2==0}
puts "\n"
puts [1,2,3,4].my_all?{|x| x.is_a? Integer}
puts [1,2,3,4].all?{|x| x.is_a? Integer}
puts "\n"
puts [1,2,3,4].my_any?{|x| x > 5}
puts [1,2,3,4].any?{|x| x > 5}
puts "\n"
puts [1,2,3,4].my_none?{|x| x%2 == 0}
puts [1,2,3,4].none?{|x| x%2 == 0}
puts "\n"
puts [1,2,3,4].my_count
puts [1,2,3,4].count
puts "\n"
puts [1,2,3,4].my_map{|x| x * 2}
puts [1,2,3,4].map{|x| x * 2}
puts "\n"
puts [1,2,3,4].my_inject(1){|x,n| x * n}
puts [1,2,3,4].inject(1){|x,n| x * n}
puts "\n"
def multiply_els(array)
  puts array.my_inject(1){|accumulator,x| accumulator * x}
end
multiply_els([2,4,5]) #=> 40
puts "\n"
mult = Proc.new {|x| x * 5}
puts [1,2,3,4].my_map(&mult)
