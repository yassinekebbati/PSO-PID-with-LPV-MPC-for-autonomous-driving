clc;clear;close all;

open PSO_PID.slx

%%Problem Definition
problem.CostFunction = @(x) pid_param(x);  % Cost Function
%problem.CostFunction = @(x) Sphere(x);  % Cost Function

problem.nVar = 3;           % Number of Unknown (Decision) Variables
problem.Kp_Min = 0.25;      %Lower Bound of Decision Variables
problem.Kp_Max = 6;         %Upper Bound of Decision Variables
problem.Ki_Min = 0.001;     %Lower Bound of Decision Variables
problem.Ki_Max = 0.08;      %Upper Bound of Decision Variables
problem.Kd_Min = 0.1;       %Lower Bound of Decision Variables
problem.Kd_Max = 2.5;       %NpMax %Upper Bound of Decision Variables



%%Parameters of PSO
params.MaxIt = 15;      %Maximum Number of Iterations
params.nPop = 20;       %Population size (swarm size)
params.w = 1;           % inertia coefficient
params.w_max = 0.99;    % maximum inertia coefficient
params.w_min = 0.1;     % minimum coefficient

params.c1 = 2.2;        %Personal acceleration coefficient
params.c2 = 2.2;        %social acceleration coefficient
params.ShowIterInfo = true;  %Flag for showing Iteration
 



k=1;
%% Calling PSO
    out = PSO_pid_test(problem,params);

    BestSol = out.BestSol;
    BestCosts = out.BestCosts;
    kp = out.BestSol.Position(1)
    ki = out.BestSol.Position(2)
    kd = out.BestSol.Position(3)




