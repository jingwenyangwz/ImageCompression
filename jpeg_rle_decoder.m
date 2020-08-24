function [decoded_vector] = jpeg_rle_decoder(rle_encoded_vector)
    decoded_vector = [];
    for i = 1:2:size(rle_encoded_vector,2)
        
        if i == size(rle_encoded_vector,2)
         
            decoded_vector = [decoded_vector, zeros(1,rle_encoded_vector(i))];
       
        else
  
            decoded_vector = [decoded_vector, zeros(1,rle_encoded_vector(i+1))];
      
            decoded_vector = [decoded_vector, rle_encoded_vector(i)];
         
        end
    end
end
