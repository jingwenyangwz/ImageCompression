% Basic Image Processing, 2019.
% assignment4 / script to the JPEG-compression

close all;
clear;
clc;

format long;

input_img0 = double(imread('./input/tree.png'));

% step0: to avoid size-problems and index-errors: crop the image:
blocksize = 8;
[rownum, colnum, ~] = size(input_img0);
rownum2 = rownum - mod(rownum, blocksize);
colnum2 = colnum - mod(colnum, blocksize);
input_img = imcrop(input_img0, [1 1 colnum2-1 rownum2-1]);

num_of_blocks = (rownum2/blocksize) * (colnum2/blocksize);
decoded_img = zeros(size(input_img));

length_of_the_code = zeros(1, num_of_blocks);
for idx = 1:num_of_blocks
    upperleft_c = mod((idx-1)*blocksize, colnum2) + 1;
    upperleft_r = floor((idx-1)*blocksize/colnum2)*blocksize + 1;
    actual_block = input_img(upperleft_r:upperleft_r+blocksize-1, upperleft_c:upperleft_c+blocksize-1, :);

    % step1: color-space conversion + chrominance downsampling
    [Y, Cb, Cr] = jpeg_RGB_to_YCbCr(actual_block);

    % step2: DCT
    Y_dct = jpeg_DCT(Y);
    Cb_dct = jpeg_DCT(Cb);
    Cr_dct = jpeg_DCT(Cr);
    
    % step3: quantization
    Y_dct_quantized = jpeg_quantizer(Y_dct, 1, 1);
    Cb_dct_quantized = jpeg_quantizer(Cb_dct, 2, 1);
    Cr_dct_quantized = jpeg_quantizer(Cr_dct, 2, 1);

    % step4: zigzag
    Y_dct_qu_zz = jpeg_zigzag(Y_dct_quantized);
    Cb_dct_qu_zz = jpeg_zigzag(Cb_dct_quantized);
    Cr_dct_qu_zz = jpeg_zigzag(Cr_dct_quantized);

    % step5: run-length encoding
    Y_dct_qu_zz_enc = jpeg_rle_encoder(Y_dct_qu_zz);
    Cb_dct_qu_zz_enc = jpeg_rle_encoder(Cb_dct_qu_zz);
    Cr_dct_qu_zz_enc = jpeg_rle_encoder(Cr_dct_qu_zz);    
    
    length_of_the_code(idx) = length(Y_dct_qu_zz_enc) + length(Cb_dct_qu_zz_enc) + length(Cr_dct_qu_zz_enc);

    % step6: run-length decoder
    b_Y_dct_qu_zz = jpeg_rle_decoder(Y_dct_qu_zz_enc);
    b_Cb_dct_qu_zz = jpeg_rle_decoder(Cb_dct_qu_zz_enc);
    b_Cr_dct_qu_zz = jpeg_rle_decoder(Cr_dct_qu_zz_enc);
    
    % step7: inverse zigzag
    b_Y_dct_qu = jpeg_izigzag(b_Y_dct_qu_zz, size(Y_dct_quantized));
    b_Cb_dct_qu = jpeg_izigzag(b_Cb_dct_qu_zz, size(Cb_dct_quantized));
    b_Cr_dct_qu = jpeg_izigzag(b_Cr_dct_qu_zz, size(Cr_dct_quantized));
    
    % step8: de-quantization
    b_Y_dct = jpeg_dequantizer(b_Y_dct_qu, 1, 1);
    b_Cb_dct = jpeg_dequantizer(b_Cb_dct_qu, 2, 1);
    b_Cr_dct = jpeg_dequantizer(b_Cr_dct_qu, 2, 1);
    
    % step9: inverse DCT
    b_Y = jpeg_IDCT(b_Y_dct);
    b_Cb = jpeg_IDCT(b_Cb_dct);
    b_Cr = jpeg_IDCT(b_Cr_dct);

    % step10: chrominance upsampling + color space conversion
    decoded_block = jpeg_YCbCr_to_RGB(b_Y, b_Cb, b_Cr);
    
    decoded_img(upperleft_r:upperleft_r+blocksize-1, upperleft_c:upperleft_c+blocksize-1, :) = decoded_block;
end

input_img = uint8(input_img);
decoded_img = uint8(decoded_img);

original_length = size(input_img0, 1)*size(input_img0, 2)*size(input_img0, 3);
decoded_length = size(decoded_img, 1)*size(decoded_img, 2)*size(decoded_img, 3);
stats = [original_length*8, sum(length_of_the_code)*8, decoded_length*8];
fprintf('simple measure of the size of the original image (without crop): %d bits\n', stats(1));
fprintf('simple measure of the length of the code: %d bits\n', stats(2));
fprintf('simple measure of the size of the decompressed image: %d bits\n', stats(3));
fprintf('compression ratio: %6.3f\n', stats(1)/stats(2));


figure;
subplot(3, 2, 1);
imshow(input_img);
title({'Original image'; ['Size: ', num2str(stats(1)), ' bits']});

subplot(3, 2, 2);
imshow(decoded_img);
title({'Decompressed image'; ['Size: ', num2str(stats(3)), ' bits']});

subplot(3, 2, 3);
imshow(input_img(247:325, 86:193, :))
title('Part of the original');

subplot(3, 2, 4);
imshow(decoded_img(247:325, 86:193, :))
title('Part of the decompressed');

subplot(3, 2, 5:6);
barh(stats(end:-1:1));
title({'Statistics', ['Compression ratio: ', num2str(stats(1)/stats(2))]});
xlabel('Size of the data in bits');
yticklabels({'decompressed', 'compressed', 'original'});

