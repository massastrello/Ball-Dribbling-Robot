clear x_plot y

x_plot(4) = struct();
x_plot(1).x = linspace(0,5,10000); x_plot(2).x = linspace(0,2,10000);
x_plot(3).x = linspace(-1,1,10000); x_plot(4).x = linspace(-1.5,1.5,10000);
%
y(4) = struct();

method = 'Kernel';
for i = 1:4
    pd_init = fitdist(x_init(:,i),method);pd_end = fitdist(x_end(:,i),method);
    y(i).y_init = pdf(pd_init,x_plot(i).x); 
    y(i).y_end = pdf(pd_end,x_plot(i).x);
end

figure()
set(gcf,'renderer','Painters','color','w')
subplot(221)
    yyaxis right
        histogram(x_end(:,1),'Normalization','pdf');
        hold on
        plot(x_plot(1).x,y(1).y_end,'LineWidth',2)
        hold off
        ylabel('$\psi_f(q_1)$','Interpreter','latex')     
    yyaxis left
        histogram(x_init(:,1),'Normalization','pdf')
        hold on
        plot(x_plot(1).x,y(1).y_init,'LineWidth',2)
        ylabel('$\psi_i(q_1)$','Interpreter','latex')   
    xlim([0,5])
    title('Robot Position','Interpreter','latex')
    xlabel('$q_1$ [m]','Interpreter','latex')
    set(gca,'Units','normalized','FontUnits','points',...
            'FontWeight','normal','FontSize',9,...
            'FontName','Times','Layer', 'Top')
    set(gca, 'SortMethod', 'depth')
subplot(222)
    yyaxis left
        histogram(x_init(:,2),'Normalization','pdf')
        hold on
        plot(x_plot(2).x,y(2).y_init,'LineWidth',2)
        hold off
        ylabel('$\psi_i(q_2)$','Interpreter','latex')
    yyaxis right
        histogram(x_end(:,2),'Normalization','pdf')
        hold on
        plot(x_plot(2).x,y(2).y_end,'LineWidth',2)
        hold off
        ylabel('$\psi_f(q_2)$','Interpreter','latex')
    xlim([0,2])
    title('Ball Position','Interpreter','latex')
    xlabel('$q_2$ [m]','Interpreter','latex')
    set(gca,'Units','normalized','FontUnits','points',...
            'FontWeight','normal','FontSize',9,...
            'FontName','Times','Layer', 'Top')
    set(gca, 'SortMethod', 'depth')    
subplot(223)
    yyaxis left
        histogram(x_init(:,3),'Normalization','pdf')
        hold on
        plot(x_plot(3).x,y(3).y_init,'LineWidth',2)
        hold off
        ylabel('$\psi_i(p_1)$','Interpreter','latex')
    yyaxis right
        histogram(x_end(:,3),'Normalization','pdf')
        hold on
        plot(x_plot(3).x,y(3).y_end,'LineWidth',2)
        hold off
        ylabel('$\psi_f(p_1)$','Interpreter','latex')
    title('Robot Momentum','Interpreter','latex')
    xlabel('$p_1(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,'Units','normalized','FontUnits','points',...
            'FontWeight','normal','FontSize',9,...
            'FontName','Times','Layer', 'Top')
    set(gca, 'SortMethod', 'depth')
subplot(224)
    yyaxis left
        histogram(x_init(:,4),'Normalization','pdf')
        hold on
        plot(x_plot(4).x,y(4).y_init,'LineWidth',2)
        hold off
        ylabel('$\psi_i(p_2)$','Interpreter','latex')
    yyaxis right
        histogram(x_end(:,4),'Normalization','pdf')
        hold on
        plot(x_plot(4).x,y(4).y_end,'LineWidth',2)
        hold off
        ylabel('$\psi_f(p_2)$','Interpreter','latex')
    xlim([-1.5,1.5])  
    title('Ball Momentum','Interpreter','latex')
    xlabel('$p_2(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,'Units','normalized','FontUnits','points',...
            'FontWeight','normal','FontSize',9,...
            'FontName','Times','Layer', 'Top')
    set(gca, 'SortMethod', 'depth')
    
figure()
pd_H0 = fitdist(H0,'Kernel');
pd_Hend = fitdist(Hend,'Kernel');
x_plot2 = 0:0.0001:5;
y_H0 = pdf(pd_H0,x_plot2);
y_Hend = pdf(pd_Hend,x_plot2);

%% Energy 
figure()
yyaxis left
    histogram(H0,'Normalization','pdf')
    hold on
    plot(x_plot2,y_H0,'LineWidth',2)
    hold off
yyaxis right
    histogram(Hend,'Normalization','pdf')
    hold on
    plot(x_plot2,y_Hend,'LineWidth',2)
    hold off
xlim([0,5]) 