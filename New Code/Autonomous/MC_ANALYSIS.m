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