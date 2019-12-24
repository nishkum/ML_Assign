% This script solves the last part of que(2)

%clear the command window and workspace
clc;
clear;

% Possible Tau's to plot
TauVal = [0.1 0.3 0.8 2 10];
useColor = ['b' 'r' 'm' 'c' 'g'];


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

hold on;
% Plot the data
scatter(NX,NY,'*k');

% Plot for weighted Linear Regression from normal equation 
datap = 100;
minX = min(NX);
maxX = max(NX);
plx = linspace(minX,maxX,datap);

ply = zeros(size(plx));

for k=1:size(TauVal,2)
    for i=1:datap
        % Call the localWT function to calculate and return the value of y at
        % this point

       ply(i) = localWT(datax , datay , plx(i) , TauVal(k));
    end
    plot(plx, ply , useColor(k),'LineWidth',1.5);
end

xlabel('x');
ylabel('y');
leg = cell(size(TauVal));
for i=1:size(TauVal,2)
    leg{i} = ['Tau = ' num2str(TauVal(i))];
end

title('Locally weighted Linear Regression with different Tau','FontSize',13,'Color','k');

leg = legend('Data Points',leg{1},leg{2},leg{3},leg{4},leg{5},'Location','SouthEast');
set(leg,'FontSize',13);