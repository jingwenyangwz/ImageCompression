% to test jpeg_quantizer and jpeg_dequantizer
close all;
clear;
clc;
format long;

%simple_block_1 = ones(8, 8)*250; % 478, 236
%simple_block_2 = ones(2, 2)*250; % 24, 10

simple_block_1 = [...
    64    44    40    64    96   160   204   244; ...
    48    48    56    76   104   232   240   220; ...
    56    52    64    96   160   228   276   224; ...
    56    68    88   116   204   348   320   248; ...
    72    88   148   224   272   436   412   308; ...
    96   140   220   256   324   416   452   368; ... 
   196   256   312   348   412   484   480   404; ... 
   288   368   380   392   448   400   412   396];

simple_block_2 = [68, 396; 396, 396];


fprintf('Checking quantizer ...\n');
quantized_8x8_lumi_qf1 = jpeg_quantizer(simple_block_1, 1, 1);
quantized_8x8_lumi_qf2 = jpeg_quantizer(simple_block_1, 1, 2);
quantized_2x2_chromi_qf1 = jpeg_quantizer(simple_block_2, 2, 1);
quantized_2x2_chromi_qf2 = jpeg_quantizer(simple_block_2, 2, 2);
% not checked: whether the chrominance array can have size 8x8
assert(isequal(size(quantized_8x8_lumi_qf1), [8, 8]) && isequal(size(quantized_8x8_lumi_qf2), [8, 8]) && isequal(size(quantized_2x2_chromi_qf1), [2, 2]) && isequal(size(quantized_2x2_chromi_qf2), [2, 2]), ...
    'Problem with the size of the returned array of jpeg_quantizer; \nexpected vs. your sizes:\n8x8 luminance with QF 1: [8, 8] vs %s,\n8x8 luminance with QF 2: [8, 8] vs %s,\n2x2 chrominance with QF 1: [2, 2] vs %s,\n2x2 chrominance with QF 2: [2, 2] vs %s', ...
    mat2str(size(quantized_8x8_lumi_qf1)), mat2str(size(quantized_8x8_lumi_qf2)), mat2str(size(quantized_2x2_chromi_qf1)), mat2str(size(quantized_2x2_chromi_qf2)));
assert(abs(sum(sum(abs(quantized_8x8_lumi_qf1))) - 256) < 1, 'jpeg_quantizer calculation error with a 8x8 luminance array and with QF=1');
assert(abs(sum(sum(abs(quantized_8x8_lumi_qf2))) - 128) < 1, 'jpeg_quantizer calculation error with a 8x8 luminance array and with QF=2');
assert(abs(sum(sum(abs(quantized_2x2_chromi_qf1))) - 16) < 1, 'jpeg_quantizer calculation error with a 2x2 chrominance array and with QF=1');
assert(abs(sum(sum(abs(quantized_2x2_chromi_qf2))) - 8) < 1, 'jpeg_quantizer calculation error with a 2x2 chrominance array and with QF=2');

fprintf('Checking dequantizer ...\n');
b_q_8x8_lumi_qf1 = jpeg_dequantizer(quantized_8x8_lumi_qf1, 1, 1);
b_q_8x8_lumi_qf2 = jpeg_dequantizer(quantized_8x8_lumi_qf2, 1, 2);
b_q_2x2_chromi_qf1 = jpeg_dequantizer(quantized_2x2_chromi_qf1, 2, 1);
b_q_2x2_chromi_qf2 = jpeg_dequantizer(quantized_2x2_chromi_qf2, 2, 2);
assert(isequal(size(b_q_8x8_lumi_qf1), [8, 8]) && isequal(size(b_q_8x8_lumi_qf2), [8, 8]) && isequal(size(b_q_2x2_chromi_qf1), [2, 2]) && isequal(size(b_q_2x2_chromi_qf2), [2, 2]), ...
    'Problem with the size of the returned array of jpeg_dequantizer; \nexpected vs. your sizes:\n8x8 luminance with QF 1: [8, 8] vs %s,\n8x8 luminance with QF 2: [8, 8] vs %s,\n2x2 chrominance with QF 1: [2, 2] vs %s,\n2x2 chrominance with QF 2: [2, 2] vs %s', ...
    mat2str(size(b_q_8x8_lumi_qf1)), mat2str(size(b_q_8x8_lumi_qf2)), mat2str(size(b_q_2x2_chromi_qf1)), mat2str(size(b_q_2x2_chromi_qf2)));
assert(sum(sum(abs(simple_block_1 - b_q_8x8_lumi_qf1))) < 1, 'jpeg_dequantizer calculation error with a 8x8 luminance array and with QF=1');
assert(sum(sum(abs(simple_block_1 - b_q_8x8_lumi_qf2))) < 1, 'jpeg_dequantizer calculation error with a 8x8 luminance array and with QF=2');
assert(sum(sum(abs(simple_block_2 - b_q_2x2_chromi_qf1))) < 1, 'jpeg_dequantizer calculation error with a 2x2 chrominance array and with QF=1');
assert(sum(sum(abs(simple_block_2 - b_q_2x2_chromi_qf2))) <1, 'jpeg_dequantizer calculation error with a 2x2 chrominance array and with QF=2');


fprintf('If you do not see any MATLAB error/warning messages above, your quantizer/dequantizer functions are probably OK.\n');
