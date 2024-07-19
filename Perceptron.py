import time

class Perceptron:
    
    def __init__(self) -> None:
        self.neuro_inputs = [
                                [0,0], 
                                [0,1],
                                [1,1], 
                                [1,0]
                            ]
        self.weights = [0.0, 0.0]
        self.learning_rates = 0.1
        self.expected_outputs = [ 0, 0, 1, 0 ]
        self.epochs = 0
    
    def step(self,value_activation:float)->int:
        if value_activation >=1:
            return 1
        return 0
        
    def sum(self,neuro_input:list, weights:list) -> float:
        neuro_1 = neuro_input[0] * weights[0]
        neuro_2 = neuro_input[1] * weights[1]
        return neuro_1 + neuro_2
    
    def run(self)->dict:
        while (True):
            total_error = 0
            for index, neuro_input in enumerate(self.neuro_inputs):
                sum_neuro = self.sum(neuro_input=neuro_input, weights=self.weights)
                activation = self.step(sum_neuro)
                erro = abs(activation -self.expected_outputs[index])
                total_error = total_error + erro
                for index_, weight in enumerate(self.weights):
                    self.weights[index_] = self.weights[index_] + (self.learning_rates * neuro_input[index_] * erro)   
            self.epochs += 1
            print (self.epochs)
            if total_error == 0:
                return {
                            "weights" : self.weights,
                            "epochs": self.epochs
                        }
                        
start_time = time.time()           
start = Perceptron()
answer = start.run()
end_time = time.time()
execution_time = end_time - start_time
print(f'Execution Time: {execution_time:.4f} seconds')
print (f"Weights {answer['weights'][0]} - {answer['weights'][1]}\nEpochs {answer['epochs']}")

        
    
    