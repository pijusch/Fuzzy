%input1 = [17 148 97 86 ; 15 129 148 48; 22 158 157 53; 23 165 178 70; 20 155 91 62; 51 252 228 87; 31 233 217 83; 29 202 150 78; 27 241 187 97; 47 262 246 97; 51 302 258 142; 34 281 248 119];
%input2 =  [20 151 100 90; 19 131 150 50; 25 160 160 55; 27 168 180 72; 22 158 94 66; 55 255 230 90; 33 235 220 88; 31 206 152 80; 30 244 190 100; 50 268 250 100; 53 306 260 147; 38 284 250 120];
%input3 = [23 153 103 95; 22 134 151 53; 28 163 163 57; 29 170 183 74; 25 161 97 68; 58 258 231 93; 36 236 223 92; 34 208 154 83; 32 246 194 102; 54 271 253 104; 55 308 261 149; 40 286 256 123];
%num_ip = 2 %str2num(inp);  % Num of Inputs
%num_op = 2 %str2num(op);  % Num of Outputs
%input1d = input1;
%input3d = input3;


%n=12

function new(input1 ,input2 ,input3,n,m,s,weight,name)

output= [1:n]';     % DMU numbers
col_header={};

num_ip = m;
num_op = s;
        
OE = OIFDEA(input1 ,input2 ,input3 ,n,num_ip,num_op,weight);
OE = OE';
PE = PIFDEA(input1 ,input2 ,input3 ,n,num_ip,num_op,weight);
PE = PE';
E_geo = sqrt(OE.*PE);
output = [output,OE,PE,E_geo];
rank = findRanks(E_geo,'descend');
col_header = {'DMU','Optimistic Eff.(OE)','Pessimistic Eff.(PE)','Geo. Eff. = sqrt(OE*PE)','Rank'};


% Ranking
output = str2num(num2str(output,'%0.4f'));
result = [output ,rank];

% WRITE Efficiency Results
spath = 'C:\Users\MyPC\Desktop\GUI-Final\New\output\';
sfile = name;
csvwrite([spath,sfile],result)
%xlswrite([spath,sfile],result,'Sheet1','A2');
%xlswrite([spath,sfile],col_header,'Sheet1','A1');

% PAYOFF MATRIX
% payoff = {};
% 
% for i=1:size(input1,1)
%     for j=1:size(input1,2)
%         if(payoff_val==1)   % CRISP
%             payoff{i,j} = sprintf('%0.4d',input1(i,j));
%         elseif(payoff_val==2) % TFN
%             %payoff{i,j} = sprintf('%d,%d,%d',input1(i,j),input2(i,j),input3(i,j));
%              payoff{i,j} = sprintf('%0.4f,%0.4f,%0.4f;%0.4f,%0.4f',input1(i,j),input2(i,j),input3(i,j),input1d(i,j),input3d(i,j));
%         elseif(payoff_val==3) % ITFN
%             payoff{i,j} = sprintf('%0.4f,%0.4f,%0.4f;%0.4f,%0.4f',input1(i,j),input2(i,j),input3(i,j),input1d(i,j),input3d(i,j));
%         end
%     end
% end
% 
% pay_head = {};
% for i=1:num_ip
%     pay_head = {pay_head{:},sprintf('Input %d',i)};
% end
% 
% for i=1:num_op
%     pay_head = {pay_head{:},sprintf('Output %d',i)};
% end
% 
% % WRITE PAYOFF MATRIX
% xlswrite([spath,sfile],pay_head,'Sheet2','A1');
% xlswrite([spath,sfile],payoff,'Sheet2','A2');
% 
% % MODIFY SHEET NAMES
% e = actxserver('Excel.Application');            % # open Activex server
% ewb = e.Workbooks.Open([spath,sfile]);          % # open file (enter full path!)
% ewb.Worksheets.Item(1).Name = 'EFF. & RANK';    % # rename 1st sheet
% ewb.Worksheets.Item(2).Name = 'PAYOFF_MATRIX';
% %ewb.Worksheets.Item(1).Name = 'EFF. & RANK'; 
% ewb.Save % # save to the same file
% ewb.Close(false)
% e.Quit
% 
% % delete(ms);
% ms = msgbox('File written successfully');
% ah = get(ms,'CurrentAxes');
% ch = get(ah,'Children');
% set(ch,'FontSize',10);