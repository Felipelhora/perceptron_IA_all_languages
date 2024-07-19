<?php

$startTime = microtime(true);

class Perceptron
{
    public $neuroInputs = [[0,0], [1,0], [0,1], [1,1]];
    public $weights = [0.0, 0.0];
    public $expectedOutputs = [0,0,0,1];
    public $learningRate = 0.1;
    public $epochs = 0;
    private  function step ($value)
    {
        if ($value >= 1)
            {
                return 1;
            }
        return 0;
    }
    private function soma($neuronio, $pesos)
    {
        $neuronio_1 = $neuronio[0] * $pesos[0];
        $neuronio_2 = $neuronio[1] * $pesos[1];
        return $neuronio_1 + $neuronio_2;
    }
    public function run()
    {
        while (True) {
            $erroTotal = 0;
            foreach ($this->neuroInputs as $index => $neuroInput) {
                $sum_neuronio = $this->soma($neuroInput, $this->weights);
                $activation = $this->step($sum_neuronio);
                $erro = abs($activation - $this->expectedOutputs[$index]);
                if ($erro != 0) {
                    $erroTotal = $erroTotal + $erro;
                }
                foreach ($this->weights as $index_ => $weight) {
                    $this->weights[$index_] = $this->weights[$index_] + ($this->learningRate * $neuroInput[$index_] * $erro);
                }
            }
            $this->epochs += 1;
            if ($erroTotal == 0) {
                $firtweigth = $this->weights[0];
                $secondweigth = $this->weights[1];
                printf("EPOCHS - LAST $this->epochs\n");
                printf("WEIGHTS $firtweigth - $secondweigth\n");
                break;
            }
        }
    }
}

$start  = new Perceptron();
$start->run();
$endTime = microtime(true);
$executionTime = $endTime - $startTime;
echo 'Execution Time: ' . number_format($executionTime, 4) . ' seconds' . PHP_EOL;