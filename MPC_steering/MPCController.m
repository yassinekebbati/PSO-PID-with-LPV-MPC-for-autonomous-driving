%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: Yassine Kebbati
% Date: 10/01/2022
% Control LPV-MPC
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function uout = MPCController(currentx,currentr,t,vx,CR,CF)

persistent Controller
persistent objective constraints parameters_in solutions_out
persistent x u r oldu N a Q R rho epsi pastu
persistent ops

    
     
    % Compute discrete-time dynamics
    cf = CF; %19000; you can use fixed cornering coeficients provided you adapt the model
    cr = CR; %33000;
    Ts = 0.1;
    [Ad Bd Cd Dd nx nu] = model(Ts,vx+0.000001,cr,cf);  %Adding very small value to Vx to avoid singularities
    Ed = [0.25;0.001;0.15;0.002];  % Adding Ed term for disturbance
   
    
    
        if t==0
        
        if isempty(oldu)
        oldu=0;
        end
     

        % Define data for MPC controller trajectory  tracking
        a = 2.5; % Defining the exponential weight term
        N = 6;  %Prediction horizon
        Qy = 125; Qpsi = 0.75;  %Penalizaing matrix values for lateral position (Y) and Yaw position (Psi)
        Q = [Qy 0;0 Qpsi];
        R = 15;  %Specifying penalty on control effort
        rho = 15;
        epsi = 0.5;  %slack variable to relax optimization problem
        % Avoid explosion of internally defined variables in YALMIP
        % yalmip('clear')


        % Setup the optimization problem
        u = sdpvar(repmat(nu,1,N),repmat(1,1,N)); %Define the decision variable

        x = sdpvar(repmat(nx,1,N+1),repmat(1,1,N+1)); %Define the state vector

        r = sdpvar (2,1); %Define the reference vector
       
        pastu = sdpvar(1);    

        

        % Define simple standard MPC controller
        % Current state is known so we replace this
        ops = sdpsettings('solver','quadprog','verbose',0); %You can use better solvers here like 'gurobi'
        
             
        objective = 0;
                
        parameters_in = {x{1},r,pastu}; %Define input to controller

        solutions_out = {u{1}}; %{[u{:}], pastu,  objective}; %Define output from controller (solutions)
        end
        
        
        constraints = [-pi/12 <= diff([pastu u{:}]) <= pi/12]; % Specify the contraints on optimization problem
        
        for k = 1:N

            
            objective = objective + a^(-k)* ((r-Cd*x{k})'*Q*(r-Cd*x{k})+u{k}'*R*u{k})+rho*epsi^2; %Define objective function here

            constraints = [constraints, x{k+1} == Ad*x{k}+Bd*u{k}+Ed*randn/5];  %Define system model here as constraint
            constraints = [constraints, -pi/6 <= u{k}<= pi/6];%, -250<=Cd*x{k+1}<=250]; %Define contraints for next steps

        end

     
        Controller = optimizer(constraints,objective,ops,parameters_in,solutions_out); %Define yalmip contoller object here

    
    tic      
    uout = Controller{{currentx,currentr,oldu}};  %Execute the defined yalmip controller here
    tmpc = toc; %time the excution duration here
    oldu = uout;  %send out the computed control signal

end