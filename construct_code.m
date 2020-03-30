function [ Codes ] = construct_code( N, m )
d=1:N; % data assignment
r=length(m); % number of message and computation
cm=cumsum(m); 
total=sum(m);
%%%%%%%%%%%%%%%%%%%%Data%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%Assignment%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
shift_params = randsample(N,total);
D=zeros(total,N);
for i=1:total
    D(i,:)=circshift(d,shift_params(i));
end
%%%%%%%%%%%%%%%%%%%%%%%Support matrix of the codes%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Codes=zeros(r,N,N);
for i=1:N %for each user
    for j=1:r %for each codeword        
        if j==1
           Codes(j,D(j,i),i)=1;
        else
            for k=cm(j-1)+1:cm(j)
                Codes(j,D(k,i),i)=1; %%% Codes(j,:,i) shows the computations contained in the jth message of ith user (index of non-zero values )
            end 
        end
    end
    
end


end

