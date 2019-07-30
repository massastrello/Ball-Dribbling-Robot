%% Simulation of the Autonomous Ball-Dribbling Robot Model
% To show the chaotic behavior arising from this model, 
% a two-steps simulation has been performed:
% -1: the system is integrated with a nominal initial condition (x0)
% -2: a Monte Carlo
% Simulation has been performed initial

clear all
close all 

%% Physical Variables
global gamma c_i c_g m1 m2 b1 b2
gamma = -9.81;  % gravity constant
c_i = 1;%0.99;       % restitution coefficien robot-ball
c_g = 1;%0.99;       % restitution coefficient ball-ground
m1 = .1;        % mass of the robot
m2 = .15;       % mass of the ball
b1 = 0.0;
b2 = 0.0;

%% Initial Conditions
q1_0 = 2;
q2_0 = 1.5;
p1_0 = 0;
p2_0 = 0;
x0 = [q1_0;q2_0;p1_0;p2_0];

%% Simulation Horizon
TSPAN = [0,20];
JSPAN = [0,200];

%% Rule for Jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

%% Simulate Nominal System
disp('SIMULATE NOMINAL SYSTEM:')
options = odeset('RelTol',1e-3,'MaxStep',1e-2);

[t,jnom,x] = HyEQsolver(@f,@g,@c,@d,...
                     x0,TSPAN,JSPAN,rule,options,'ode23');
                 
lb = min(x,[],1);
ub = max(x,[],1);

%% Compute Energy
q1nom = x(:,1);
q2nom = x(:,2);
p1nom = x(:,3);
p2nom = x(:,4);

Hnom = (p1nom.^2)./(2*m1) + (p2nom.^2)./(2*m2) - m1*gamma.*q1nom -m2*gamma.*q2nom;

save('Data_nom.mat');

%% Monte Carlo Silulation
N_mc = 100;
DATA = struct();
options = odeset('RelTol',1e-3,'MaxStep',1e-1);

disp('MONTE CARLO SIMULATION:')
for i = 1:N_mc
    clc
    disp(['Iteration: ',num2str(i),'/',num2str(N_mc)])
    rng(i)
    Sigma = diag([0.001,0.001,0.001,0.001]);
    dx0 = Sigma*randn(4,1);
    x0n = x0 + dx0;
    
    [ti,ji,xi] = HyEQsolver(@f,@g,@c,@d,...
                     x0n,TSPAN,JSPAN,rule,options,'ode23');
                 
    Hi = (xi(:,3).^2)./(2*m1) + (xi(:,4).^2)./(2*m2) - m1*gamma.*xi(:,1) -m2*gamma.*xi(:,2);             
    lb = min(lb,min(xi,[],1));
    ub = max(ub,max(xi,[],1));
    DATA(i).x0n = dx0;
    DATA(i).x0n = x0n;
    DATA(i).ti = ti;
    DATA(i).ji = ji;
    DATA(i).xi = xi;
    DATA(i).Hi = Hi;
end
save('DATA200A_conservative','DATA')








