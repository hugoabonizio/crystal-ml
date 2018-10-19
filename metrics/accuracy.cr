module Metrics
  def self.accuracy(y_true, y_pred)
    raise Exception.new if y_true.size != y_pred.size

    correct_count = 0
    y_true.each_with_index do |_, i|
      correct_count += 1 if y_true[i] == y_pred[i]
    end

    correct_count.to_f / y_true.size
  end
end
