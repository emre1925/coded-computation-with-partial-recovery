function [ time, decoded_inds, numb_message] = tol_req_check( ft, Codes, tolerance, N, m )
r=length(m);
N_t=N*(1-tolerance); %the number of different indecies required
ftsorted=sort(reshape(ft,1,N*r));
%%%%%%%%%%%%%%%%%%%%%%Decoding Part%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t_ind = N_t;
flag=0;
while t_ind < N*r && flag==0
realization=uint64(ft<=ftsorted(t_ind));
[decoded_inds] = decoderCPGR(realization,Codes,N,r);
if sum(decoded_inds)>= N_t
    flag=1;
    time = ftsorted(t_ind);
    numb_message = sum(sum(realization));
end
t_ind=t_ind+1;
end

end

