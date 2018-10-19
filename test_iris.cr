require "csv"
require "./model_selection/*"
require "./classifier/*"
require "./preprocessing/*"
require "./metrics/*"

data = CSV.parse(File.read("./Iris.csv"))[1..-1] # skip first row
x = data.map { |i| i[1...-1] }                   # skip first column (index)
y = data.map { |i| i[-1] }                       # only last column (class)

x = x.map { |i| i.map(&.to_f) }

encoder = Preprocessing::LabelEncoder.new
y = encoder.fit_transform(y)

x_train, x_test, y_train, y_test = ModelSelection.train_test_split(x, y)

classifier = Classifier::KNN.new(k: 7)
classifier.fit(x_train, y_train)
y_predict = classifier.predict(x_test)

puts Metrics.accuracy(y_test, y_predict)
