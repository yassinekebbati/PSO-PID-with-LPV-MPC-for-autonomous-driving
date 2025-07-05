# PSO-PID-with-LPV-MPC-for-autonomous-driving
This is the implementation of the work published  in the following papers: "Coordinated PSO-PID based longitudinal control with LPV-MPC based lateral control for autonomous vehicles". 
The paper is freely accessible at this link: (https://universite-paris-saclay.hal.science/hal-03749480/), It is also available at IEEE: (https://ieeexplore.ieee.org/abstract/document/9838192). 

## Steps to run the code:
This implementation runs a cosimulation between Matlab and Carsim; you need to have Matlab 2024b or higher (version in which the model was saved). 
1. You also need to have Yalmip installed with MATLAB and configured to run MPC code, and you need to have Carsim (version 8.02 used) installed and configured to run with Simulink.
2. For properly installing Yalmip, you can follow the steps provided here: https://yalmip.github.io/tutorial/installation/
3. To configure Carsim to run with Simulink, follow the steps provided at this link: https://blog.csdn.net/m0_46427461/article/details/123263842 or use the PDF file below: 
[Troubleshooting the problem of not finding Car Sim S-Function in the MATLAB Simulink Library Browser_simulink library without carsim-CSDN blog.pdf](https://github.com/user-attachments/files/21080578/Troubleshooting.the.problem.of.not.finding.Car.Sim.S-Function.in.the.MATLAB.Simulink.Library.Browser_simulink.library.without.carsim-CSDN.blog.pdf)
4. You should configure the Carsim model parameters as illustrated in the screenshots below : 
a. Set model parameters: ![CarSim_Dimensions](https://github.com/user-attachments/assets/6910f9d8-bae4-4aaa-9779-780d7a15a5b9)
b. Set model inputs: ![CarSim_Inputs](https://github.com/user-attachments/assets/0b6a406d-b23e-4910-9bfe-ccef6d1750ec)
c. Set model outputs: ![CarSim_Outputs](https://github.com/user-attachments/assets/a298daaa-697d-4687-970b-a8be5cd6878c)
d. Set controller parameters for double lane change maneuver: ![CarSim_DLC_Config](https://github.com/user-attachments/assets/9dbcee88-a665-46be-bbd6-84cfa6be358c)
f. Set controller parameters for general trajectory: ![CarSim_Traj_Config](https://github.com/user-attachments/assets/28f0970e-32cc-4db3-87fd-50146c032521)
5. You need to adjust the right configuration in Simulink for the general trajectory of the double lane change maneuver. You need to adapt the reference data, the correct simfile, and the right simulation time as shown in the figure below:
![MATLAB_rqsOIXpwPt](https://github.com/user-attachments/assets/999556ee-befa-4b2b-ac80-4e9cb6f4dce9)
