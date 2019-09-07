addpath(genpath(pwd))
clc
clear all
close all 

%% Physical Variables
global gamma c_i c_g m1 m2 q2o p2o maxo k e gain ga err kc q2md h iter c_state u_i gain_i hit
gamma = -9.81;  % gravity constant
c_i = .8;       % restitution coefficien robot-ball
c_g = .8;       % restitution coefficient ball-ground
m1 = .1;        % mass of the robot
m2 = .15;       % mass of the ball
q2o = 0;
p2o = 0;
e = 0;
c_state = 0;
gain = [];
gain_i = [];
ga = 1;
err = [];
iter = [0,0];
hit = 0;
%% Initial Conditions
q1_0 = 2;
q2_0 = 1.5;
p1_0 = 0;
p2_0 = 0;
x0 = [q1_0;q2_0;p1_0;p2_0];
maxo = q2_0;
%% Control Variables
q2md = 1;
h = .5;
k = 10;
kc = 1;
u_i = [];
%% Simulation Horizon
TSPAN = [0,10];
JSPAN = [0,200];

%% Rule for Jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

%% Simulate
options = odeset('RelTol',1e-4,'MaxStep',1e-3);

[t,jnom,x] = HyEQsolver(@f_c,@g_c,@c_c,@d_c,...
                     x0,TSPAN,JSPAN,rule,options,'ode23');

e_nom = e;
gain_nom = gain;
%% Compute Energy
q1nom = x(:,1);
q2nom = x(:,2);
p1nom = x(:,3);
p2nom = x(:,4);

Hnom = (p1nom.^2)./(2*m1) + (p2nom.^2)./(2*m2) - m1*gamma.*q1nom -m2*gamma.*q2nom;
lb = min(x,[],1);
ub = max(x,[],1);
%save('Data_nom.mat');

%% Monte Carlo
N_mc = 4500;
DATA(N_mc) = struct();
i = 3001;
j = 10183;
bounces_MC = length(e); %count the minimum number of ball bounces among all the Monte Carlo runs
while i <= N_mc
    disp(['Iteration: ',num2str(i),'.',num2str(j),'/',num2str(N_mc)])
    rng(j)
    Sigma = 1e0;
    dx0 = Sigma*randn(4,1);
    x0n = x0 + dx0;
    
    if ~c_c(x0n)
        j = j+1;
        continue
    end
    e = 0; c_state = 0; gain = []; gain_i = []; ga = 1; err = []; iter = [0,0];
    hit = 0; q2o = q2_0; p2o = q2_0; maxo = q2_0;
    q2md = 1; h = .5; k = 10; kc = 1; u_i = [];
    
    [ti,ji,xi] = HyEQsolver(@f_c,@g_c,@c_c,@d_c,...
                     x0n,TSPAN,JSPAN,rule,options,'ode23');
    
    Hi = (xi(:,3).^2)./(2*m1) + (xi(:,4).^2)./(2*m2) - m1*gamma.*xi(:,1) -m2*gamma.*xi(:,2);
    lb = min(lb,min(xi,[],1));
    ub = max(ub,max(xi,[],1));
    
    DATA(i).x0n = dx0;
    DATA(i).x0n = x0n;
    DATA(i).ti = ti;
    DATA(i).ji = ji;
    DATA(i).xi = xi;
    DATA(i).e = e;
    DATA(i).gain = gain;
    DATA(i).Hi = Hi;
    
    bounces_MC = min(bounces_MC,length(e));
    i = i+1;
    j = j+1;
end
save('DATA4500C_Controlled.mat');

PlotResults






