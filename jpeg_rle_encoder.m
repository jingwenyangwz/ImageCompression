function [rle_encoded_vector] = jpeg_rle_encoder(in_vector)
    rle_encoded_vector = [];
    skip = 0;
    
    for num = 1:size(in_vector,2)
        
        if in_vector(num) == 0
            skip = skip + 1;   
        
        
        else
            
            rle_encoded_vector = [rle_encoded_vector,in_vector(num)];
            rle_encoded_vector = [rle_encoded_vector,skip];
            skip = 0;

        end
        
         if num == size(in_vector,2)
            rle_encoded_vector = [rle_encoded_vector,skip];
         end
            
    end
    
    
    
end
