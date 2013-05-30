require_relative "neuron.rb"
class Perceptron

  # n - число нейронов
  # m - число входов каждого нейрона скрытого слоя
  def initialize n, m
    @neurons = []
    n.times do |w|
      @neurons << Neuron.new(m)
    end
  end

  # Распознавание образа
  # x - входной вектор
  # return - выходной образ

  def recognize x
    @neurons.each_with_index.map do |neuron, i|
      neuron.transfer(x)
    end
  end

  # Инициализация начальных весов
  # малым случайным значением

  def init_weights
    @neurons.each(&:init_weights)
  end

  # Обучение перцептрона
  # param x - входной вектор
  # param y - правильный выходной вектор

  def teach(x, y)
    d = 0
    v = 1 # скорость обучения
    t = recognize(x)
    loop do
      break if equal(t, y) #cancel learning

      # подстройка весов каждого нейрона
      @neurons.each_with_index do |neuron, i|
        d = y[i] - t[i]
        neuron.change_weights(v, d, x)
      end

      t = recognize(x)
    end
  end

  # Сравнивание двух векторов
  # a - первый вектор
  # b - второй вектор

  def equal(a, b)
    return false if a.length != b.length
    a.each_with_index do |obj, i|
      return false if obj != b[i]
    end
    true
  end
end

perc = Perceptron.new 8, 8
perc.init_weights()
perc.teach([1, 0, 1, 0, 1, 0, 1, 0], [0, 1, 1, 1, 1, 1, 1, 1])
perc.teach([0, 0, 0, 0, 0, 0, 0, 1], [1, 1, 1, 1, 1, 1, 1, 1])
puts "first vector [1, 0, 1, 0, 1, 0, 1, 0] - [0, 1, 1, 1, 1, 1, 1, 1]"
puts perc.recognize([1, 0, 1, 0, 1, 0, 1, 0])
puts "\n next vector [0, 0, 0, 0, 0, 0, 0, 1] - [1, 1, 1, 1, 1, 1, 1, 1]"
puts perc.recognize([0, 0, 0, 0, 0, 0, 0, 1])