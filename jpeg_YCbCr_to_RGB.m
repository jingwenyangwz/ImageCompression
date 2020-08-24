function [output_block] = jpeg_YCbCr_to_RGB(Y, Cb2x2, Cr2x2)
   Cb = imresize(Cb2x2,4,'nearest');
   Cr = imresize(Cr2x2,4,'nearest');
   
   Y = Y + 128;
   Cb = Cb + 128;
   Cr = Cr + 128;
   
   R = Y + 1.40200*(Cr-128);
   G = Y - 0.34414*(Cb-128) - 0.71414*(Cr-128);
   B = Y + 1.77200*(Cb-128);
    
   output_block(:,:,1) = R;
   output_block(:,:,2) = G;
   output_block(:,:,3) = B;
       
    
end
