function DrawCircle(x,y,r1,r2,shape,color)
d = r1*2;
px = x-r1;
py = y-r1;
rectangle('Position',[px py d 2*r2],'Curvature',shape,'FaceColor',color);
daspect([1,1,1])
end