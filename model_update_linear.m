function [ theta ] = model_update_linear( theta, grad_theta, decoded_inds,N,lr)
bs = length(theta)/N; % block size 
for i=1:N
    if (decoded_inds(i) == 1)
       theta((i-1)*bs+1:i*bs) = theta((i-1)*bs+1:i*bs)- grad_theta((i-1)*bs+1:i*bs)*lr;
    end
    
end


end

