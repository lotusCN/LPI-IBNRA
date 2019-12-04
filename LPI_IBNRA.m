function S_fin = LPI_IBNRA(I,AP,AL,lambda,gama ) 

    %% Gaussian interaction profile kernel similarity KP,KP
    [np,nl]=size(I);
    [KP,KL] = gaussiansimilarity(I,np,nl);  

    %% integrated similarity Sim_P,Sim_L
    Sim_P=zeros(np,np);
    Sim_P(find(AP~=0))=(AP(find(AP~=0))+KP(find(AP~=0)))/2;
    Sim_P(find(AP==0))=KP(find(AP==0));
    Sim_L=(AL+KL)/2;


    %% integrated initial resource score S_ini
    SP=Sim_P*I.*I./sum(Sim_P,2);
    SL=I*Sim_L.*I./sum(Sim_L);   
    S_ini=(gama*SP+(1-gama)*SL)/2;

    %% two-round resource allocation
    W=zeros(np,np) ;    % W:weight matrix 
    S_fin=zeros(np,nl); % S_fin:finial score matrix 
    for i=1:np  
        i;                 
        A=bsxfun(@times,S_ini,S_ini(i,:)) ;
        d_lk=sum(S_ini) ; 
        B=bsxfun(@rdivide,A,d_lk);  
        B(find(isnan(B)==1))=0;
        sigma_B=sum(B,2);   
        d_pj=sum(S_ini,2); 
        W(i,:)=sigma_B./(d_pj) ;  
        W(i,find(isnan(W(i,:))==1))=0;
    end

    %% second-order corrlelation elimiation 
    W=W-lambda*(W^2);  
    S_fin=W*S_ini;   

end



