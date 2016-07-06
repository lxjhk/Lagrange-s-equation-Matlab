function dx = RR_Lagr(t,x)
dx = zeros(4,1);
dx(1) = x(2);
dx(2) = (10*cos(x(1))*sin(x(3)) - 2000*sin(x(1)) + t^2*cos(x(1))*cos(x(3)) - 400*x(2)^2*cos(x(1))*sin(x(1)) - 10*t*x(2)*sin(x(1))*sin(x(3)) + 2*t^2*cos(x(1))*cos(x(3))^2*sin(x(1)) + 400*x(2)^2*cos(x(1))*cos(x(3))^2*sin(x(1)) + 200*x(4)^2*cos(x(1))*cos(x(3))^2*sin(x(1)) + 2*t^2*cos(x(1))*sin(x(1))*sin(x(3))^2 + 400*x(2)^2*cos(x(1))*sin(x(1))*sin(x(3))^2 + 200*x(4)^2*cos(x(1))*sin(x(1))*sin(x(3))^2 - 40*t*x(4)*cos(x(1))*cos(x(3))^2*sin(x(1)) - 40*t*x(4)*cos(x(1))*sin(x(1))*sin(x(3))^2)/(200*(sin(x(1))^2 + cos(x(1))^2*cos(x(3))^2 + cos(x(1))^2*sin(x(3))^2));
dx(3) = x(4);
dx(4) = (10*cos(x(3)) - t^2*sin(x(3)) + 20*cos(x(3))^2*sin(x(1)) + 20*sin(x(1))*sin(x(3))^2 - 10*t*x(4)*sin(x(3)) + 40*t*x(2)*cos(x(1))*cos(x(3))^2 - 400*x(2)*x(4)*cos(x(1))*cos(x(3))^2 + 40*t*x(2)*cos(x(1))*sin(x(3))^2 - 400*x(2)*x(4)*cos(x(1))*sin(x(3))^2)/(200*(cos(x(3))^2*sin(x(1)) + sin(x(1))*sin(x(3))^2));