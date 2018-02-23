% A is Nx1 vector
% dir is 'ascend' or 'descend'
% Assuming distinct value

function fun_rank = findRanks(A,dir)
    [val] = sort(A,dir);
    fun_rank = zeros(numel(A),1);
    for i=1:numel(A)
        for j=1:numel(val)
            if(A(i)==val(j))
                fun_rank(i)=j;
                val(j)=-1;
                break;
            end
        end 
    end
end