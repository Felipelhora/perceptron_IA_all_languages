package main

import (
	"fmt"
	"time"
	"math"
)

type Perceptron struct {
	neuroInputs     [][]float64
	weights         []float64
	learningRate    float64
	expectedOutputs []int
	epochs          int
}

func NewPerceptron() *Perceptron {
	return &Perceptron{
		neuroInputs: [][]float64{
			{0, 0},
			{0, 1},
			{1, 1},
			{1, 0},
		},
		weights:         []float64{0.0, 0.0},
		learningRate:    0.1,
		expectedOutputs: []int{0, 0, 1, 0},
		epochs:          0,
	}
}

func (p *Perceptron) step(valueActivation float64) int {
	if valueActivation >= 1.0 {
		return 1
	}
	return 0
}

func (p *Perceptron) sum(neuroInput []float64, weights []float64) float64 {
	return neuroInput[0]*weights[0] + neuroInput[1]*weights[1]
}

func (p *Perceptron) run() (weights []float64, epochs int) {
	for {
		totalError := 0.0
		for i, neuroInput := range p.neuroInputs {
			sumNeuro := p.sum(neuroInput, p.weights)
			activation := p.step(sumNeuro)
			error := math.Abs(float64(activation - p.expectedOutputs[i]))
			totalError += error
			for j := range p.weights {
				p.weights[j] += p.learningRate * neuroInput[j] * error
			}
		}
		p.epochs++
		fmt.Println(p.epochs)
		if totalError == 0 {
			return p.weights, p.epochs
		}
	}
}

func main() {
	startTime := time.Now()
	perceptron := NewPerceptron()
	weights, epochs := perceptron.run()
	elapsedTime := time.Since(startTime).Seconds()
	fmt.Printf("Execution Time: %.4f seconds\n", elapsedTime)
	fmt.Printf("Weights: %.2f - %.2f\nEpochs: %d\n", weights[0], weights[1], epochs)
}
