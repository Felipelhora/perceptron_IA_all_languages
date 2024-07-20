require 'time'

class Perceptron
  def initialize
    @neuro_inputs = [
      [0, 0],
      [0, 1],
      [1, 1],
      [1, 0]
    ]
    @weights = [0.0, 0.0]
    @learning_rate = 0.1
    @expected_outputs = [0, 0, 1, 0]
    @epochs = 0
  end

  def step(value_activation)
    value_activation >= 1 ? 1 : 0
  end

  def sum(neuro_input, weights)
    neuro_input[0] * weights[0] + neuro_input[1] * weights[1]
  end

  def run
    loop do
      total_error = 0
      @neuro_inputs.each_with_index do |neuro_input, index|
        sum_neuro = sum(neuro_input, @weights)
        activation = step(sum_neuro)
        error = (activation - @expected_outputs[index]).abs
        total_error += error
        @weights.each_with_index do |weight, index_|
          @weights[index_] += @learning_rate * neuro_input[index_] * error
        end
      end
      @epochs += 1
      puts @epochs
      break if total_error.zero?
    end
    { weights: @weights, epochs: @epochs }
  end
end

start_time = Time.now
perceptron = Perceptron.new
answer = perceptron.run
end_time = Time.now
execution_time = end_time - start_time
puts format('Execution Time: %.4f seconds', execution_time)
puts format('Weights: %.2f - %.2f\nEpochs: %d', answer[:weights][0], answer[:weights][1], answer[:epochs])
