public class Perceptron {

    private double[][] neuroInputs;
    private double[] weights;
    private double learningRate;
    private int[] expectedOutputs;
    private int epochs;

    public Perceptron() {
        this.neuroInputs = new double[][] {
            {0, 0},
            {0, 1},
            {1, 1},
            {1, 0}
        };
        this.weights = new double[] {0.0, 0.0};
        this.learningRate = 0.1;
        this.expectedOutputs = new int[] {0, 0, 1, 0};
        this.epochs = 0;
    }

    private int step(double valueActivation) {
        return valueActivation >= 1.0 ? 1 : 0;
    }

    private double sum(double[] neuroInput, double[] weights) {
        return neuroInput[0] * weights[0] + neuroInput[1] * weights[1];
    }

    public Result run() {
        while (true) {
            double totalError = 0;
            for (int i = 0; i < neuroInputs.length; i++) {
                double[] neuroInput = neuroInputs[i];
                double sumNeuro = sum(neuroInput, weights);
                int activation = step(sumNeuro);
                double error = Math.abs(activation - expectedOutputs[i]);
                totalError += error;
                for (int j = 0; j < weights.length; j++) {
                    weights[j] += learningRate * neuroInput[j] * error;
                }
            }
            epochs++;
            System.out.println(epochs);
            if (totalError == 0) {
                return new Result(weights, epochs);
            }
        }
    }

    public static void main(String[] args) {
        long startTime = System.currentTimeMillis();
        Perceptron perceptron = new Perceptron();
        Result result = perceptron.run();
        long endTime = System.currentTimeMillis();
        double executionTime = (endTime - startTime) / 1000.0;
        System.out.printf("Execution Time: %.4f seconds%n", executionTime);
        System.out.printf("Weights: %.2f - %.2f%nEpochs: %d%n", result.weights[0], result.weights[1], result.epochs);
    }

    public static class Result {
        public final double[] weights;
        public final int epochs;

        public Result(double[] weights, int epochs) {
            this.weights = weights;
            this.epochs = epochs;
        }
    }
}
