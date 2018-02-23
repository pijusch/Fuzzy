function final_ranking  = harmonic(path,n)
Files=dir(path);
final_ranking = zeros(n,5);


for i=1:5
    c = 0;
    values = zeros(n,2);
    for g=1:n
        values(g,1) = g;
    end
    for k=1:length(Files)
        temp = strsplit(Files(k).name,'_');
        c = c+1;
        if str2num(cell2mat(temp(3))) == i
            in = csvread(Files(k).name);
            for j = 1:n
                values(in(j,5),2) = values(in(j,5),2)+1/j;
            end
        end
    end
    values(:,2) = c./values(:,2);
    values = sortrows(values,2);
    final_ranking(:,i) = values(:,1);
    
end