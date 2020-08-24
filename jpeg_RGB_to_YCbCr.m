function [Y, Cb2x2, Cr2x2] = jpeg_RGB_to_YCbCr(input_block)
    R = input_block(:,:,1);
    G = input_block(:,:,2);
    B = input_block(:,:,3);

    Y = 0.2990*R + 0.5870*G + 0.1140*B;
    Cb = - 0.1687*R - 0.3313*G + 0.5000*B + 128;
    Cr = 0.5000*R - 0.4187*G - 0.0813*B + 128;
    
    Y = Y - 128;
    Cb = Cb - 128;
    Cr = Cr - 128;
    
    Cb2x2 = Cb(1:4:end,1:4:end);
    Cr2x2 = Cr(1:4:end,1:4:end);

    
    
end
