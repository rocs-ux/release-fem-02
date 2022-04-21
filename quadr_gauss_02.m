function [xi , wi] = gauss_quadra(NumInt)

% f = input('Enter your function: ')
% a = input('lower limit: ')
% b = input('upper limit: ')
% g = input('gauss point: ')

if NumInt == 1 
    
    xi(1) = 0;
    wi(1) = 2; 
    


elseif NumInt == 2 
    
    wi = 1; 
    
    w2 = 1;
    
    
    x1 = 1/sqrt(3); %vai precisar virar matriz pq nem todo mundo pode ser xi
    x2 = -1/sqrt(3);
    
    
    
elseif NumInt ==3
    wi = 5/9; 
    w2 = 8/9; 
    w3 = 5/9;
    
    
    x1 = sqrt(3/5); 
    x2 = 0; 
    x3 = -sqrt(3/5);
    
    
    
elseif NumInt ==4
    wi = 0.348;
    w2 = 0.652;
    w3 = 0.652;
    w4 = 0.348;
    
    x1 = -0.861;
    x2 = -0.340;
    x3 = 0.340;
    x4 = 0.861;
    
    
    
elseif NumInt ==5
    wi = 0.237;
    w2 = 0.479;
    w3 = 0.569;
    w4 = 0.479;
    w5 = 0.237;
    
    x1 = -0.906;
    x2 = -0.538;
    x3 = 0.0;
    x4 = 0.538;
    x5 = 0.906;
    
    
elseif NumInt ==6
    wi = 0.171;
    w2 = 0.361;
    w3 = 0.468;
    w4 = 0.468;
    w5 = 0.361;
    w6 = 0.171;
    
    x1 = -0.932;
    x2 = -0.661;
    x3 = -0.239;
    x4 = 0.239;
    x5 = 0.661;
    x6 = 0.932;
    
    
end