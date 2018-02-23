rating = xlsread('rating_system.xlsx','Sheet1');

A = xlsread('phone_rating.xlsx','Sheet1'); % Rating data (1 to 5)
n = size(A,1); % number of DMUs
col = size(A,2); %number of coulmns
result = zeros(n,col,5);                   % ITFN from Rating data
for i=1:n
    for j=1:col
       k=A(i,j);
       result(i,j,:)=rating(k,:);
    end
end
delete('phone_data.xlsx');
for i=1:5
    xlswrite('phone_data.xlsx',result(:,:,i),sprintf('Sheet%d',i));
end
