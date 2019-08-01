clear R
clear Ts

T = 0:5*1e-3:t(end);
ts_nom = resample(timeseries(x,t),T);


x_init = zeros(N_mc,4);
x_end = zeros(N_mc,4);
R(N_mc) = struct();
Ts(N_mc) = struct();
Ttot = [];
Xtot = [];
H0 = zeros(N_mc,1);
Hend = zeros(N_mc,1);

for i = 1:N_mc
    x_init(i,:) = DATA(i).xi(1,:);
    x_end(i,:) = DATA(i).xi(end,:);
    ts_i = resample(timeseries(DATA(i).xi,DATA(i).ti),T);
    Ts(i).x = ts_i.Data;
    H0(i) = (x_init(i,3).^2)./(2*m1) + (x_init(i,4).^2)./(2*m2) - m1*gamma.*x_init(i,1) -m2*gamma.*x_init(i,2);
    Hend(i) = (x_end(i,3).^2)./(2*m1) + (x_end(i,4).^2)./(2*m2) - m1*gamma.*x_end(i,1) -m2*gamma.*x_end(i,2);
    %ri = ts_i.Data - ts_nom.Data;
    %R(i).ri = ri;
    %Ttot = [Ttot;DATA(i).ti];
    %Xtot = [Xtot;DATA(i).xi];
end

%% Phase Gram
clear Pd
Pd(4) = struct();
nbins = 30;
for i = 1:4
    binCtrs = linspace(lb(i),ub(i),nbins);
    n=length(T);
    Xj = zeros(N_mc,1);
    Xi = zeros(length(T),length(binCtrs));
    for j = 1:length(T)
        for k = 1:N_mc
            Xj(k) = Ts(k).x(j,i);
        end
        Xi(j,:) = hist(Xj,binCtrs)/N_mc;
    end     
    Pd(i).Xi = Xi;
    centers = {T,binCtrs};
    [Pd(i).X,Pd(i).Y] = meshgrid(centers{1},centers{2});
end 

figure()
%set(gcf,'renderer','Painters','color','w')
%
subplot(4,1,1)
    waterfall(Pd(1).X,Pd(1).Y,Pd(1).Xi')
    %colormap gray
    view([0.1,-1,1])
    grid off
    xlim([0,20])
    ylim([lb(1),ub(1)])    
    title('Robot Position','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$q_1(t)$ [m]','Interpreter','latex')
    set(gca,'Units','normalized','FontUnits','points',...
            'FontWeight','normal','FontSize',9,...
            'FontName','Times','Layer', 'Top',...
            'Color','none','ZColor','none')
subplot(4,1,2)
    waterfall(Pd(2).X,Pd(2).Y,Pd(2).Xi')
    %colormap gray
    view([0.1,-1,1])
    grid off
    xlim([0,20])
    ylim([lb(2),ub(2)])      
    title('Ball Position','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$q_2(t)$ [m]','Interpreter','latex')
    set(gca,'Units','normalized','FontUnits','points',...
            'FontWeight','normal','FontSize',9,...
            'FontName','Times','Layer', 'Top',...
            'Color','none','ZColor','none')    
subplot(4,1,3)
    waterfall(Pd(3).X,Pd(3).Y,Pd(3).Xi')
    %colormap gray
    view([0.1,-1,1])
    grid off
    xlim([0,20])
    ylim([lb(3),ub(3)])      
    title('Robot Momentum','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$p_1(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,'Units','normalized','FontUnits','points',...
            'FontWeight','normal','FontSize',9,...
            'FontName','Times','Layer', 'Top',...
            'Color','none','ZColor','none')
subplot(4,1,4)
    waterfall(Pd(4).X,Pd(4).Y,Pd(4).Xi')
    colormap gray
    view([0.1,-1,1])
    grid off
    xlim([0,20])
    ylim([lb(4),ub(4)])     
    title('Ball Momentum','Interpreter','latex')
    xlabel('$t$ [s]','Interpreter','latex')
    ylabel('$p_2(t)$ [Kg$\cdot$m$/$s]','Interpreter','latex')
    set(gca,'Units','normalized','FontUnits','points',...
            'FontWeight','normal','FontSize',9,...
            'FontName','Times','Layer', 'Top',...
            'Color','none','ZColor','none')     
        
%{
figure()
subplot(211)
    [X,Y] = meshgrid(centers{1},centers{2});
    surf(X,Y,Xt','EdgeColor','none','FaceColor','interp')
subplot(212)
    i = length(binCtrs);
    hold on
    while i>0
        area(T,1.*Xt(:,i)+i*0.05,'FaceColor','w','EdgeColor','k')
        i = i-1;
    end
%
%
figure()
[X,Y] = meshgrid(centers{1},centers{2});
surf(X,Y,Xt','EdgeColor','none','FaceColor','interp')

[Xq,Yq] = meshgrid(T,0:0.005:1.8);
Xtq = interp2(X,Y,Xt',Xq,Yq,'cubic');
figure()
surf(Xq,Yq,Xtq,'EdgeColor','none','FaceColor','interp')

%}


%{
T = 0:1e-3:t(end);
ts_nom = resample(timeseries(x,t),T);


x_init = zeros(N_mc,4);
x_end = zeros(N_mc,4);
R(N_mc) = struct();
Ts(N_mc) = struct();
Ttot = [];
Xtot = [];
for i = 1:N_mc
    x_init(i,:) = DATA(i).xi(1,:);
    x_end(i,:) = DATA(i).xi(end,:);
    ts_i = resample(timeseries(DATA(i).xi,DATA(i).ti),T);
    ri = ts_i.Data - ts_nom.Data;
    R(i).ri = ri;
    Ts(i).x = ts_i.Data;
    Ttot = [Ttot;DATA(i).ti];%T];
    Xtot = [Xtot;DATA(i).xi];%ri];
end

figure(1)
%subplot(121)
scatter(x_end(:,1),x_end(:,3),'r')
hold on
scatter(x_init(:,1),x_init(:,3),'k')
hold off

%subplot(122)
figure(2)
hold on
for i = 1:N_mc
    scatter(T,R(i).ri(:,1),'.r')
end
x1 = Xtot(:,1);
[values, centers] = hist3([Ttot(:) x1(:)],[401 51]);
figure(3)
imagesc(centers{:}, values.')
colorbar
axis xy

binWidth = 0.1;
binCtrs = 0:0.1:5;
n=length(T);
Xi = zeros(N_mc,1);
Xtot = zeros(length(T),length(binCtrs));
for i = 1:length(T)
    for j = 1:N_mc
        Xi(j) = Ts(j).x(i,1);
    end
    Xtot(i,:) = hist(Xi,binCtrs)/N_mc;    
end 

centers = {T,binCtrs};
figure(4)
imagesc(centers{:}, Xtot.')
colorbar
axis xy
hold on
plot(T,ts_nom.Data(:,1),'w','LineWidth',1)
hold off

Data = x_end(:,2); %just making up some junk data
   binWidth = 0.1; %This is the bin width
   binCtrs = 0:0.1:3; %Bin centers, depends on your data
   n=length(Data);
   counts = hist(Data,binCtrs);
   prob = counts /n;
   H = bar(binCtrs,prob,'hist');
   set(H,'facecolor',[0.5 0.5 0.5]);
%}