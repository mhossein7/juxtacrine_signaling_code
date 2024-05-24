function h = circle(x,y,r,fa,ea,color,ecolor)
hold off
th = 0:pi/50:2*pi;
xunit = r * cos(th) + x;
yunit = r * sin(th) + y;
h = fill(xunit, yunit,color,"FaceAlpha",fa,"EdgeColor",ecolor,"EdgeAlpha",ea,"LineWidth",3);
xlim([-20 20])
ylim([-20 20])
hold on
