
clear ; close all; clc

syms t m l r g;
q1 = sym('q1(t)');
q2 = sym('q2(t)');
V = -m*g*l*cos(q1);
T = (m/2)*((l*cos(q1)*diff(q1,t)*cos(q2)-diff(q2,t)*l*sin(q2)*sin(q1)+0.1*t*l*sin(q1)*sin(q2))^2) + (m/2)*((diff(q1,t)*l*sin(q1))^2) + ...
(m/2)*((r*0.1*t + 0.1*t*l*sin(q1)*cos(q2) - l*cos(q1)*diff(q1,t)*sin(q2) - l*sin(q1)*diff(q2,t)*cos(q2))^2);
L = expand(T - V);

% The function deriv(f, g) differentiates a symbolic expression f with
% respect to the variable g, where the variable g is a function of time g =
% g(t). The statement diff(f,'x') differentiates f with respect to the free
% variable x. In Matlab the free variable x cannot be a function of time and
% that is why the function deriv was introduced

Ldq1 = deriv(L, diff(q1,t));
Ldq2 = deriv(L, diff(q2,t));

Lt1 = diff(Ldq1, t);
Lt2 = diff(Ldq2, t);

Lq1 = deriv(L, q1);
Lq2 = deriv(L, q2);

LHS1 = Lt1 - Lq1;
LHS2 = Lt2 - Lq2;

Lagrange1 = LHS1;
Lagrange2 = LHS2;

data = {m, l, r, g};
datn = {0.5, 1, 0.5, 10};

Lagran1 = subs(Lagrange1, data, datn);
Lagran2 = subs(Lagrange2, data, datn);

%The two second order Lagrange’s equations have to be rewritten your as
%a first order system and two Matlab lists are created


% ql qn
% ----------------------------
% diff(’q1(t)’,t,2) -> ddq1n
% diff(’q2(t)’,t,2) -> ddq2n
% diff(’q1(t)’,t) -> dq1n
% diff(’q2(t)’,t) -> dq2n
% ’q1(t)’ -> q1n
% ’q2(t)’ -> q1n

ql = {diff(q1,t,2), diff(q2,t,2), diff(q1,t), diff(q2,t), q1, q2};
qf = {'ddq1', 'ddq2', 'x(2)', 'x(4)', 'x(1)', 'x(3)'};



Lagra1 = subs(Lagran1, ql, qf);
Lagra2 = subs(Lagran2, ql, qf);

sol = solve(Lagra1,Lagra2,'ddq1, ddq2');
Lagr1 = sol.ddq1;
Lagr2 = sol.ddq2;

%The system of differential equations is solved numerically by m-file func
%tions. The function file, RR Lagr.m is created using the statements

dx2dt = char(Lagr1);
dx4dt = char(Lagr2);
fid = fopen('RR_Lagr.m','w+');
fprintf(fid,'function dx = RR_Lagr(t,x)\n');
fprintf(fid,'dx = zeros(4,1);\n');
fprintf(fid,'dx(1) = x(2);\n');
fprintf(fid,'dx(2) = ');
fprintf(fid,dx2dt);
fprintf(fid,';\n');
fprintf(fid,'dx(3) = x(4);\n');
fprintf(fid,'dx(4) = ');
fprintf(fid,dx4dt);
fprintf(fid,';');
fclose(fid);

fprintf('\nProgram paused. Press enter to continue.\n');
pause;

%The ode45 solver is used for the system of differential equations

t0 = 0; tf = 60; time = [0 tf];
x0 = [-pi/18 0 pi/6 0];
[t,xs] = ode45(@RR_Lagr, time, x0);
x1 = xs(:,1);
x2 = xs(:,2);
x3 = xs(:,3);
x4 = xs(:,4);

subplot(2,2,1),plot(t,x1*180/pi,'r'),xlabel('time (s)'),ylabel('q1 (deg)'),grid,...
subplot(2,2,2),plot(t,x3*180/pi,'b'),xlabel('time (s)'), ylabel('q2 (deg)'),grid,...
subplot(2,2,3),plot(x1,x3),xlabel('q1 (rad)'), ylabel('q2 (rad)'),grid,...
subplot(2,2,4),plot(x3,x1),,xlabel('q2 (rad)'), ylabel('q1 (rad)'),grid

[ts,xs] = ode45(@RR_Lagr,0:0.1:10,x0);
fprintf('Results \n'); fprintf('\n');
fprintf(' t(s)   q1(rad)   dq1(rad/s)    q2(rad)    dq2(rad/s) \n');


[ts,xs]
