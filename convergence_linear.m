%%%%%%%%%%%%%%%% Linear regression centralized %%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Matrix-Vector scenario %%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%% Fixed tolerance
%%%%%%%%%%% Fixed iteration
%%%%%%%%%%% We plot the convergence of accuracy and the average per iteration completion time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%SETUP%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
numb_sim=10;
T=80;
lr=0.1;
N=40; %number of workers
m=[1 2 3]; % message orders
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Data size and model size %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

leng=1000; % length of data
train_size=2000; %size of the training data set

% % smaller size
% leng=200; % length of data
% train_size=200; %size of the training data set
test_size=400; %size of the test data set

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%Data construction%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
theta=rand(leng,1); % true theta value
X=zeros(train_size,leng); %training matrix
X_test=zeros(test_size,leng); %test matrix
mu1=1.5*theta/leng;
mu2=-mu1;

%create sentetic training data set
for i=1:train_size
    X(i,:)=normrnd(mu1,ones(leng,1))+normrnd(mu2,ones(leng,1));
end
% create sentetic test data set
for i=1:test_size
    X_test(i,:)=normrnd(mu1,ones(leng,1))+normrnd(mu2,ones(leng,1));
end
Y=X*theta; % true labels for training set
Y_test=X_test*theta;
%%%%%%%%%%%%%%%%%%%%%%%%%initial data process%%%%%%%%%%%%%%%%%%%%%%%%
W=X'*X;
XY=X'*Y;
%%%%%%%%%%%%%%%%% Code construction %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Codes=construct_code(N,m);
%%%%%%%%%%%%%%%%% Computation time parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mu=10;
alpha=0.01;
%%%%%%%%%%%%%%%%%%%%%%%tolerance levels
tol_vec=[0.00 0.15 0.3];
acc_results=zeros(length(tol_vec),T,numb_sim);
time_results=zeros(length(tol_vec),numb_sim);
message_count=zeros(length(tol_vec),numb_sim);
for sim_ind=1:numb_sim
for tol_ind=1:length(tol_vec)
tol=tol_vec(tol_ind);
time_prcc=0;
numb_message=0;
theta_PRCC = 0.1*ones(leng,1); % theta with PRCC update
for iter=1:T
    grad_PRCC=(W*theta_PRCC-XY)/train_size; %normalize the gradient
    ft = comp_time_real_linear( mu, alpha, m, N );
    [ time, decoded_inds, numb_comm] = tol_req_check( ft, Codes, tol, N, m );
    time_prcc=time_prcc+time/T;
    numb_message = numb_message + numb_comm/T;
    [ theta_PRCC ] = model_update_linear( theta_PRCC, grad_PRCC, decoded_inds,N,lr);
    error=Y_test-X_test*theta_PRCC;
    acc_results(tol_ind,iter,sim_ind)=(sum(error.*error))/test_size;
end
time_results(tol_ind,sim_ind)=time_prcc;
message_count(tol_ind,sim_ind) = numb_message;
end
end
acc_results=sum(acc_results,3);
time_results=mean(time_results,2);
message_count=mean(message_count,2);
plot(acc_results(1,:),'-*','LineWidth',2)
hold on 
plot(acc_results(2,:),'-o','LineWidth',2)
hold on 
plot(acc_results(3,:),'-d','LineWidth',2)
xlabel('Number of iteration','FontSize',20)
ylabel('Test error','FontSize',20)
grid on
h_legend=legend('q=0','q=0.15','q=0.3');
set(gca,'fontsize',12);
set(h_legend,'FontSize',16);

