#http://computing.dcu.ie/~humphrys/Notes/Neural/single.neural.html

class Perceptron

  attr_accessor  :m, :n, :neurons

  #n - число нейронов
  #m - число входов каждого нейрона скрытого слоя

  def initialize n, m
    @n = n
    @m = m
    @neurons = []
    @n.times do |w|
      @neurons << Neuron.new(m)
    end
  end

  #Распознавание образа
  # x - входной вектор
  # return - выходной образ

  def recognize x
     y = []
     @neurons.each_with_index do |neuron, i|
       y[i] = neuron.transfer(x)
     end
     y
  end

  #
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
     break if equal(t, y)
      #подстройка весов каждого нейрона
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
    total = 0
    x.each_with_index do |obj, i|
      total = total + obj * @w[i]
    end
    total
  end

  def init_weights n=10
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

  def activator nec
    nec >= @s ?  1 : 0
  end

end

perc = Perceptron.new 3, 3
perc.init_weights()
perc.teach([1,1,1], [0, 1, 0])
puts perc.recognize([1,1,1])
