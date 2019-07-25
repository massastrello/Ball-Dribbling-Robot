clear all
close all 

%% Physical Variables
global gamma c_i c_g m1 m2 b1 b2
gamma = -9.81;  % gravity constant
c_i = 0.95;%0.99;       % restitution coefficien robot-ball
c_g = 0.95;%0.99;       % restitution coefficient ball-ground
m1 = .1;        % mass of the robot
m2 = .15;       % mass of the ball
b1 = 0.;
b2 = 0.;

%% Initial Conditions
q1_0 = 2;
q2_0 = 1.5;
p1_0 = 0;
p2_0 = 0;
x0 = [q1_0;q2_0;p1_0;p2_0];

%% Simulation Horizon
TSPAN = [0,10];
JSPAN = [0,200];

%% Rule for Jumps
% rule = 1 -> priority for jumps
% rule = 2 -> priority for flows
rule = 1;

%% Simulate Nominal System
options = odeset('RelTol',1e-4,'MaxStep',1e-2);

[t,j,x] = HyEQsolver(@f,@g,@c,@d,...
                     x0,TSPAN,JSPAN,rule,options,'ode23');

%% Compute Energy
q1 = x(:,1);
q2 = x(:,2);
p1 = x(:,3);
p2 = x(:,4);

H = (p1.^2)./(2*m1) + (p2.^2)./(2*m2) - m1*gamma.*q1 -m2*gamma.*q2;



%% Monte Carlo Silulation
N_mc = 200;
DATA = struct();
for i = 1:N_mc
    disp(i)
    rng(i)
    Sigma = diag([0.001,0.001,0.001,0.001]);
    dx0 = Sigma*randn(4,1);
    x0n = x0 + dx0;
    
    [ti,ji,xi] = HyEQsolver(@f,@g,@c,@d,...
                     x0n,TSPAN,JSPAN,rule,options,'ode23');
    
    DATA(i).x0n = dx0;
    DATA(i).x0n = x0n;
    DATA(i).ti = ti;
    DATA(i).ji = ji;
    DATA(i).xi = xi;
end

figure(1)
subplot(221)
    hold on
    for i = 1:N_mc
        plot(DATA(i).ti,DATA(i).xi(:,1))
    end
    hold off
subplot(222)
    hold on
    for i = 1:N_mc
        plot(DATA(i).ti,DATA(i).xi(:,2))
    end
    hold off
subplot(223)
    hold on
    for i = 1:N_mc
        plot(DATA(i).ti,DATA(i).xi(:,3))
    end
    hold off
subplot(224)
    hold on
    for i = 1:N_mc
        plot(DATA(i).ti,DATA(i).xi(:,4))
    end
    hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Plot Solution
%
modificatorF{1} = 'k';
modificatorF{2} = 'LineWidth';
modificatorF{3} = 1.5;
modificatorJ{1} = '-.';
modificatorJ{2} = 'LineWidth';
modificatorJ{3} = 2;
modificatorJ{4} = 'Marker';
modificatorJ{5} = 'o';
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










