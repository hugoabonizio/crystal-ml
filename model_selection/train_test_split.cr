module ModelSelection
  def self.train_test_split(x : Array(T), y : Array(U), test_size = 0.3) forall T, U
    raise Exception.new if x.size != y.size

    # FIXME ugly
    indexes = (0...x.size).to_a
    shuffled = indexes.shuffle
    x_test = Array(T).new
    y_test = Array(U).new
    x_train = Array(T).new
    y_train = Array(U).new
    shuffled.each do |i|
      if y_test.size > test_size * y.size
        x_train << x[i]
        y_train << y[i]
      end

      x_test << x[i]
      y_test << y[i]
    end
    {x_train, x_test, y_train, y_test}
  end
end
