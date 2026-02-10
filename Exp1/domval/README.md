# ChoiceAdaptationModels_NHB/Exp1/domval

## Overview
Folder 'domval' contains scripts to fit models IMA, DIST, OPT, RL to data of any one participant in Experiment 1. Examples of participant IDs: 131, 142, 149, 154, 158, 165, 170, 171


## Instructions to use
1. Open file 'launch_task.mat'
2. Change the value of variable 'isubject' to ID of any participant in Experiment 1
3. Choose models to run the fitting by commenting out unchosen models (for instance, '% dist(isubject)')
4. Save the changes
5. Type 'launch_task' in the command window

## Output
The program will output one file per model fitting each contaning 10 sets of estimated values of a model's free parameters as well as negative log-likelihoods of each set. Note that the number of sets here are chosen for demostratation purposes only. Methods in the manuscript specify 3000 sets per model. 

## Run time
The running time per model per participant is approximately 10 minutes on a "normal" desktop computer.

## Note
The optimization parameters are extremely reduced (compared to Methods provided in the manuscript) to limit the running time on a "normal" desktop computer. 



## License 

The MIT License (MIT)
Copyright (c) 2026 Ghambaryan Anush

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

