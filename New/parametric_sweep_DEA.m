N=7;
beta = 0.3:0.01:0.33;
%beta = 2/N;
n = 20; m = 4; s = 1; n_experts = 5;
[DMU, criteria] = load_data;
input_L = zeros(n,m+s);
input_M = zeros(n,m+s);
input_R = zeros(n,m+s);
weights = zeros(n_experts,3*(m+s));
mem = zeros(1,3);
format short;
for b = beta
    for i = 1:n
       for j = 1:(m+s)
           if (j>m)
               mem = beta_function(b, N, DMU(i,j));
           else
               mem = beta_function(b, N, N-DMU(i,j)+1);
           end
           input_L(i,j) = mem(1);
           input_M(i,j) = mem(2);
           input_R(i,j) = mem(3);
       end
    end
    for i = 1:n_experts
       for j = 1:(m+s)
           if (j>m)
               mem = beta_function(b, N, criteria(j,i));
			   weights(i,5*m+(j-m-1)*s+1) = mem(1);
			   weights(i,5*m+(j-m-1)*s+2) = mem(1);
			   weights(i,5*m+(j-m-1)*s+3) = mem(2);
			   weights(i,5*m+(j-m-1)*s+4) = mem(3);
			   weights(i,5*m+(j-m-1)*s+5) = mem(3);
           else
               mem = beta_function(b, N, N-criteria(j,i)+1);
			   weights(i,m*(j-1)+1) = mem(1);
			   weights(i,m*(j-1)+2) = mem(1);
			   weights(i,m*(j-1)+3) = mem(2);
			   weights(i,m*(j-1)+4) = mem(3);
			   weights(i,m*(j-1)+5) = mem(3);
           end
       end
        filename = sprintf('geoemtric_expert_%d_beta_%.2f.dat',i,b);
       try
        new(input_L ,input_M ,input_R,20,4,1,weights(i,:)',filename);
       catch
        %sprintf(getreport()+'%f____%d   ',b,i)
       end
    end
    
end