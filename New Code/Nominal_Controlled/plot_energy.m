%close all
%clear all
Np = 50;
q1_plot = linspace(-1,1,Np);
q2_plot = linspace(0,.1,Np);
p1_plot = linspace(-5,5,Np);
p2_plot = linspace(-.1,.1,Np);

[Q1,P1] = meshgrid(q1_plot,p1_plot);
[Q2,P2] = meshgrid(q2_plot,p2_plot);

m1 = .1;
m2 = .05;
g = 9.81;
k_p = 100;
q1d = 1;

H1_a = (P1.^2)/(2*m1) + g*m1.*Q1;
H2_a = (P2.^2)/(2*m2) + g*m2.*Q1;
H1_c = (P2.^2)/(2*m2) + (k_p/2).*((Q1-q1d).^2);
%
figure(1);
subplot(121)
    [~,h] = contourf(Q1,P1,H1_a);
    set(h,'linestyle','none');
    hold on
    plotHarc(x(:,1),jnom,x(:,3),[],modificatorF,modificatorJ);
    hold off
%
subplot(122)
    [~,h] = contourf(Q2,P2,H2_a);
    set(h,'linestyle','none');
    hold on
    plotHarc(x(:,2),jnom,x(:,4),[],modificatorF,modificatorJ);
    hold off
%

%% Save things in .dat
dataH1_a = [ Q1(:) P1(:) H1_a(:) ];
save H1_a.dat dataH1_a -ASCII
%
dataH2_a = [ Q1(:) P1(:) H2_a(:) ];
save H2_a.dat dataH2_a -ASCII
%
dataH1_c = [ Q1(:) P1(:) H1_c(:) ];
save H1_c.dat dataH1_c -ASCII

figure(2)
for i = 1:k_it%size(gain)
    Hit = (P1.^2)/(2*m1) + 10*k_it(i).*(Q1.^2);
    clf
    surf(Q1,P1,Hit)
    xlim([-1,1])
    ylim([-5,5])
    zlim([0,200])
    view([30,45])
    drawnow
    pause(0.1)
end