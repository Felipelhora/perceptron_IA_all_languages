

class Perceptron
{
    constructor()
    {
        this.neuronsInputs = [[0,0], [1,0], [0,1], [1,1]]
        this.expectedOutputs = [0,0,0,1]
        this.learningRate = 0.1
        this.weights = [0.0,0.0]
        this.epochs = 0
        this.startTime = Date.now()
    }
    sum(neuroInput, weights)
    {
        let neuroInput_1 = neuroInput[0] * weights[0];
        let neuroInput_2 = neuroInput[1] * weights[1];
        return neuroInput_1 + neuroInput_2;
    }
    step(sumNeuron)
    {
        if (sumNeuron >= 1)
        {
            return 1
        }
        return 0
    }
    run()
    {
        while (true)
        {
            let totalError = 0
            for (let [index, neuronInput] of this.neuronsInputs.entries())
            {
                let sumNeuron = this.sum(neuronInput, this.weights)
                let ativacao = this.step(sumNeuron)
                let erro = Math.abs(this.expectedOutputs[index] - ativacao)
                totalError += erro
                for (let [index_, weight] of this.weights.entries()) {
                    this.weights[index_] += this.learningRate * erro * neuronInput[index_];
                }
            }
            this.epochs += 1
            if (totalError === 0 || this.epochs === 100) {
                let endTime = Date.now();
                let executionTime = endTime - this.startTime;
                console.log(`Execution Time: ${executionTime} ms`);
                console.log(`Epochs: ${this.epochs}`);
                console.log(`Weights: ${this.weights[0]} - ${this.weights[1]}`);
                break;
            }
        }
    }
}

const perceptron = new Perceptron();
perceptron.run();