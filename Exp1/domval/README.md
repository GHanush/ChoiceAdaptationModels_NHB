# ChoiceAdaptationModels_NHB

## Repository Structure
Folder 'domval' contains scripts to fit models IMA, DIST, OPT, RL to data of any one participant in Experiment 1. Data of individual participants have the following IDs: 132	135	159	174	178	131	136	163	166	177	142	144	156	161	171	145	148	152	154	137	138	149	175	140	150	151	153	162	147	155	158	160	167	170	143	157	165	169


## Instructions to use
1. Open file 'launch_task.mat'.
2. Change the value of variable 'isubject' to ID of any participant in Experiment 1
3. Choose models to run the fitting by commenting out unchosen models (for instance, '% dist(isubject)')
4. Save the changes
5. Type 'launch_task' in the command window


## Run time
The running time per model per participant is approximately 15 minutes on a "normal" desktop computer.

## Note
The optimization parameters are extremely reduced (compared to Methods provided in the manuscript) to limit the running time on a "normal" desktop computer. 

