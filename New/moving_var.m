function best_beta  = moving_var()
best_beta = -1*ones(5,1);
upper = [.72 .57 .65 .57 .61 ];
W = 10;
n = 20;
for i=1:5
    min_ = 10000;
	for k=1:upper(1,i)*100-W+2
		
	end
    for k=1:upper(1,i)*100-W+2
        file_name = sprintf('geoemtric_expert_%d_beta_%.2f.csv',i,(k-1)/100.0);
        in = csvread(file_name);
        temp_mat = zeros(n,W);
        for j = k:k+W-1
            temp_mat(:,j-k+1) = in(:,4);
        end
        val = max(std(temp_mat,0,2));
        if val < min_
            min_ = val;
            best_beta(i,1) = round((k+k+W-1)/200.0,2);
        end
    end
    
end