% constants
clc
clear all
r = 10 ; %um
th = 0.01; %nm

C1 = 0.5 ; %SSPB/ uM
C2 = 1.5 ; %iLID/ uM

kml = 0.1;
kmd = 10 ;
kpl = 1/kml;
kpd = 1/kmd;


D = 0.0001 ; %SSPB diffusion constant


kp = kpl;
km = kml;

P = [r th kp km D];
[t,x] = ode45(@(t,x)odefcn(t,x,P),[0 5],[C1 C1 C2 0]); 
%%
hold on
plot(t,x(:,1),"red","linewidth",2)
plot(t,x(:,2),"yellow","linewidth",2)
plot(t,x(:,3),"blue","linewidth",2)
plot(t,x(:,4),"color",[1 0.35 0],"linewidth",2)
legend("Luminal SspB","Membrane-adjacent SspB","iLID","SspB-iLID dimer")
legend boxoff
xlabel("Time")
ylabel("Planar concentration")
hold off
max_comp = max(x(:,4));
%%
figure('Position', [10 10 600 600]), clf
hold off
for i=1:97
fa = x(i,1)/C1;
ea = x(i,4)/max_comp;
circle(0,0,10,fa*0.75,ea,"red","red")

pause(0.05)
exportgraphics(gcf,'testAnimated.gif','Append',true);

end