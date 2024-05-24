
clc


dt = 1e-5;
h = 0.1;
R = 10;
T = 100;
D = 1;
N = R/h;
n = ceil(T/dt);
C0 = 0.5;
L0 = 1.5;

u = zeros(n,3);
v = zeros(n,R/h);

u(1,:) = [C0/R,L0,0];
v(1,:) = C0/R;

kp = 0.0027; %for dark
%kp = 0.1; %for light
km = 0.001;

F = D*dt/(h^2);
A = zeros(N,N);

A(1,1) = 1-2*F;
A(1,2) = 2*F;
A(N,N) = 1-2*F;
A(N,N-1) = 2*F;
for i=2:N-1
    A(i,i) = 1-2*F;
    A(i,i-1) = F;
    A(i,i+1) = F;
end

for i=1:T/dt
    %Step 1, solving the reaction 
    u(i+1,1) = u(i,1) + dt *(km*u(i,3) - kp*u(i,2)*u(i,1));
    u(i+1,2) = u(i,2) + dt *(km*u(i,3) - kp*u(i,2)*u(i,1));
    u(i+1,3) = u(i,3) + dt *(-km*u(i,3) + kp*u(i,2)*u(i,1));

    %Step 2, solving the diffusion 
    v(i+1,:) = (A*v(i,:)')';
    B = km*u(i,3) - kp*u(i,2)*u(i,1);
    v(i+1,N) = v(i+1,N) + 2*B*F*h;

    u(i+1,1) = v(i+1,N);


end
span = linspace(0,T,(T/dt)+1);
figure()
hold on
plot(span,u(:,3))
plot(span,u(:,2),"Color","black")
plot(span,u(:,1),"Color","red")


length = 100;
red = [1, 0, 0];
pink = [255, 192, 203]/255;
colors_p = [linspace(pink(1),red(1),length)', linspace(pink(2),red(2),length)', linspace(pink(3),red(3),length)'];


figure()
imagesc(v)
colormap(colors_p)
colorbar







%%
% plotting the rings


%min_dark = ;
%%
min_light= min(v(n,:));
%alp = linspace(0.01,1,N);
%% plotting at t=0
figure('Position', [10 10 600 600])
hold on
rectangle('Position',[-15 -15 30 30],LineWidth=2)

r = linspace(0, R+h, N+1);                               
a = linspace(0, 2*pi, 150);                             
[Rp,A] = ndgrid(r, a);                                   
Z = repmat([v(1,:) u(1,3)]',1,150);                                                
[X,Y,Z] = pol2cart(A,Rp,Z);                              

surf(X, Y, Z)
view(0, 90)
axis([-17.5  17.5 -17.5 17.5 -17.5 17.5])
colormap(colors_p)
shading('interp')

caxis([min_light C0/R])
colorbar
grid on



%% plotting at t= 100
figure('Position', [10 10 600 600])
hold on
rectangle('Position',[-15 -15 30 30],LineWidth=2)

r = linspace(0, R+h, N+1);                               
a = linspace(0, 2*pi, 150);                             
[Rp,A] = ndgrid(r, a);                                   
Z = repmat([v(n,:) u(n,3)]',1,150);                                                
[X,Y,Z] = pol2cart(A,Rp,Z);                              

surf(X, Y, Z)
view(0, 90)
axis([-17.5  17.5 -17.5 17.5 -17.5 17.5])
colormap(colors_p)
shading('interp')

caxis([min_light C0/R])
colorbar
grid on

%% Calculating the ratios

dark_ratio = (u(n,3)+u(n,1))/(C0/R);

%%

light_ratio = (u(n,3)+u(n,1))/(C0/R);

%%
figure('Position', [10 10 600 600]), clf

hold off
for i=1:10000:n


r = linspace(0, R+h, N+1);                               
a = linspace(0, 2*pi, 150);                             
[Rp,A] = ndgrid(r, a);                                   
Z = repmat([v(i,:) u(i,3)]',1,150);                                                
[X,Y,Z] = pol2cart(A,Rp,Z);                              

surf(X, Y, Z)
view(0, 90)
axis([-15  15 -15 15 -15 15])
colormap(colors_p)
shading('interp')



pause(0.05)


end















