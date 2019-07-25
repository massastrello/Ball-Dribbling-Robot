
%
tsin = timeseries(x,t);
tsout = resample(tsin,0:1e-3:t(end));
xr = tsout.data;
%
N = 2;
it = size(xr,1);
skip = 5;
% figure parameters
width = 4;
hight = 4;
figure(1)
r = 1;
axis([0, width, -2*r, hight])
ax = gca;
ax.NextPlot = 'replaceChildren';
F(it) = struct('cdata',[],'colormap',[]);
r = 1;
%
i = 1;
while i <= floor(it/2)
    %
    figure(1)
    clf
    box on
    %set(gcf,'units','centimeters','position',[0,0,width,hight])
    plot([0,width]',[1;1],':g','LineWidth',1.5)
    drawcircle(width/2,xr(i,1)+r,r,(hight-xr(i,1))/2,[0.2,0.2],[0.5,0.5,0.5])
    hold on
    drawcircle(width/2,xr(i,2)-r,r,r,[1,1],[1,0,0])
    if abs(xr(i,2)-xr(i,1))-h<1e-4
        plot([width/2,width/2],[xr(i,2),xr(i,1)],'b','LineWidth',1.5)
    end
    hold off    
    axis([0,width,-2*r, hight])
    drawnow
    
    F(i) = getframe;
    i = i+skip;
end
%
i = floor(it/2);
while i>0
    if isequal(F(i).cdata,[])
        F(i) = [];
    end
    i = i-1;
end
%
v = VideoWriter('BB1.avi', 'Motion JPEG AVI');
v.Quality = 100;
v.FrameRate = 30;
open(v)
for i = 1:it/2
writeVideo(v,F(i));
end
close(v)
%
function drawcircle(x,y,r1,r2,shape,color)
d = r1*2;
px = x-r1;
py = y-r1;
rectangle('Position',[px py d 2*r2],'Curvature',shape,'FaceColor',color);
daspect([1,1,1])
end