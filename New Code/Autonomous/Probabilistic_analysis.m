clear x y

x(4) = struct();
x(1).x = linspace(0,5,10000); x(2).x = linspace(0,2,10000);
x(3).x = linspace(-1,1,10000); x(4).x = linspace(-1.5,1.5,10000);
%
y(4) = struct();

method = 'Kernel';
for i = 1:4
    pd_init = fitdist(x_init(:,i),method);pd_end = fitdist(x_end(:,i),method);
    y(i).y_init = pdf(pd_init,x(i).x); 
    y(i).y_end = pdf(pd_end,x(i).x);
end

figure(4)
subplot(221)
    yyaxis left
        histogram(x_init(:,1),'Normalization','pdf')
        hold on
        plot(x(1).x,y(1).y_init,'LineWidth',2)
        hold off
    yyaxis right
        histogram(x_end(:,1),'Normalization','pdf')
        hold on
        plot(x(1).x,y(1).y_end,'LineWidth',2)
        hold off
    xlim([0,5])
subplot(222)
    yyaxis left
        histogram(x_init(:,2),'Normalization','pdf')
        hold on
        plot(x(2).x,y(2).y_init,'LineWidth',2)
        hold off
    yyaxis right
        histogram(x_end(:,2),'Normalization','pdf')
        hold on
        plot(x(2).x,y(2).y_end,'LineWidth',2)
        hold off
    xlim([0,2])
subplot(223)
    yyaxis left
        histogram(x_init(:,3),'Normalization','pdf')
        hold on
        plot(x(3).x,y(3).y_init,'LineWidth',2)
        hold off
    yyaxis right
        histogram(x_end(:,3),'Normalization','pdf')
        hold on
        plot(x(3).x,y(3).y_end,'LineWidth',2)
        hold off
subplot(224)
    yyaxis left
        histogram(x_init(:,4),'Normalization','pdf')
        hold on
        plot(x(4).x,y(4).y_init,'LineWidth',2)
        hold off
    yyaxis right
        histogram(x_end(:,4),'Normalization','pdf')
        hold on
        plot(x(4).x,y(4).y_end,'LineWidth',2)
        hold off
    xlim([-1.5,1.5])  
    
    