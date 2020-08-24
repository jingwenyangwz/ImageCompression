function [G] = jpeg_DCT(g)
    G = zeros(size(g));
    N1 = size(g,1);
    N2 = size(g,2);
    

        for u = 1:N1
            if u == 1
                alpha_u = 1/sqrt(2);
            else 
                alpha_u = 1;
            end
       
            for v = 1:N2
                if v == 1
                    alpha_v = 1/sqrt(2);
                else 
                    alpha_v = 1;   
                end
                %calculate the former part of the formula to reduce computation
                
                temp = 0 ;
                for x = 1:N1
                    for y = 1:N2
                        temp = temp + g(x,y)*cos((2*(x-1)+1)*(u-1)*pi/(2*N1))*cos((2*(y-1)+1)*(v-1)*pi/(2*N2));
                    end
                end
                G(u,v) = temp*sqrt(2/N1)*sqrt(2/N2)*alpha_v*alpha_u;
            end
        end
    
    
        
    
    
end