clear;
clc;

load('mnist_all.mat');

% First find the accuracy for test3 and test8 - 2(b)
load('prob2d_output');

%%%%%%%%%%%%%%%%%%%%%%%%%%

% For test0
[m,~] = size(test0);
o2 = sigmoid(th1*[ones(m,1) double(test0)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass0 = sum(q==1)/m;
totacc = [sum(q==1) m];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For test1
[m,~] = size(test1);
o2 = sigmoid(th1*[ones(m,1) double(test1)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass1 = sum(q==2)/m;
totacc = [[sum(q==2) m];totacc];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For test2
[m,~] = size(test2);
o2 = sigmoid(th1*[ones(m,1) double(test2)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass2 = sum(q==3)/m;
totacc = [[sum(q==3) m];totacc];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For test3
[m,~] = size(test3);
o2 = sigmoid(th1*[ones(m,1) double(test3)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass3 = sum(q==4)/m;
totacc = [[sum(q==4) m];totacc];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For test4
[m,~] = size(test4);
o2 = sigmoid(th1*[ones(m,1) double(test4)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass4 = sum(q==5)/m;
totacc = [[sum(q==5) m];totacc];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For test5
[m,~] = size(test5);
o2 = sigmoid(th1*[ones(m,1) double(test5)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass5 = sum(q==6)/m;
totacc = [[sum(q==6) m];totacc];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For test6
[m,~] = size(test6);
o2 = sigmoid(th1*[ones(m,1) double(test6)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass6 = sum(q==7)/m;
totacc = [[sum(q==7) m];totacc];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% For test7
[m,~] = size(test7);
o2 = sigmoid(th1*[ones(m,1) double(test7)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass7 = sum(q==8)/m;
totacc = [[sum(q==8) m];totacc];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For test8
[m,~] = size(test8);
o2 = sigmoid(th1*[ones(m,1) double(test8)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass8 = sum(q==9)/m;
totacc = [[sum(q==9) m];totacc];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% For test9
[m,~] = size(test9);
o2 = sigmoid(th1*[ones(m,1) double(test9)]'); % 100*m matrix
o3 = sigmoid(th2*[ones(1,m);o2]); % r*m matrix

% Here r is 10
[~,q] = max(o3);
correctClass9 = sum(q==10)/m;
totacc = [[sum(q==10) m];totacc];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%

str = ['Accuracy for \n test0 = %.5f,'...
                      '\n test1 = %.5f,'...
                      '\n test2 = %.5f,'...
                      '\n test3 = %.5f,'...
                      '\n test4 = %.5f,'...
                      '\n test5 = %.5f,'...
                      '\n test6 = %.5f,'...
                      '\n test7 = %.5f,'...
                      '\n test8 = %.5f,'...
                      '\n test9 = %.5f\n\n,'];
fprintf(str,correctClass0*100,correctClass1*100,correctClass2*100,correctClass3*100,correctClass4*100,correctClass5*100,correctClass6*100,correctClass7*100,correctClass8*100,correctClass9*100);
totacc = sum(totacc);
fprintf('The total accuracy over all datasets is %.4f\n\n',(totacc(1)/totacc(2))*100);

