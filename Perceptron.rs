use std::time::Instant;

struct Perceptron {
    neuro_inputs: Vec<Vec<f64>>,
    weights: Vec<f64>,
    learning_rate: f64,
    expected_outputs: Vec<i32>,
    epochs: i32,
}

impl Perceptron {
    fn new() -> Self {
        Self {
            neuro_inputs: vec![
                vec![0.0, 0.0],
                vec![0.0, 1.0],
                vec![1.0, 1.0],
                vec![1.0, 0.0],
            ],
            weights: vec![0.0, 0.0],
            learning_rate: 0.1,
            expected_outputs: vec![0, 0, 1, 0],
            epochs: 0,
        }
    }

    fn step(&self, value_activation: f64) -> i32 {
        if value_activation >= 1.0 {
            1
        } else {
            0
        }
    }

    fn sum(&self, neuro_input: &Vec<f64>, weights: &Vec<f64>) -> f64 {
        neuro_input[0] * weights[0] + neuro_input[1] * weights[1]
    }

    fn run(&mut self) -> (Vec<f64>, i32) {
        loop {
            let mut total_error = 0;
            for (index, neuro_input) in self.neuro_inputs.iter().enumerate() {
                let sum_neuro = self.sum(neuro_input, &self.weights);
                let activation = self.step(sum_neuro);
                let error = (activation - self.expected_outputs[index]).abs();
                total_error += error;
                for (index_, weight) in self.weights.iter_mut().enumerate() {
                    *weight += self.learning_rate * neuro_input[index_] * error as f64;
                }
            }
            self.epochs += 1;
            println!("{}", self.epochs);
            if total_error == 0 {
                return (self.weights.clone(), self.epochs);
            }
        }
    }
}

fn main() {
    let start_time = Instant::now();
    let mut perceptron = Perceptron::new();
    let (weights, epochs) = perceptron.run();
    let end_time = start_time.elapsed();
    println!(
        "Execution Time: {:.4} seconds",
        end_time.as_secs_f64()
    );
    println!("Weights: {} - {}\nEpochs: {}", weights[0], weights[1], epochs);
}
