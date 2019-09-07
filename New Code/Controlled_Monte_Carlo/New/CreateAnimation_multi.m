close all
trace_color = [243 169 114]./255;
N_frames = 1000;
ts_nom = resample(timeseries(x,t),linspace(0,t(end),N_frames));
x_nom = ts_nom.data;
Nl = 10;
clear TS
TS(Nl) = struct();
for i = 1:Nl
    ts_i = resample(timeseries(DATA(i).xi,DATA(i).ti),linspace(0,t(end),N_frames));
    TS(i).x = ts_i.data;
    TS(i).t = ts_i.Time;
end


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
        hold on
        for j = 1:Nl
            plot(TS(j).t(1:i),TS(j).x(1:i,1),'LineWidth',4,'Color',trace_color);
        end
        plot(ti(1:i),xi(1:i,1),'LineWidth',8);
        hold off
        xlim([0,t(end)])
        ylim([0,2])
        xlabel('$t$ [s]','Interpreter','latex')
        ylabel('$q_1(t)$','Interpreter','latex')
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
        plot([0,t(end)],[1,1],':k','LineWidth',4)
        hold on
        for j = 1:Nl
            plot(TS(j).t(1:i),TS(j).x(1:i,2),'LineWidth',4,'Color',trace_color);
        end
        plot(ti(1:i),xi(1:i,2),'LineWidth',8);
        hold off
        xlim([0,t(end)])
        ylim([0,1.5])
        xlabel('$t$ [s]','Interpreter','latex')
        ylabel('$q_2(t)$','Interpreter','latex')
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
        hold on
        for j = 1:Nl
            pp = plot(TS(j).t(1:i),TS(j).x(1:i,1),'LineWidth',4,'Color',trace_color);
            pp.Color(4) = 0.2;
        end
        plot(TS(j).x(1:i,1),TS(j).x(1:i,2),'LineWidth',8);
        hold off
        pp.Color(4) = 0.2;
        xlim([0,2])
        ylim([0,1.5])
        xlabel('$q_1(t)$','Interpreter','latex')
        y = ylabel('$q_2(t)$','Interpreter','latex');
        set(y, 'Units', 'Normalized', 'Position', [-0.05, 0.5, 0]);
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