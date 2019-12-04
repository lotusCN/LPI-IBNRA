close all
clear
tic

%% import data
load('..\data\PLI.mat');
load('..\data\PPI.mat');
load('..\data\Lnc_exp.mat');

%% protein-protein interaction score matrix AP
T=sqrt(sum(PPI,2)*sum(PPI,2)');
T(T==0)=eps;
AP = PPI./T;

%% lncRNA-lncRNA similarity matrix AL
AL=abs(corrcoef(Lnc_exp'));

%% LOOCV
lambda=0.7;
gama=0.5;
[np,nl]=size(PLI);
score_matrix=zeros(np,nl); 
 
index1=find(1==PLI(:,:));  %the indices of known lncRNA-protein interactions
index0=find(0==PLI(:,:));  %the indices of unknown lncRNA-protein interacitons
M1=zeros(np,nl);  %the result of known lncRNA-protein interactions
M0=zeros(np,nl);  %the result of unknown lncRNA-protein interactions

for i=1:length(index1)
    i
    test=PLI;
    test(index1(i))=0;
    result = LPI_IBNRA( test,AP,AL,lambda,gama ) ; 
    M1(index1(i))=result(index1(i)) ;
    M0=M0+result;    
end
M0=M0/i;  
M0(index1)=0;  
score_matrix=M1+M0;   

%% plot ROC curve
auc=plot_roc(score_matrix(:),PLI(:),'r')  

toc