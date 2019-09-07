clear all
close all 

%% Physical Variables
global gamma c_i c_g m1 m2 q2o p2o maxo k e gain ga err kc q2md h iter c_state u_i k_it gain_i hit b1 b2
gamma = -9.81;  % gravity constant
c_i = .8;       % restitution coefficien robot-ball
c_g = .8;       % restitution coefficient ball-ground
m1 = .1;        % mass of the robot
m2 = 0.05;       % mass of the ball
q2o = 0;
p2o = 0;
b1 = 0.2;
b2 = 0.3;
e = [];
c_state = 0;
gain = [];
gain_i = [];
ga = 1;
err = [];
iter = [0,0];
hit = 0;
k_it = [];
%% Initial Conditions
q1_0 = .2;
q2_0 = .15;
p1_0 = 0;
p2_0 = 0;
x0 = [q1_0;q2_0;p1_0;p2_0];
maxo = q2_0;
%% Control Variables
q2md = .1;
h = .05;
k = 0;
kc = 1;
u_i = [];
%% Simulation Horizon
TSPAN = [0,5];
JSPAN = [0,200];

%% Rule for Jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

%% Simulate
options = odeset('RelTol',1e-3,'MaxStep',1e-3);

[t,jnom,x] = HyEQsolver(@f,@g,@c,@d,...
                     x0,TSPAN,JSPAN,rule,options,'ode23tb');

%% Compute Energy
q1nom = x(:,1);
q2nom = x(:,2);
p1nom = x(:,3);
p2nom = x(:,4);

Hnom = (p1nom.^2)./(2*m1) + (p2nom.^2)./(2*m2) - m1*gamma.*q1nom -m2*gamma.*q2nom;

K1 = (p1nom.^2)./(2*m1); V1 = -m1*gamma.*q1nom; H1 = K1 + V1;
K2 = (p2nom.^2)./(2*m2); V2 = -m2*gamma.*q2nom; H2 = K2 + V2;
K = K1 + K2; V = V1 + V2;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

plot_results
%% Plot Solution
%{
modificatorF{1} = 'k';
modificatorF{2} = 'LineWidth';
modificatorF{3} = 1.5;
modificatorJ{1} = '-.';
modificatorJ{2} = 'LineWidth';
modificatorJ{3} = 2;
modificatorJ{4} = 'Marker';
modificatorJ{5} = '*';
modificatorJ{6} = 'MarkerEdgeColor';
modificatorJ{7} = 'r';
modificatorJ{8} = 'MarkerFaceColor';
modificatorJ{9} = 'r';
modificatorJ{10} = 'MarkerSize';
modificatorJ{11} = 3;
%
figure(1)
clf
box on
subplot(2,1,1), 
box on
plotHarc(t,j,x(:,1),[],modificatorF,modificatorJ);
ylabel('q_1 - Robot Position')
subplot(2,1,2), 
box on
plotHarc(t,j,x(:,3),[],modificatorF,modificatorJ);
xlabel('time [s]')
ylabel('p_1 - Robot Momentum')

figure(2)
clf
box on
subplot(2,1,1),
box on
hold on
plotHarc(t,j,x(:,2),[],modificatorF,modificatorJ);
ylabel('q_2 - Ball Position')
hold off
subplot(2,1,2),
box on
hold on
plotHarc(t,j,x(:,4),[],modificatorF,modificatorJ);
xlabel('time [s]')
ylabel('p_2 - Ball Momemtum')
hold off
%
%
%
figure(3)
clf
colorbar
subplot(2,1,1)
box on
plotHarcColor(x(:,1),j,x(:,3),t);
xlabel('q1')
ylabel('p1')
%colorbar
%
%
%figure(4)
%clf
subplot(2,1,2)
box on
plotHarcColor(x(:,2),j,x(:,4),t);
xlabel('q2')
ylabel('p2')

%
% Hamiltonian
%
figure()
clf
box on
plot(t,H,'k','LineWidth',1.5)
xlabel('time [s]')
ylabel('H')
%
%
%
figure(6)
clf
box on
plot(gain,'LineWidth',1.5)
xlabel('cycle')
ylabel('gain')
%
%
%
figure(7)
clf
box on
plot(e,'LineWidth',1.5)
xlabel('cycle')
ylabel('error')
%
%}










