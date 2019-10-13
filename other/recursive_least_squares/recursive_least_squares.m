clear 
clc

%% Recursive Least Squares (RLS)
% Recursive least squares estimates model parameters recursively. This code
% is written based on below formulas: (to estimating nth theta)
% Y = X.theta
% k(n) = P(n-1). X(n)/(1 + X(n)'.P(n-1).X(n))
% theta(n) = theta(n-1) + k(n)(Y(n)-X(n)'.theta(n-1))
% P(n) = (I - k(n).X(n)')P(n-1)
% termination test: ||theta(n)-theta(n-1)|| < eps

%% Load data set
load X.mat
load Y.mat

%% 
[N_trials,N_parameters] = size(X);
delta = 10;             %  value to initialize P
eps = 0.001;

for i=1:N_trials
    input_i = (X(i,:))';
    if i==1
        P = delta*eye(N_parameters);                     %initial P
        theta = [1.5;1;2];                               %initial theta
    else
        k = P*input_i/(1+input_i'*P*input_i);
        theta = [theta theta(:,i-1)+k*( Y(i)-input_i'*theta(:,i-1) )];    %column i of theta represents estimated theta in step-i 
        P=(eye(N_parameters)-k*input_i')*P;
        termination_test = norm(theta(:,i)-theta(:,i-1));
        if termination_test < eps
            break
        end
    end
end
final_theta = theta(:,end);