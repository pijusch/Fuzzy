% input1 = [17 148 97 86 ; 15 129 148 48; 22 158 157 53; 23 165 178 70; 20 155 91 62; 51 252 228 87; 31 233 217 83; 29 202 150 78; 27 241 187 97; 47 262 246 97; 51 302 258 142; 34 281 248 119];
% input2 =  [20 151 100 90; 19 131 150 50; 25 160 160 55; 27 168 180 72; 22 158 94 66; 55 255 230 90; 33 235 220 88; 31 206 152 80; 30 244 190 100; 50 268 250 100; 53 306 260 147; 38 284 250 120];
% input3 = [23 153 103 95; 22 134 151 53; 28 163 163 57; 29 170 183 74; 25 161 97 68; 58 258 231 93; 36 236 223 92; 34 208 154 83; 32 246 194 102; 54 271 253 104; 55 308 261 149; 40 286 256 123];
% input1d =  [15 145 95 84; 12 127 146 45; 20 154 154 50; 22 163 176 67; 18 153 89 60; 49 250 226 85; 29 230 215 81; 27 200 148 76; 24 238 183 94; 44 260 244 95; 48 300 256 140; 32 280 243 117];
% input3d=  [25 154 105 97; 26 136 153 55; 30 165 165 59; 33 172 185 75; 27 163 99 71; 60 260 232 95; 39 238 225 95; 36 210 155 84; 35 248 196 104; 55 273 255 105; 57 309 262 152; 41 287 258 125];
function E = OIFDEA(input1 ,input2 ,input3,n,m,s,epsilon)
input1d = input1;
input3d = input3;
%     n=12;
%     m=2;
%     s=2;

W = zeros(n,5*(m+s));
E = zeros(1,n);
Y = [ input1d(:,m+1:m+s) input1(:,m+1:m+s) 4*input2(:,m+1:m+s) input3(:,m+1:m+s) input3d(:,m+1:m+s) ];
X = [ input1d(:,1:m) input1(:,1:m) 4*input2(:,1:m) input3(:,1:m) input3d(:,1:m) ];
options  = optimoptions('linprog','Algorithm','dual-simplex','Display','none');
for k = 1:n
    A = [Y -X];
    for i = 1:s
        temp = [zeros(1,m*5+5*s)];
        temp(1,i) =1;
        temp(1,s+i) = -1;
        A = [A; temp];
    end
    for i = 1:s
        temp = [zeros(1,m*5+5*s)];
        temp(1,i+s) =1;
        temp(1,2*s+i) = -1;
        A = [A; temp];
        %A = [A ; zeros(1,s) 1 0 -1 0 zeros(1,m*5+2*s)];
        %A = [A ; zeros(1,s) 0 1 0 -1 zeros(1,m*5+2*s)];
    end
    for i = 1:s
        temp = [zeros(1,m*5+5*s)];
        temp(1,i+2*s) =1;
        temp(1,3*s+i) = -1;
        A = [A; temp];
        %A = [A ; zeros(1,2*s) 1 0 -1 0 zeros(1,m*5+s)];
        %A = [A ; zeros(1,2*s) 0 1 0 -1 zeros(1,m*5+s)];
    end
    for i = 1:s
        temp = [zeros(1,m*5+5*s)];
        temp(1,i+3*s) =1;
        temp(1,4*s+i) = -1;
        A = [A; temp];
        %A = [A ; zeros(1,3*s) 1 0 -1 0 zeros(1,m*5)];
        %A = [A ; zeros(1,3*s) 0 1 0 -1 zeros(1,m*5)];
    end
    
    for i=1:m
        temp = [zeros(1,m*5+5*s)];
        temp(1,i+5*s+3*m) =1;
        temp(1,5*s+i+4*m) = -1;
        A = [A; temp];
        %         A = [A; zeros(1,5*s+3*m) 1 0 -1 0 ];
        %         A = [A; zeros(1,5*s+3*m) 0 1 0 -1 ];
    end
    for i=1:m
        
        temp = [zeros(1,m*5+5*s)];
        temp(1,i+5*s+2*m) =1;
        temp(1,5*s+i+3*m) = -1;
        A = [A; temp];
        %   A = [A; zeros(1,5*s+2*m) 1 0 -1 0 zeros(1,m)];
        %   A = [A; zeros(1,5*s+2*m) 0 1 0 -1 zeros(1,m)];
    end
    for i=1:m
        
        temp = [zeros(1,m*5+5*s)];
        temp(1,i+5*s+1*m) =1;
        temp(1,5*s+i+2*m) = -1;
        A = [A; temp];
        %A = [A; zeros(1,5*s+m) 1 0 -1 0 zeros(1,2*m)];
        %A = [A; zeros(1,5*s+m) 0 1 0 -1 zeros(1,2*m)];
    end
    for i=1:m
        
        temp = [zeros(1,m*5+5*s)];
        temp(1,i+5*s) =1;
        temp(1,5*s+i+m) = -1;
        A = [A; temp];
        %A = [A; zeros(1,5*s) 1 0 -1 0 zeros(1,3*m)];
        %A = [A; zeros(1,5*s) 0 1 0 -1 zeros(1,3*m)];
    end
    Aeq = [zeros(1,5*s) X(k,:) ];
    b = zeros(4*(s+m)+n,1);
    beq = 8;
    %epsilon_mat = [19 131 150 50 25 160 160 55 27 168 180 72 22 158 94 66 55 255 230 90];
    %epsilon_mat = epsilon_mat'/1000000;
    %lb = 0.000001*ones(5*(s+m),1);
    lb = epsilon;
    
    
    



    f = [-1/8*Y(k,:) zeros(1,5*m)]';
    Z = linprog(f, A, b, Aeq, beq, lb, [],[],options);
    W(k,:) = Z';
    E(1,k) = -f'*Z;
end
end
