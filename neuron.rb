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
  attr_accessor :w, :s

  def initialize count
    @s = 50
    @count = count
    @w = []
  end

  def transfer(x)
    activator(adder(x))
  end


  #Сумматор
  #x - входной вектор
  #return - невзвешенная сумма nec (биас не используется)
  def adder(x)
    x.each.inject(0){ |total, i| nec + x[i] * @w[i] }
  end

  def init_weights n
    rand = Random.new
    @count.times do |i|
      @w[i] = rand(n)
    end
  end

  #Модификация весов синапсов для обучения
  #v - скорость обучения
  #d - разница между выходом нейрона и нужным выходом
  #x - входной вектор
  def change_weights(v, d, x)
    @count.times do |i|
      @w[i] += v*d*x[i]
    end
  end

  #Нелинейный преобразователь или функция активации,
  #в данном случае - жесткая пороговая функция,
  #имеющая область значений {0;1}
  # nec - выход сумматора

  def activator(nec)
    nec >= @s ?  1 : 0
  end

end

# Neuron.new(4).init_weights(10)

# perc = Perceptron.new [1, 1, 1, 0], [1, 0, 1, 1]
# perc.threshold = 2
# puts perc.output