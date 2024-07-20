import 'dart:io';
import 'dart:math';

class Perceptron {
  List<List<double>> neuroInputs;
  List<double> weights;
  double learningRate;
  List<int> expectedOutputs;
  int epochs;

  Perceptron()
      : neuroInputs = [
          [0.0, 0.0],
          [0.0, 1.0],
          [1.0, 1.0],
          [1.0, 0.0],
        ],
        weights = [0.0, 0.0],
        learningRate = 0.1,
        expectedOutputs = [0, 0, 1, 0],
        epochs = 0;

  int step(double valueActivation) {
    return valueActivation >= 1.0 ? 1 : 0;
  }

  double sum(List<double> neuroInput, List<double> weights) {
    return neuroInput[0] * weights[0] + neuroInput[1] * weights[1];
  }

  Map<String, dynamic> run() {
    while (true) {
      double totalError = 0.0;
      for (int i = 0; i < neuroInputs.length; i++) {
        List<double> neuroInput = neuroInputs[i];
        double sumNeuro = sum(neuroInput, weights);
        int activation = step(sumNeuro);
        double error = (activation.toDouble() - expectedOutputs[i]).abs();
        totalError += error;
        for (int j = 0; j < weights.length; j++) {
          weights[j] += learningRate * neuroInput[j] * error;
        }
      }
      epochs++;
      print(epochs);
      if (totalError == 0) {
        return {
          'weights': weights,
          'epochs': epochs,
        };
      }
    }
  }
}

void main() {
  final stopwatch = Stopwatch()..start();
  final perceptron = Perceptron();
  final result = perceptron.run();
  stopwatch.stop();
  final executionTime = stopwatch.elapsedMilliseconds / 1000.0;
  print('Execution Time: ${executionTime.toStringAsFixed(4)} seconds');
  print('Weights: ${result['weights'][0].toStringAsFixed(2)} - ${result['weights'][1].toStringAsFixed(2)}');
  print('Epochs: ${result['epochs']}');
}
