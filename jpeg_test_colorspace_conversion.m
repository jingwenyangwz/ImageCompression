% to test jpeg_RGB_to_YCbCr and jpeg_YCbCr_to_RGB
close all;
clear;
clc;
format long;

simple_block = zeros(8, 8, 3);
simple_block(5, 5, :) = [1, 10, 100];

fprintf('Checking RGB --> YCbCr ...\n');
[y, cb, cr] = jpeg_RGB_to_YCbCr(simple_block);
assert(isequal(size(y), [8, 8]) && isequal(size(cb), [2, 2]) && isequal(size(cr), [2, 2]), ...
    'Problem with the size of the returned arrays of jpeg_RGB_to_YCbCr; \nexpected vs. your sizes:\ny: [8, 8] vs %s,\ncb: [2, 2] vs %s,\ncr: [2, 2] vs %s', ...
    mat2str(size(y)), mat2str(size(cb)), mat2str(size(cr)));
assert(isequal(sum(y(:))-y(5, 5), -63*128), ...
    'Problem with the values inside Y, have you shifted all of its elements with -128?');
assert(abs(y(5, 5)+110.431)<10^-6, ...
    'Problem with the values inside Y, the problem is probably with the weights insides Y=w1*R+w2*G+w3*B');
assert(isequal([cb(1,1),cb(1,2),cb(2,1)], [0, 0, 0]) && isequal([cr(1,1),cr(1,2),cr(2,1)], [0, 0, 0]), ...
    'Problem1 with the values either in Cb or/and in Cr; reasons can be:\n 1) you forgot to shift all values of Cb and/or Cr with -128,\n 2) you have incorrect weights in Cb=w1*R+w2*G+w3*B or in Cr=w1*R+w2*G+w3*B,\n 3) you have an improper downsampling - please index both dimensions as 1:4:end', []);
assert(abs(cb(2,2)+cr(2,2)-34.7013)<10^-6, ...
    'Problem2 with the values either in Cb or/and in Cr; reasons can be:\n 1) you forgot to shift all values of Cb and/or Cr with -128,\n 2) you have incorrect weights in Cb=w1*R+w2*G+w3*B or in Cr=w1*R+w2*G+w3*B,\n 3) you have an improper downsampling - please index both dimensions as 1:4:end', []);

fprintf('Checking YCbCr --> RGB ...\n');
out_block = jpeg_YCbCr_to_RGB(y, cb, cr);
assert(isequal(size(out_block), [8, 8, 3]), ...
    'Problem with the size of the returned array of jpeg_YCbCr_to_RGB; \nexpected vs. your size:\n[8, 8, 3] vs %s', ...
    mat2str(size(out_block)));
assert(isequal(sum(sum(sum(out_block(1:4, :, :)))), 0) && isequal(sum(sum(sum(out_block(5:8, 1:4, :)))), 0), ...
    'Problem1 with the values in the returned array; reasons can be:\n 1) you missed to correctly upsample the Cb and Cr arrays (please use the option >>nearest<<),\n 2) you forgot to shift some/all of your input layers with +128,\n 3) you have incorrect weights in your equations', []);
assert(abs(sum(sum(sum(out_block(5:8, 5:8, :))))-985.397851488)<10^-6, ...
    'Problem2 with the values in the returned array; reasons can be:\n 1) you missed to correctly upsample the Cb and Cr arrays (please use the option >>nearest<<),\n 2) you forgot to shift some/all of your input layers with +128,\n 3) you have incorrect weights in your equations', []);


fprintf('If you do not see any MATLAB error/warning messages above, your colorspace converting functions are probably OK.\n');
