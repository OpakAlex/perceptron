#http://computing.dcu.ie/~humphrys/Notes/Neural/single.neural.html

class Perceptron
  
  attr_accessor  :threshold, :inputs
  
  def initialize inputs, weights
    @inputs = inputs
    @neurons = weights.map do |w|
      Neuron.new(w)
    end
  end
  
  def output
      val = @inputs.zip(@neurons.map(&:w)).inject(0) { |total, i| 
        total + i[0] * i[1]
      }
      val < @threshold ? false: true
    end
end

class Neuron
  attr_accessor :w 
  
  def initialize w
    @w = w
  end
  
end

#input vecrors:
# 1001, 1011, 0001, 0011

perc = Perceptron.new [1, 1, 1, 0], [1, 0, 1, 1]
perc.threshold = 2
puts perc.output