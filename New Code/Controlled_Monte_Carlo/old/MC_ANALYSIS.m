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
etot = [];
gaintot = [];
q1tot = [];
q2tot = [];
p1tot = [];
p2tot = [];

for i = 1:N_mc
    x_init(i,:) = DATA(i).xi(1,:);
    x_end(i,:) = DATA(i).xi(end,:);
    ts_i = resample(timeseries(DATA(i).xi,DATA(i).ti),T);
    ri = ts_i.Data - ts_nom.Data;
    R(i).ri = ri;
    Ts(i).x = ts_i.Data;
    Ttot = [Ttot;DATA(i).ti];
    Xtot = [Xtot;DATA(i).xi];
    %
    etot = [etot,DATA(i).e(1:bounces_MC)];
    gaintot = [gaintot,DATA(i).gain(1:bounces_MC-1)];
    %q1tot = [q1tot,ts_i.Data(:,1)];
    %q2tot = [q2tot,ts_i.Data(:,2)];
    %p1tot = [p1tot,ts_i.Data(:,3)];
    %p2tot = [p2tot,ts_i.Data(:,4)];
end

%% Error & Gain
x_vector = [1:bounces_MC-1, fliplr(1:bounces_MC-1)];
figure()
subplot(211)
    patch = fill(x_vector,...
            [max(etot(2:end,:),[],2)',fliplr(min(etot(2:end,:),[],2)')],[243 169 114]./255);
    set(patch, 'edgecolor', 'none');
    set(patch, 'FaceAlpha', 0.5);
    hold on
    [e_mean,e_std] = plot_areaerrorbar(etot(2:end,:)');
    plot(e_nom(2:end),'k','LineWidth',2)
    hold off
subplot(212)
    patch = fill(x_vector,...
            [max(gaintot,[],2)',fliplr(min(gaintot,[],2)')],[243 169 114]./255);
    set(patch, 'edgecolor', 'none');
    set(patch, 'FaceAlpha', 0.5);
    hold on
    [gain_mean,gain_std] = plot_areaerrorbar(gaintot');
    plot(gain_nom,'k','LineWidth',2)
    hold off
        
%% Phase Gram
binWidth = 0.1;
binCtrs = 0:0.1:5;
n=length(T);
Xi = zeros(N_mc,1);
Xt = zeros(length(T),length(binCtrs));
for i = 1:length(T)
    for j = 1:N_mc
        Xi(j) = Ts(j).x(i,2);
    end
    Xt(i,:) = hist(Xi,binCtrs)/N_mc;    
end 
centers = {T,binCtrs};
figure()
imagesc(centers{:}, Xt.')
colorbar
axis xy
hold on
plot(T,ts_nom.Data(:,2),'w','LineWidth',1)
hold off

%% Waterfall
figure()
[X,Y] = meshgrid(centers{1},centers{2});
surf(X,Y,Xt','EdgeColor','none','FaceColor','interp')

i = 51;
figure()
hold on
while i>0
area(T,10.*Xt(:,i)+i*0.1,'FaceColor','w','EdgeColor','k')
i = i-1;
end

%{
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


figure(1)
subplot(211)
    hold on
    for i = 1:N_mc
        pp = plot(q1tot(:,i),p1tot(:,i),'b', 'LineWidth',2);
        pp.Color(4) = 0.01;
    end
    plot(ts_nom.Data(:,1),ts_nom.Data(:,3),'k')
    hold off
subplot(212)
    hold on
    for i = 1:N_mc
        pp = plot(q2tot(:,i),p2tot(:,i),'b', 'LineWidth',2);
        pp.Color(4) = 0.01;
    end
    plot(ts_nom.Data(:,2),ts_nom.Data(:,4),'k')
    hold off

figure(1)
scatter(x_end(:,1),x_end(:,3),'r')
hold on
scatter(x_init(:,1),x_init(:,3),'k')
hold off
%}