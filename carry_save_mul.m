clc
clear

a=9;
b=8;

N=8;% number of bits
% 

A = de2bi(a,N);    %binary_a
B = de2bi(b,N+1);  %binary_b ,, just  added one zero ,, not big deal :P 


C_in = zeros(N+1,2*N);
C_out = zeros(N+1,2*N);
binary_A_shifed = zeros(N+1,2*N);
sum = zeros(N+1,2*N);
output_binary = zeros(1,2*N+1); 

%%

% i = row index
% j=column index
binary_A_shifed(1,1:N)=and(A,B(1));  % first row is an and gate

    % second row is HAs :
    binary_A_shifed(2,2:N+2-1)=and(A,B(2));
    
    for j = 1:N
     [sum(2,j+1) ,C_out(2,j+1) ] = HA ( binary_A_shifed(1,j+1) , binary_A_shifed(2,j+1) ) ; 
    end
%% 
for i = 3:N+1  
    for j = 3:2*N
 
   binary_A_shifed(i,i:N+i-1)=and(A,B(i)); 
   [sum(i,j) ,C_out(i,j) ] = FA (binary_A_shifed(i,j) , sum(i-1,j) , C_out(i-1,j-1) ) ; 
    end
end

%% last stage
% binary_A_shifed(number_of_bits+1,(number_of_bits+1) : 2*number_of_bits) =
%  

    for j = N+2 : 2*N % +2 as first full adder is done in last loop
       
     [sum(N+1,j) ,C_out(N+1,j) ] = FA ( sum(N,j) , C_out(i-1,j-1), C_out(N+1,j-1) ) ; 
    end

    %% output connection

    for j = 1 : N+1 % first N+1 numbers
    output_binary(j)=  sum(j,j);  
    end
    
    for j = N+2 : 2*N % next 2N-(N+1) numbers
    output_binary(j)=  sum(N+1,j);  
    end 
    
 output_binary(2*N+1) = C_out(N+1,2*N) ; 
 
 
bi2de(output_binary)


% output= bin2dec(output_binary);