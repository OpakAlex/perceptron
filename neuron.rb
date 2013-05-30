#http://computing.dcu.ie/~humphrys/Notes/Neural/single.neural.html

class Neuron

  attr_accessor :w, :s

  def initialize count
    @s = 50 #default
    @count = count
    @w = []
  end

  def transfer(x)
    activator(adder(x))
  end

  # Сумматор
  # x - входной вектор
  # return - невзвешенная сумма nec (биас не используется)
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

  # Модификация весов синапсов для обучения
  # v - скорость обучения
  # d - разница между выходом нейрона и нужным выходом
  # x - входной вектор
  def change_weights(v, d, x)
    @w.each_with_index do |_, i|
      @w[i] += v*d*x[i]
    end
  end

  # Нелинейный преобразователь или функция активации,
  # в данном случае - жесткая пороговая функция,
  # имеющая область значений {0;1}
  # nec - выход сумматора

  def activator nec
    nec >= @s ?  1 : 0
  end
end
