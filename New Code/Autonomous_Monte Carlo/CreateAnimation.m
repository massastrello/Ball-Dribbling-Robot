close all

N_frames = 1000;
ts_nom = resample(timeseries(x,t),linspace(0,t(end),N_frames));
x_nom = ts_nom.data;

clear TS
TS(3) = struct();
for i = 1:3
    ts_i = resample(timeseries(DATA(i).xi,DATA(i).ti),linspace(0,t(end),N_frames));
    TS(i).x = ts_i.data;
end

drawArrow = @(x,y,varargin) quiver( x(1),y(1),x(2)-x(1),y(2)-y(1),0, varargin{:} );       
width = 4;
hight = 5;
r = 1;

%fig = figure('position',[100 100 300 500]);'Visible', 'off',
fig = figure(1);
set(gcf, 'color', [1,1,1],'position',[1 1 1024 2048])
f(N_frames) = struct('cdata',[],'colormap',[]);
for i = N_frames:N_frames
    %print(['Frame ',num2str(i),'/',num2str(N_frames)])
    subplot(2,2,1);
        cla
        box on
        plot([0,4],[1,1],':','lineWidth',8)
        hold on
        DrawCircle(width/2,x_nom(i,1)+r,r,(hight-x_nom(i,1))/2,[0.2,0.2],[0.5,0.5,0.5])
        DrawCircle(width/2,x_nom(i,2)-r,r,r,[1,1],[1,0,0])
        drawArrow([width/2,width/2],[x_nom(i,1)+r,x_nom(i,1)+r+x_nom(i,3)],'linewidth',1.5,'color','k')
        drawArrow([width/2,width/2],[x_nom(i,2)-r,x_nom(i,2)-r+x_nom(i,4)],'linewidth',1.5,'color','k')
        hold off    
        axis([0,width,-2*r, hight])
         set(gca,...
        'Units','normalized',...
        'FontUnits','points',...
        'FontWeight','normal',...
        'FontSize',30,...
        'linewidth',4,...
        'FontName','Times',...
        'Layer', 'Top')
        drawnow
    for j = 1:3
        subplot(2,2,j+1);
            cla
            box on
            plot([0,4],[1,1],':','lineWidth',8)
            hold on
            DrawCircle(width/2,TS(j).x(i,1)+r,r,(hight-TS(j).x(i,1))/2,[0.2,0.2],[0.5,0.5,0.5])
            DrawCircle(width/2,TS(j).x(i,2)-r,r,r,[1,1],[1,0,0])
            drawArrow([width/2,width/2],[TS(j).x(i,1)+r,TS(j).x(i,1)+r+TS(j).x(i,3)],'linewidth',1.5,'color','k')
            drawArrow([width/2,width/2],[TS(j).x(i,2)-r,TS(j).x(i,2)-r+TS(j).x(i,4)],'linewidth',1.5,'color','k')
            
            hold off    
            axis([0,width,-2*r, hight])
             set(gca,...
            'Units','normalized',...
            'FontUnits','points',...
            'FontWeight','normal',...
            'FontSize',30,...
            'linewidth',4,...
            'FontName','Times',...
            'Layer', 'Top')
            drawnow
    end
    %subplot(2,2,2);
    %    plot(rand(1,10));
        
    f(i) = getframe(fig);
end


v = VideoWriter('caos_multi.mp4','MPEG-4');
v.Quality = 100;
v.FrameRate = 30%N_frames/t(end);
open(v)
writeVideo(v,f)
close(v)
