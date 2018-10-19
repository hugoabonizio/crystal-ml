module Preprocessing
  class LabelEncoder
    def fit_transform(x : Array(String))
      unique = Set.new(x).to_a
      Array(Int32).new(x.size) do |i|
        unique.index(x[i]) || raise Exception.new
      end
    end
  end
end
