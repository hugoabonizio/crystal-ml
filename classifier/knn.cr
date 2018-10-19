module Classifier
  class KNN
    @x_data : Array(Array(Float64))? = nil
    @y_data : Array(Int32)? = nil

    def initialize(@k = 3)
    end

    def fit(x, y)
      @x_data = x
      @y_data = y
    end

    def predict(x : Array(Array(Float64)))
      x.map do |instance|
        neighbors_ids = neighbors(instance).map(&.first)
        neighbors_classes = Array(Int32).new(@k)

        # puts "ids: #{neighbors_ids}"
        @y_data.not_nil!.each.with_index do |instance, index|
          neighbors_classes << instance if neighbors_ids.includes? index
        end

        major_class = neighbors_classes.max_by { |i| neighbors_classes.count(i) }
        # puts "#{neighbors_classes} #{major_class}"
        major_class
      end
    end

    private def neighbors(instance : Array(Float64))
      neighbors = Array(Tuple(Int32, Float64)).new(@k)

      # FIXME slow
      @x_data.not_nil!.each.with_index do |point, point_index|
        distance = Math.sqrt(point.map_with_index { |p, index| ((p - instance[index]) ** 2).as(Float64) }.sum)
        neighbors.sort_by! &.last

        if neighbors.size < @k || distance < neighbors.last.last
          neighbors.pop if neighbors.size == @k
          neighbors << {point_index, distance}
        end
      end
      neighbors
    end
  end
end
