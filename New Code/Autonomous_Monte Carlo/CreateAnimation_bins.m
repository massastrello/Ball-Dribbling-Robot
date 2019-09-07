close all

N_frames = 1000;
%ts_nom = resample(timeseries(Xmc(1).Xmc_i,T),linspace(0,t(end),N_frames));
%x_nom = ts_nom.data;

clear TS
TS(4) = struct();
for i = 1:4
    ts_i = resample(timeseries(Xmc(i).Xmc_i,T),linspace(0,t(end),N_frames));
    TS(i).x = ts_i.data;
end
q1_data = TS(1).x;
q2_data = TS(2).x;
p1_data = TS(3).x;
p2_data = TS(4).x;

drawArrow = @(x,y,varargin) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0, varargin{:} );       
width = 4;
hight = 5;
r = 1;
fig = figure('position',[100 100 600 300]);
f(N_frames) = struct('cdata',[],'colormap',[]);


for i = 1:N_frames
    %print(['Frame ',num2str(i),'/',num2str(N_frames)])
    subplot(1,2,1);
        cla
        box on
        scatter(TS(1).x(i,:),TS(3).x(i,:))
        xlim([0,5])
        xlim([lb(1),ub(1)]) 
        ylim([lb(3),ub(3)]) 
        drawnow
    subplot(1,2,2);
        cla
        box on
        scatter(TS(2).x(i,:),TS(4).x(i,:))
        xlim([lb(2),ub(2)]) 
        ylim([lb(4),ub(4)]) 
        drawnow       
    f(i) = getframe(fig);
end
close all
[h, w, p] = size(f(1).cdata);  % use 1st frame to get dimensions
hf = figure; 
% resize figure based on frame's w x h, and place at (150, 150)
set(hf, 'position', [150 150 w h]);
axis off
movie(hf,f);
mplay(f)

%
v = VideoWriter('ProbPlot.avi','Motion JPEG AVI');
v.Quality = 95;
v.FrameRate = N_frames/t(end);
open(v)
writeVideo(v,f)
close(v)