function [DMU,criteria] = load_data
%DMU        =   DMU vs criteria matrix
%criteria   =   criteria vs weight matrix

%PC , EWA , CU , AE , ES

DMU =  [5	4	6	5	5;
        6	4	6	5	5;
        5	4	5	5	4;
        6	5	6	5	5;
        6	5	6	5	4;
        5	4	6	4	4;
        7	5	5	5	4;
        5	6	7	5	5;
        5	5	5	5	5;
        5	4	6	5	4;
        4	4	6	4	4;
        6	4	5	5	5;
        5	4	5	5	5;
        4	4	5	4	5;
        6	5	5	5	5;
        6	4	5	5	4;
        5	5	6	4	5;
        5	4	5	4	4;
        4	4	5	5	4;
        7	4	6	5	5];

criteria = [6	5	6	5	5;  %PC
            6	6	5	5	5;  %EWA
            6	5	6	6	5;  %CU
            6	6	6	5	5; %AE
            5	7	5	6	5];  %ES

end