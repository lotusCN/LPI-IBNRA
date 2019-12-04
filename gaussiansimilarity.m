function [kp,kl] = gaussiansimilarity(interaction,np,nl)

    %calculate gamad for Gaussian kernel calculation
    gamad = np/(norm(interaction,'fro')^2);
    %calculate Gaussian kernel for the similarity between protein: kp
    C=interaction;
    kp=zeros(np,np);
    D=C*C';
    for i=1:np
        for j=i:np
           kp(i,j)=exp(-gamad*(D(i,i)+D(j,j)-2*D(i,j)));
        end
    end
    kp=kp+kp'-diag(diag(kp));


    %calculate gamam for Gaussian kernel calculation
    gamam = nl/(norm(interaction,'fro')^2);
    %calculate Gaussian kernel for the similarity between lncRNA: kl
    kl=zeros(nl,nl);
    E=C'*C;
    for i=1:nl
        for j=i:nl
          kl(i,j)=exp(-gamam*(E(i,i)+E(j,j)-2*E(i,j)));
        end
    end
    kl=kl+kl'-diag(diag(kl));
end