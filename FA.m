function [S, C_out] = FA(A, B, C_in)

s1= xor(A,B) ; 
S= xor(C_in,s1) ; 

C_out = or (and(A,B) , and(C_in,s1)) ;



end