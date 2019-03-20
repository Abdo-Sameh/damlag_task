require 'benchmark'

class StackNode
  attr_accessor :max, :value, :cumulative
  def initialize(value, max, cum)
    @value = value
    @max = max
    @cumulative = cum
  end
end


class Stack

  def initialize
    @stack = []
  end

  def push(number)
    if @stack.empty?
      node = StackNode.new(number, number, number)
    else
      max_val = [number, @stack.last.max].max
      node = StackNode.new(number, max_val, @stack.last.cumulative + number)
    end
    @stack.push(node)
  end

  def pop
    return "Stack is empty!!" if @stack.empty?
    last_node = @stack.pop
    if @stack.length > 1
      @stack.last.cumulative = last_node.cumulative - last_node.value
    end
    last_node.value
  end

  def max
    return "Stack is empty!!" if @stack.empty?
    @stack.last.max
  end

end

class Extras < Stack

  def mean
    return "Stack is empty!!" if @stack.empty?
    @stack.last.cumulative / @stack.length.to_f
  end

end

stack = Extras.new
10000000.times do
  stack.push(Random.rand(1..1000))
end

max_time = Benchmark.measure {
  puts "Max: " + stack.max.to_s
}
puts "Max Time " + max_time.real.to_s

mean_time = Benchmark.measure {
  puts "Mean: " + stack.mean.to_s
}
puts "Mean Time " + mean_time.real.to_s
