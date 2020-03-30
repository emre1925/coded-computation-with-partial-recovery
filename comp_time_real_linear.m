function [ ft ] = comp_time_real_linear( mu, alpha, m, N )
r=length(m);
ft=zeros(N,r);
for i=1:N
    rv=randshiftexp2(mu,alpha,r);   
    ft(i,:)=(1:r)*(1/r)*rv;
end
end

