close all
skip = 1;

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
figure(1)
set(gcf,'renderer','Painters')
subplot(221)
    cla
    plotHarc(t,jnom,x(:,1),[],modificatorF,modificatorJ);
    %xlim([4.5,5])
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
    plot([0,2.5094,2.5094,t(end)],([0.1,0.1,q2md,q2md]),':g','LineWidth',1.5)
    hold on
    plotHarc(t,jnom,x(:,2),[],modificatorF,modificatorJ);
    hold off
    %
    %xlim([4.5,5])
    box on
    title('Ball Position','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$q_2(t)$ [m]','Interpreter','latex')
    legend('$q_{2,max}^*$','Interpreter','latex')
    set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',9,...
        'FontName','Times',...
        'Layer', 'Top')
subplot(223)
    cla
    plotHarc(t,jnom,x(:,3),[],modificatorF,modificatorJ);
    %
    %xlim([4.5,5])
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
    plotHarc(t,jnom,x(:,4),[],modificatorF,modificatorJ);
    %
    %xlim([4.5,5])
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
%export_fig nom_autonomous.pdf -q101 -transparent
%}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(2)
set(gcf,'renderer','Painters')
subplot(121)
    cla
    %plot(q1nom,p1nom,':k', 'LineWidth',1.5)
    plotHarc(q1nom,jnom,p1nom,[],modificatorF,modificatorJ);
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
    %plot(q2nom,p2nom,':k', 'LineWidth',1.5)
    plotHarc(q2nom,jnom,p2nom,[],modificatorF,modificatorJ);
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
%export_fig reg2.pdf -q101 -transparent
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(3)
set(gcf,'renderer','Painters')
box on
plotHarc(t,jnom,Hnom,[],modificatorF,modificatorJ);
%
%xlim([4.5,5])
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
%export_fig reg3.pdf -q101 -transparent
%
figure(4)
set(gcf,'renderer','Painters')
subplot(311)
    box on
    xlim([0,t(end)])
    hold on
    plot(t,K1,'r','LineWidth',1.5)
    plot(t,V1,'b','LineWidth',1.5)
    plotHarc(t,jnom,H1,[],modificatorF,modificatorJ);
    hold off
    %xlim([4.5,5])
    title('Robot''s Energy','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$\mathcal{H}_1(t)$ [J]','Interpreter','latex')
    legend('$p_1^2(t)/2m_1$','$\mathcal{V}_1(t)$','Interpreter','latex')
    set(gca,...
    'Units','normalized',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',9,...
    'FontName','Times',...
    'Layer', 'Top')
subplot(312)
    box on
    xlim([0,t(end)])
    hold on
    plot(t,K2,'r','LineWidth',1.5)
    plot(t,V2,'b','LineWidth',1.5)
    plotHarc(t,jnom,H2,[],modificatorF,modificatorJ);
    hold off
    %xlim([4.5,5])
    title('Ball''s Energy','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$\mathcal{H}_2(t)$ [J]','Interpreter','latex')
    legend('$p_2^2(t)/2m_2$','$\mathcal{V}_2(t)$','Interpreter','latex')
    set(gca,...
    'Units','normalized',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',9,...
    'FontName','Times',...
    'Layer', 'Top')
subplot(313)
    box on
    hold on
    plot(t,H1,'r','LineWidth',1.5)
    plot(t,H2,'b','LineWidth',1.5)    
    plotHarc(t,jnom,Hnom,[],modificatorF,modificatorJ);
    hold off
    %xlim([4.5,5])
    title('Total Energy','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$\mathcal{H}(t)$ [J]','Interpreter','latex')
    legend('$\mathcal{H}_1(t)$','$\mathcal{H}_2(t)$','Interpreter','latex')
    set(gca,...
    'Units','normalized',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',9,...
    'FontName','Times',...
    'Layer', 'Top')
%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(5)
set(gcf,'renderer','Painters')
subplot(121)
    box on
    xlim([1,length(gain)])
    hold on
    plot(1:length(gain),e,'k','LineWidth',2)
    hold off
    title('Tracking Error','Interpreter','latex')
    xlabel('$\xi$','Interpreter','latex')
    ylabel('$e(\xi)$','Interpreter','latex')
    set(gca,...
    'Units','normalized',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',9,...
    'FontName','Times',...
    'Layer', 'Top')
subplot(122)
    box on
    xlim([1,length(gain)])
    hold on
    plot(1:length(gain),gain-gain_i,'b','LineWidth',1.5)
    plot(1:length(gain),gain_i,'r','LineWidth',1.5)
    plot(1:length(gain),gain,'k','LineWidth',2)
    hold off
    title('Energy Shaping Gain (hit state)','Interpreter','latex')
    xlabel('$\xi$','Interpreter','latex')
    ylabel('$\varphi_{\xi}$','Interpreter','latex')
    legend('$10e(\xi)$','$100\sum_i^\xi e(i)$','Interpreter','latex')
    set(gca,...
    'Units','normalized',...
    'FontUnits','points',...
    'FontWeight','normal',...
    'FontSize',9,...
    'FontName','Times',...
    'Layer', 'Top')