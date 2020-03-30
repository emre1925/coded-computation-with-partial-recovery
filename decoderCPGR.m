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
decoded=rref(coded); % reduced row echelon
decoded_loc=(sum(decoded,2)==1); % use row wise sum to check if the decoding possible those rows shows the decoded ones
decoded_inds=sum(decoded(decoded_loc,:)); % first remove all other rows than the decodable ones 
%than check the position of the 1s to lable decoded indicies.

end

