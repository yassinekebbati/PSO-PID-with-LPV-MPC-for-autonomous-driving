function [Ad Bd Cd Dd nx nu] = model(Ts,Vx,Cr,Cf);
    m = 1575;
    Iz = 2875;
    lf = 1.2;
    lr = 1.6;
    %Cf = 19000; You can use fixed cornering stiffness coeficients provided that you adapt the model
    %Cr = 33000;
    A = [-(2*Cf+2*Cr)/m/Vx(1), 0, -Vx(1)-(2*Cf*lf-2*Cr*lr)/m/Vx(1), 0;...
        0, 0, 1, 0;...
     -(2*Cf*lf-2*Cr*lr)/Iz/Vx(1), 0, -(2*Cf*lf^2+2*Cr*lr^2)/Iz/Vx(1), 0;...
     1, Vx(1), 0, 0];
    B = [2*Cf/m 0 2*Cf*lf/Iz 0]';   
    C = [0 0 0 1];
    D = zeros(1,1);
    [nx,nu] = size(B);
    [Ad, Bd, Cd, Dd]=c2dm(A,B,C,D,Ts,'zoh');   %discretize the model here