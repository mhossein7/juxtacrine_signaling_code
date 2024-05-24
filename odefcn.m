function dxdt = odefcn(t,x,P)

r = P(1);
th = P(2);
kp = P(3);
km = P(4);
D = P(5);


dxdt = zeros(4,1);

J = (x(1)-x(2))/th * D * 2*pi*r;

dxdt(1) = -J;
dxdt(2) = km*x(4) - kp*x(2)*x(3)+J;
dxdt(3) = km*x(4) - kp*x(2)*x(3);
dxdt(4) = kp*x(2)*x(3)-km*x(4);

end

