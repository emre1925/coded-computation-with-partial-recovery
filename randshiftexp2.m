function [rt] = randshiftexp2(mu,alpha,s)
rv=rand;
rt=((log(1-rv)/(-mu))+alpha)*s;
end


