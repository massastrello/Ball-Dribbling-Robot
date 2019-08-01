close all

alpha = 0.01;
skip = 1;
trace_color = [243 169 114]./255;
N_plot = N_mc;
set(groot,{'DefaultAxesXColor','DefaultAxesYColor','DefaultAxesZColor'},{'k','k','k'})
modificatorF{1} = 'k';               modificatorF{2} = 'LineWidth'; 
modificatorF{3} = 1.5;               modificatorJ{1} = '-.';
modificatorJ{2} = 'LineWidth';       modificatorJ{3} = 1.5;
modificatorJ{4} = 'Marker';          modificatorJ{5} = 'o';
modificatorJ{6} = 'MarkerEdgeColor'; modificatorJ{7} = 'r'; 
modificatorJ{8} = 'MarkerFaceColor'; modificatorJ{9} = 'r';
modificatorJ{10} = 'MarkerSize';     modificatorJ{11} = 1;
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
figure(1)
set(gcf,'renderer','Painters','color','w')
subplot(221)
    cla
    hold on
    for i = 1:N_plot
        pp = plot(DATA(i).ti(1:skip:end),DATA(i).xi(1:skip:end,1),'Color',trace_color);
        pp.Color(4) = alpha;
    end
    hold off
    %
    box on
    ylim([0,5])    
    title('Robot Position','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$q_1(t)$ [m]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Visible','off')
    F = getframe(gca);
    imwrite(F.cdata, '11.png');
    
subplot(222)
    cla
    hold on
    for i = 1:N_plot
        pp = plot(DATA(i).ti(1:skip:end),DATA(i).xi(1:skip:end,2),'Color',trace_color);
        pp.Color(4) = alpha;
    end
    %
    box on
    ylim([0,2])
    hold off
    title('Ball Position','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$q_2(t)$ [m]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Visible','off')
    F = getframe(gca);
    imwrite(F.cdata, '12.png');
    
subplot(223)
    cla
    hold on
    for i = 1:N_plot
        pp = plot(DATA(i).ti(1:skip:end),DATA(i).xi(1:skip:end,3),'Color',trace_color);
        pp.Color(4) = alpha;
    end
    hold off
    %
    box on
    ylim([-1,1])
    title('Robot Momentum','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$p_1(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Visible','off')
    F = getframe(gca);
    imwrite(F.cdata, '21.png');
subplot(224)
    cla
    hold on
    ylim([-1.5,1.5])
    for i = 1:N_plot
        pp = plot(DATA(i).ti(1:skip:end),DATA(i).xi(1:skip:end,4),'Color',trace_color);
        pp.Color(4) = alpha;
    end
    hold off
    %
    box on
    title('Ball Momentum','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$p_2(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Visible','off')
    F = getframe(gca);
    imwrite(F.cdata, '22.png');

close(1)
figure(1)
set(gcf,'renderer','Painters')
subplot(221)
    cla
    ylim([0,5])
    hold on
    I = imread('11.png'); 
    %h = image(xlim,ylim,I); 
    h = image('CData',I,'XData',[0 20],'YData',fliplr(ylim));
    uistack(h,'bottom')
    scatter(0,q1nom(1),15,'b','filled')
    plotHarc(t,jnom,x(:,1),[],modificatorF,modificatorJ);
    hold off
    %
    box on
    title('Robot Position','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$q_1(t)$ [m]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Layer', 'Top')    
subplot(222)
    cla
    ylim([0,2])
    hold on
    I = imread('12.png'); 
    %h = image(xlim,ylim,I); 
    h = image('CData',I,'XData',[0 20],'YData',fliplr(ylim));
    uistack(h,'bottom')
    scatter(0,q2nom(1),15,'b','filled')
    plotHarc(t,jnom,x(:,2),[],modificatorF,modificatorJ);
    hold off
    %
    box on
    title('Ball Position','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$q_2(t)$ [m]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Layer', 'Top')
subplot(223)
    cla
    ylim([-1,1])
    hold on
    I = imread('21.png'); 
    %h = image(xlim,ylim,I); 
    h = image('CData',I,'XData',[0 20],'YData',fliplr(ylim));
    uistack(h,'bottom')
    scatter(0,p1nom(1),15,'b','filled')
    plotHarc(t,jnom,x(:,3),[],modificatorF,modificatorJ);
    hold off
    %
    box on
    title('Robot Momentum','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$p_1(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Layer', 'Top')
subplot(224)
    cla    
    ylim([-1.5,1.5])
    hold on
    I = imread('22.png'); 
    %h = image(xlim,ylim,I); 
    h = image('CData',I,'XData',[0 20],'YData',fliplr(ylim));
    uistack(h,'bottom')
    scatter(0,p2nom(1),15,'b','filled')
    plotHarc(t,jnom,x(:,4),[],modificatorF,modificatorJ);
    hold off
    %
    box on
    title('Ball Momentum','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$p_2(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Layer', 'Top')
    
% save figure
%export_fig chaos1.pdf -q101 -transparent
%}
%{
figure(1)
set(gcf,'renderer','Painters')
subplot(221)
    cla
    hold on
    for i = 1:N_plot
        pp = plot(DATA(i).ti(1:skip:end),DATA(i).xi(1:skip:end,1),'b');
        pp.Color(4) = alpha;
    end
    plotHarc(t,jnom,x(:,1),[],modificatorF,modificatorJ);
    hold off
    %
    box on
    title('Robot Position','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$q_1(t)$ [m]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times')
subplot(222)
    cla
    hold on
    for i = 1:N_plot
        pp = plot(DATA(i).ti(1:skip:end),DATA(i).xi(1:skip:end,2),'b');
        pp.Color(4) = alpha;
    end
    plotHarc(t,jnom,x(:,2),[],modificatorF,modificatorJ);
    %
    box on
    hold off
    title('Ball Position','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$q_2(t)$ [m]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times')
subplot(223)
    cla
    hold on
    for i = 1:N_plot
        pp = plot(DATA(i).ti(1:skip:end),DATA(i).xi(1:skip:end,3),'b');
        pp.Color(4) = alpha;
    end
    plotHarc(t,jnom,x(:,3),[],modificatorF,modificatorJ);
    hold off
    %
    box on
    title('Robot Momentum','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$p_1(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times')
subplot(224)
    cla
    hold on
    for i = 1:N_plot
        pp = plot(DATA(i).ti(1:skip:end),DATA(i).xi(1:skip:end,4),'b');
        pp.Color(4) = alpha;
    end
    plotHarc(t,jnom,x(:,4),[],modificatorF,modificatorJ);
    hold off
    %
    box on
    title('Ball Momentum','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$p_2(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times')
print -depsc2 -tiff -r300 -painters traj.eps
print -dpdf -r300 -painters traj.pdf
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
set(gcf,'renderer','Painters','color','w')
subplot(121)
    cla
    hold on
    for i = 1:N_plot
        pp = plot(DATA(i).xi(1:skip:end,1),DATA(i).xi(1:skip:end,3),'Color',trace_color);
        pp.Color(4) = alpha;
    end
    hold off
    box on
    xlim([0,5])
    ylim([-1,1])    
    title('Robot State-Space','Interpreter','latex')
    xlabel('$q_1(t)$ [m]','Interpreter','latex')
    ylabel('$p_1(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca, 'Units','normalized','FontUnits','points','FontWeight','normal',...
        'FontSize',9,'FontName','Times','Visible','off')
    F = getframe(gca);
    imwrite(F.cdata, '11ss.png');
subplot(122)
    cla
    hold on
    for i = 1:N_plot
        pp = plot(DATA(i).xi(1:skip:end,2),DATA(i).xi(1:skip:end,4),'Color',trace_color);
        pp.Color(4) = alpha;
    end
    %
    box on
    xlim([0,2])
    ylim([-1.5,1.5])    
    hold off
    title('Ball State-Space','Interpreter','latex')
    xlabel('$q_2(t)$ [m]','Interpreter','latex')
    ylabel('$p_2(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca, 'Units','normalized','FontUnits','points','FontWeight','normal',...
        'FontSize',9,'FontName','Times','Visible','off')
    F = getframe(gca);
    imwrite(F.cdata, '21ss.png');
close(2)
figure(2)
set(gcf,'renderer','Painters')
subplot(121)
    cla
    xlim([0,5])
    ylim([-1,1])
    hold on
    I = imread('11ss.png');
    h = image('CData',I,'XData',xlim,'YData',fliplr(ylim));
    uistack(h,'bottom')
    plot(q1nom,p1nom,':k', 'LineWidth',1.5)
    scatter(q1nom(1),p1nom(1),15,'b','filled')
    hold off
    box on
    title('Robot State-Space','Interpreter','latex')
    xlabel('$q_1(t)$ [m]','Interpreter','latex')
    ylabel('$p_1(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Layer', 'Top')    
subplot(122)
    cla
    xlim([0,2])
    ylim([-1.5,1.5])
    hold on
    I = imread('21ss.png'); 
    h = image('CData',I,'XData',xlim,'YData',fliplr(ylim));
    uistack(h,'bottom')
    plot(q2nom,p2nom,':k', 'LineWidth',1.5)
    scatter(q2nom(1),p2nom(1),15,'b','filled')
    hold off
    box on
    title('Ball State-Space','Interpreter','latex')
    xlabel('$q_2(t)$ [m]','Interpreter','latex')
    ylabel('$p_2(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Layer', 'Top')
    
% save figure
%export_fig chaos2.pdf -q101 -transparent
%{
figure(2)
set(gcf,'renderer','Painters')
subplot(211)
    cla
    hold on
    for i = 1:N_plot
        scatter(DATA(i).xi(1,1),DATA(i).xi(1,3),'.r')
        pp = plot(DATA(i).xi(:,1),DATA(i).xi(:,3),'b', 'LineWidth',2);
        pp.Color(4) = alpha;
    end
    plot(q1nom,p1nom,':k', 'LineWidth',1)
    hold off
    %
    box on
    title('Robot State-Space','Interpreter','latex')
    xlabel('$q_1(t)$ [m]','Interpreter','latex')
    ylabel('$p_1(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times')
subplot(212)
    cla
    hold on
    for i = 1:N_plot
        scatter(DATA(i).xi(1,2),DATA(i).xi(1,4),'.r')
        pp = plot(DATA(i).xi(:,2),DATA(i).xi(:,4),'b', 'LineWidth',2);
        pp.Color(4) = alpha;
    end
    plot(q2nom,p2nom,':k', 'LineWidth',1)
    hold off
    %
    box on
    title('Ball State-Space','Interpreter','latex')
    xlabel('$q_2(t)$ [m]','Interpreter','latex')
    ylabel('$p_2(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times')
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
set(gcf,'renderer','Painters')
cla
hold on
for i = 1:N_plot
    %scatter(DATA(i).ti(1),DATA(i).Hi(1),'.r')
    pp = plot(DATA(i).ti,DATA(i).Hi,'Color',trace_color, 'LineWidth',1);
    pp.Color(4) = alpha;
    pp2 = scatter(0,DATA(i).Hi(1),15,'b','filled');
    pp2.MarkerFaceAlpha = alpha;
end
%
box on
xlim([0,20])
ylim([4.16,4.18])  
hold off
title('Ball State-Space','Interpreter','latex')
xlabel('$q_2(t)$ [m]','Interpreter','latex')
ylabel('$p_2(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
set(gca, 'Units','normalized','FontUnits','points','FontWeight','normal',...
'FontSize',9,'FontName','Times','Visible','off')
F = getframe(gca);
imwrite(F.cdata, 'H.png');
close(3)

figure(3)
box on
xlim([0,20])
ylim([4.16,4.18]) 
hold on
I = imread('H.png'); 
h = image('CData',I,'XData',xlim,'YData',fliplr(ylim));
uistack(h,'bottom')
plotHarc(t,jnom,Hnom,[],modificatorF,modificatorJ);
hold off
box on
title('System''s Energy','Interpreter','latex')
xlabel('$t$ [s]','Interpreter','latex')
ylabel('$\mathcal{H}(t)$ [J]','Interpreter','latex')
set(gca,...
    'Units','normalized',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',9,...
    'FontName','Times',...
    'Layer', 'Top')
%
%export_fig chaos3.pdf -q101 -transparent
%
delete '11.png' '12.png' '21.png' '22.png' '11ss.png' '21ss.png' 'H.png'