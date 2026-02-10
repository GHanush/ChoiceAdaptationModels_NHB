# ChoiceAdaptationModels_NHB

## Overview
This repository contains MATLAB scripts used in the study "Human Decision Making beyond Prospect Theory" submitted to Nature Human Behavior.  
The scripts process and fit data to models IMA, DIST, OPT, and RL. Both data and scripts are organized per experiment.

## Repository Structure
Folder 'Exp1' contains file 'data_dom2val.mat' containing data of all participants in Experiment 1 and subfolder 'domval' containing scripts to fit models to choices of any one participant. Folder 'Exp1' also contains file 'README.md'.


## Instructions to use
1. Download folder 'ChoiceAdaptationModels_NHB'.
The script automatically loads the data from '.../data_dom2val.mat' using relative paths.  
Ensure the folder structure is unchanged. 
3. Open MATLAB.  
4. Navigate to subfolder 'Exp1' to run model fitting to data of Experiment 1.
5. Navigate to subfolder 'domval' to run model fitting to data of any one participant in Experiment 1.
6. Follow instructions in file 'README.md' in chosen subfolder 'Exp1'.


## Software Requirements
- The scripts were developed and tested on MATLAB R2021b running on Windows 10.
- Required MATLAB toolboxes:
  - Statistics and Machine Learning Toolbox
  - Optimization Toolbox
  - Parallel Computing Toolbox


