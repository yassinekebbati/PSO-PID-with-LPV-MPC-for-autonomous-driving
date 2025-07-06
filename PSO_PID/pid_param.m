function J = pid_param(parms);

dt=0.1;


set_param('PSO_PID/kp','Value','parms(1)');
set_param('PSO_PID/ki','Value','parms(2)');
set_param('PSO_PID/kd','Value','parms(3)');
options = simset('SrcWorkspace','current');
S = sim('PSO_PID',[],options);

t = out.Time;
r = out.Data(:,1);
y = out.Data(:,2);

assignin('base','r',r);
assignin('base','y',y);

    
N=length(t);

% %%%mean squared error
J = 1/N*sum((r(:)-y(:)).^2);

% integral absolute error
%J = sum(abs(r(:)-y(:)))

% integral squared error
%J = sum(abs(r(:)-y(:)).^2)


% integral absolute time error
%J = sum(t.*abs(r(:)-y(:))) 


%minimize error and control effort
% E = 1/N*sum((r(:)-y(:)).^2)  
% U = 1/N*sum(u(:).^2)
% J = E + U