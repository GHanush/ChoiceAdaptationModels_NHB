# ChoiceAdaptationModels_NHB

## Overview
This repository contains MATLAB scripts and data files to demonstrate model fitting in the study "Human Decision Making beyond Prospect Theory" by A. Ghambaryan, B. Gutkin, V. Klucharev and E. Koechlin 

The scripts process and fit data to models IMA, DIST, OPT, and RL. Data and scripts are provided for Experiment 1. Scripts for Experiments 2 and 3 are virtually identical. 

## Repository Structure
Folder 'Exp1' contains file 'data_dom2val.mat' containing data of all participants in Experiment 1 and subfolder 'domval' containing scripts to fit models to choices of any one participant. 


## Instructions to use
1. Download folder 'ChoiceAdaptationModels_NHB'.
The script automatically loads the data from '.../data_dom2val.mat' using relative paths.
Ensure the folder structure is unchanged.
3. Open MATLAB.  
4. Navigate to subfolder 'Exp1' to run model fitting to data of Experiment 1.
5. Navigate to subfolder 'domval' to run model fitting to data of any one participant in Experiment 1.
6. Follow instructions in file 'README.md' in subfolder 'domval'.


## Software Requirements
- The scripts were developed and tested on MATLAB R2021b running on Windows 10.
- Required MATLAB toolboxes:
  - Statistics and Machine Learning Toolbox
  - Optimization Toolbox
  - Parallel Computing Toolbox
 
## Download time
Download of provided folder 'ChoiceAdaptationModels_NHB' is maximum 5 minutes on a "normal" desktop computer. 




The MIT License (MIT)
Copyright (c) 2026 Ghambaryan Anush

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
