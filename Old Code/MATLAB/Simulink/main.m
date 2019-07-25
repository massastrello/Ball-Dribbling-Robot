close all 
clear all

%% Physical Variables
global gamma c_i c_g m1 m2 flag_j
gamma = -9.81;  % gravity constant
c_i = 0.8;     % restitution coefficien robot-ball
c_g = 0.7;     % restitution coefficient ball-ground
m1 = 10;       % mass of the robot
m2 = 15;       % mass of the ball

%% Initial Conditions
q1_0 = 20;
q2_0 = 10;
p1_0 = 0;
p2_0 = 0;
x0 = [q1_0;q2_0;p1_0;p2_0];

%% Simulation Horizon
TSPAN = [0,100];
JSPAN = [0,2000];

%% Rule for Jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

%% Simulate
options = odeset('RelTol',1e-6,'MaxStep',1e-4);

[t,j,x] = HyEQsolver(@f,@g,@c,@d,...
                     x0,TSPAN,JSPAN,rule,options);
                 
%% Plot Solution

figure(1)
clf
subplot(2,1,1), plotHarc(t,j,x(:,1));
grid on
ylabel('q_1 - Robot Position')
subplot(2,1,2), plotHarc(t,j,x(:,3)/m1);
grid on
ylabel('p_1 - Robot Velocity')

figure(2)
clf
subplot(2,1,1), plotHarc(t,j,x(:,2));
grid on
ylabel('q_2 - Ball Position')
subplot(2,1,2), plotHarc(t,j,x(:,4)/m2);
grid on
ylabel('p_2 - Ball Velocity')

figure(3)
clf
plotHarcColor(x(:,1),j,x(:,3)/m1,t)

%figure(4)
%clf
%plotHybridArc(t,j,[x(:,2),x(:,4)/m2])