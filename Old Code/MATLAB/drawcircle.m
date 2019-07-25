function drawcircle(x,y,r)
d = r*2;
px = x-r;
py = y-r;
rectangle('Position',[px,py,d,d],'Curvature',[1,1],'FaceColor',[1,0,0]);
daspect([1,1,1])
end
    
    