function [decoded_inds] = decoderCPGR(realization,Codes,N,r)

numb_code=sum(sum(realization)); %number received coded messages
coded=zeros(numb_code,N); % matrix for coded messages
code_ind=1;
for ind1=1:N
    for ind2=1:r
    if realization (ind1,ind2)==1
        coded(code_ind,:)=Codes(ind2,:,ind1); % add binary representation of coded messages
        code_ind=code_ind+1;
    end
        
    end
end
decoded=rref(coded);
decoded_nz=(rref(coded)==0);
decoded_loc=(sum(decoded_nz,2)==N-1);
decoded_inds=sum(decoded(decoded_loc,:));

end

