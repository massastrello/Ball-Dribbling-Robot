close all
clear f

N_frames = 1000;
ts_nom = resample(timeseries(x,t),linspace(0,t(end),N_frames));
     
%fig = figure('position',[100 100 600 300]);
fig = figure(1);
set(gcf, 'Visible', 'off', 'color', [1,1,1],'position',[1 1 2048 1024])

f(N_frames) = struct('cdata',[],'colormap',[]);

xi = ts_nom.Data;
ti = ts_nom.Time;

for i = 1:N_frames
    %print(['Frame ',num2str(i),'/',num2str(N_frames)])
    subplot(2,4,[1,2]);
        cla
        box on
        plot(ti(1:i),xi(1:i,1),'LineWidth',8);
        xlim([0,t(end)])
        ylim([0,.2])
        xlabel('\textbf{Time} $t$ [s]','Interpreter','latex')
        ylabel('\textbf{Robot Position} $q_1(t)$','Interpreter','latex')
        set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',30,...
        'linewidth',4,...
        'FontName','Times',...
        'Layer', 'Top')
        drawnow 
    subplot(2,4,[5,6]);
        cla
        plot([0,t(end)],[.1,.1],':k','LineWidth',4)
        hold on
        plot(ti(1:i),xi(1:i,2),'r','LineWidth',8);
        hold off
        xlim([0,t(end)])
        ylim([0,.15])
        xlabel('\textbf{Time} $t$ [s]','Interpreter','latex')
        ylabel('\textbf{Robot Position} $q_2(t)$','Interpreter','latex')
        set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',30,...
        'linewidth',4,...
        'FontName','Times',...
        'Layer', 'Top')
        drawnow 
    subplot(2,4,[3,4,7,8]);
        cla
        box on
        pp = plot(xi(1:i,1),xi(1:i,2),'b','LineWidth',8);
        pp.Color(4) = 0.2;
        xlim([0,.2])
        ylim([0,.15])
        xlabel('$q_1(t)$','Interpreter','latex')
        y = ylabel('$q_2(t)$','Interpreter','latex');
        set(y, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
        title('\textbf{State--Space Trajectory}','Interpreter','latex')
        set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',30,...
        'linewidth',4,...
        'FontName','Times',...
        'Layer', 'Top')
        drawnow       
    f(i) = getframe(fig);
end
%
%v = VideoWriter('ph_ex_aut.avi','Motion JPEG AVI');
v = VideoWriter('bd_ctrl_traj.mp4','MPEG-4');
v.Quality = 100;
v.FrameRate = 100;%N_frames/t(end);
open(v)
writeVideo(v,f)
close(v)

%{
for i = 1:N_frames
    %print(['Frame ',num2str(i),'/',num2str(N_frames)])
    subplot(2,3,[1,2]);
        cla
        box on
        plot(ti(1:i),xi(1:i,1),'LineWidth',2);
        xlim([0,t(end)])
        ylim([0,1])
        xlabel('$t$ [s]','Interpreter','latex')
        ylabel('$q(t)$','Interpreter','latex')
        drawnow 
    subplot(2,3,[4,5]);
        cla
        plot(ti(1:i),xi(1:i,2),'r','LineWidth',2);
        xlim([0,t(end)])
        ylim([-4.5,4.5])
        xlabel('$t$ [s]','Interpreter','latex')
        ylabel('$v(t)$','Interpreter','latex')
        drawnow 
    subplot(2,3,[3,6]);
        cla
        box on
        plot(xi(1:i,1),xi(1:i,2),'k','LineWidth',2);
        xlim([0,1])
        ylim([-4.5,4.5])
        xlabel('$q(t)$','Interpreter','latex')
        ylabel('$v(t)$','Interpreter','latex')
        drawnow       
    f(i) = getframe(fig);
end
close all
[h, w, p] = size(f(1).cdata);  % use 1st frame to get dimensions
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf, 'position', [100 100 w h]);
axis off
movie(hf,f);
mplay(f)

%
v = VideoWriter('example1.avi','Motion JPEG AVI');
v.Quality = 95;
v.FrameRate = N_frames/t(end);
open(v)
writeVideo(v,f)
close(v)
%}