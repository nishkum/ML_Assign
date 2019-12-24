% This script solves the first 2 parts of que(2)

%clear the command window and workspace
clc;
clear;

% Set the bandWidth Parameter
bandWid = 0.8;


% Load the data
X = importdata('q3x.dat');
Y = importdata('q3y.dat');

% No. of training data examples
m = size(X,1);

% Normalize the data
NX = normalize(X);
% Donot normalize Y
NY = Y;

% Add X_0 to the columns to get datax
datax = [ones(size(NX)) NX];
datay = NY;



%%%%%%%%%%%%%%%%%%%%%%% UNWEIGHTED %%%%%%%%%%%%%%%%%%%%

% Implement the unweighted linear regression using normal equation
unWeighTheta = (inv(datax'*datax))*datax'*datay;

fprintf('Unweighted Theta: \n[Theta0 = %f , Theta1 = %f]\n\n', unWeighTheta);

hold on;
% Plot the data
scatter(NX,NY,'*k');

% Plot this theta corresponding to unweighted linear regression
plot(NX,datax*unWeighTheta);



%%%%%%%%%%%%%%%%%%%%%%% WEIGHTED %%%%%%%%%%%%%%%%%%%%%%

% Now the part (b)

% Plot this theta for weighted Linear Regression from normal equation 
datap = 100;
minX = min(NX);
maxX = max(NX);
plx = linspace(minX,maxX,datap);

ply = zeros(size(plx));
for i=1:datap
    % Call the localWT function to calculate and return the value of y at
    % this point
    
   ply(i) = localWT(datax , datay , plx(i) , bandWid);
end

plot(plx, ply , 'r','LineWidth',2);

title('Unweighted and Locally weighted Linear Regression with Tau=0.8','FontSize',12.5,'Color','k');

xlabel('x');
ylabel('y');

leg = legend('Data Points' , 'UnWeighted LR estimate','Weighted LR estimate with Tau=0.8','Location','SouthEast');
set(leg,'FontSize',13);