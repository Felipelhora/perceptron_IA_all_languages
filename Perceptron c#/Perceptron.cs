using System;
using System.Collections.Generic;
using System.Diagnostics;

class Perceptron
{
    private List<List<int>> neuroInputs;
    private List<double> weights;
    private double learningRate;
    private List<int> expectedOutputs;
    private int epochs;

    public Perceptron()
    {
        neuroInputs = new List<List<int>>
        {
            new List<int> { 0, 0 },
            new List<int> { 0, 1 },
            new List<int> { 1, 1 },
            new List<int> { 1, 0 }
        };
        weights = new List<double> { 0.0, 0.0 };
        learningRate = 0.1;
        expectedOutputs = new List<int> { 0, 0, 1, 0 };
        epochs = 0;
    }

    private int Step(double valueActivation)
    {
        return valueActivation >= 1 ? 1 : 0;
    }

    private double Sum(List<int> neuroInput, List<double> weights)
    {
        double neuro1 = neuroInput[0] * weights[0];
        double neuro2 = neuroInput[1] * weights[1];
        return neuro1 + neuro2;
    }

    public Dictionary<string, object> Run()
    {
        while (true)
        {
            int totalError = 0;
            for (int index = 0; index < neuroInputs.Count; index++)
            {
                List<int> neuroInput = neuroInputs[index];
                double sumNeuro = Sum(neuroInput, weights);
                int activation = Step(sumNeuro);
                int error = Math.Abs(activation - expectedOutputs[index]);
                totalError += error;

                for (int i = 0; i < weights.Count; i++)
                {
                    weights[i] += learningRate * neuroInput[i] * error;
                }
            }

            epochs++;
            Console.WriteLine(epochs);
            if (totalError == 0)
            {
                return new Dictionary<string, object>
                {
                    { "weights", weights },
                    { "epochs", epochs }
                };
            }
        }
    }
}

class Program
{
    static void Main(string[] args)
    {
        Stopwatch stopwatch = new Stopwatch();
        stopwatch.Start();

        Perceptron perceptron = new Perceptron();
        Dictionary<string, object> answer = perceptron.Run();

        stopwatch.Stop();
        double executionTime = stopwatch.Elapsed.TotalSeconds;
        Console.WriteLine($"Execution Time: {executionTime:F4} seconds");

        List<double> weights = (List<double>)answer["weights"];
        Console.WriteLine($"Weights {weights[0]} - {weights[1]}\nEpochs {answer["epochs"]}");
    }
}
