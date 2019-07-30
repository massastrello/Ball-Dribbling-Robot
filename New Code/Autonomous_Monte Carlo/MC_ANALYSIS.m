clear R
clear Ts

T = 0:1e-3:t(end);
ts_nom = resample(timeseries(x,t),T);


x_init = zeros(N_mc,4);
x_end = zeros(N_mc,4);
R(N_mc) = struct();
Ts(N_mc) = struct();
Ttot = [];
Xtot = [];
H0 = zeros(N_mc,1);

for i = 1:N_mc
    x_init(i,:) = DATA(i).xi(1,:);
    x_end(i,:) = DATA(i).xi(end,:);
    ts_i = resample(timeseries(DATA(i).xi,DATA(i).ti),T);
    %ri = ts_i.Data - ts_nom.Data;
    %R(i).ri = ri;
    Ts(i).x = ts_i.Data;
    H0(i) = (x_init(i,3).^2)./(2*m1) + (x_init(i,4).^2)./(2*m2) - m1*gamma.*x_init(i,1) -m2*gamma.*x_init(i,2);
    %Ttot = [Ttot;DATA(i).ti];
    %Xtot = [Xtot;DATA(i).xi];
end

%% Energy probability
figure()
pd = fitdist(H0,'Kernel');
x_values = 4.16:0.0001:4.18;
y = pdf(pd,x_values);
histogram(H0)
hold on
plot(x_values,y,'LineWidth',2)
hold off
%% Phase Gram
clear Pd
Pd(4) = struct();
%binWidth = 0.05;
for i = 1:4
    binCtrs = linspace(lb(i),ub(i),30);%lb(i):binWidth:ub(i);
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
    % plot
    centers = {T,binCtrs};
    [X,Y] = meshgrid(centers{1},centers{2});
    figure()
    waterfall(X,Y,Xi')
    colormap gray
    view([0,-1,1])
end 

centers = {T,binCtrs};
figure()
imagesc(centers{:}, Xt.')
colorbar
axis xy
hold on
plot(T,ts_nom.Data(:,1),'w','LineWidth',1)
hold off

%% Waterfall

figure()
waterfall(X,Y,Xt')
colormap gray
view([0,-1,1])

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