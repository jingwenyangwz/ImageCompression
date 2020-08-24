function [f] = jpeg_IDCT(F)

    f = zeros(size(F));
    N1 = size(F,1);
    N2 = size(F,2);
    c = sqrt(2/N1)*sqrt(2/N2);


        for x = 1:N1
            for y = 1:N2
                f(x,y) = 0;
              
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
                        
                        f(x,y) = f(x,y) + c*alpha_v*alpha_u*F(u,v)*cos((2*(x-1)+1)*(u-1)*pi/(2*N1))*cos((2*(y-1)+1)*(v-1)*pi/(2*N2));
                    end
                end
                
            end
        end
    

end

