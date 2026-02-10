# ChoiceAdaptationModels_NHB/Exp1/domval

## Overview
Folder 'domval' contains scripts to fit models IMA, DIST, OPT, RL to data of any one participant in Experiment 1. Examples of participant IDs: 131, 142, 149, 154, 158, 165, 170, 178


## Instructions to use
1. Open file 'launch_task.mat'.
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

