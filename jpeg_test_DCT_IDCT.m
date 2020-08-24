% to test jpeg_DCT and jpeg_IDCT
close all;
clear;
clc;
format long;

simple_block = zeros(8, 8);
simple_block(3, :) = 1;
simple_block(6, :) = 1;
simple_block(:, 2) = 1;
simple_block(:, 7) = 1;


fprintf('Checking DCT ...\n');
freq_dom = jpeg_DCT(simple_block);
assert(isequal(size(freq_dom), [8, 8]), ...
    'Problem with the size of the returned array of jpeg_DCT; \nexpected vs. your size:\n[8, 8] vs %s', ...
    mat2str(size(freq_dom)));
assert(abs(sum(sum(freq_dom(2:2:end, 2:2:end))))<10^-8 && ...
    abs(sum(sum(abs(freq_dom(1:2:end, 1:2:end)))) - 16.098143041276842) < 10^-6, ...
    'Problem with the values inside the returned array of DCT, please check the formulas, especially that all of your indices running from 1.');

fprintf('Checking IDCT ...\n');
sp_dom = jpeg_IDCT(freq_dom);
assert(isequal(size(sp_dom), [8, 8]), ...
    'Problem with the size of the returned array of jpeg_IDCT; \nexpected vs. your size:\n[8, 8] vs %s', ...
    mat2str(size(sp_dom)));
assert(sum(sum(abs(sp_dom-simple_block))) < 10^-8, ...
    'Problem with the values inside the returned array of IDCT, please check the formulas, especially that all of your indices running from 1.');


fprintf('If you do not see any MATLAB error/warning messages above, your DCT/IDCT functions are probably OK.\n');
