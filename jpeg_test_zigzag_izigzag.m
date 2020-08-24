% to test jpeg_zigzag and jpeg_izigzag
close all;
clear;
clc;
format long;

simple_block = [70:-3:58; 11:4:27; 49:5:69];

fprintf('Checking zigzag ...\n');
zzv = jpeg_zigzag(simple_block);
assert(isequal(size(zzv), [1, 15]), ...
    'Problem with the size of the returned array of jpeg_zigzag; \nexpected vs. your size:\n[1, 15] vs %s', ...
    mat2str(size(zzv)));
assert(sum(zzv)==710, 'The original elements in the returned zig-zag vector have changed their values');
assert(isequal(diff(zzv), [-3, -56, 38, -34, 49, -3, -42, 35, 5, -36, 35, -31, 37, 5]), ...
    'The order of the elements in the zig-zag vector is not correct.');

fprintf('Checking izigzag ...\n');
b_zzv = jpeg_izigzag(zzv, size(simple_block));
assert(isequal(size(b_zzv), size(simple_block)), ...
    'Problem with the size of the returned array of jpeg_izigzag; \nexpected vs. your size:\n%s vs %s', ...
    mat2str(size(simple_block)), mat2str(size(zzv)));
assert(isequal(simple_block, b_zzv), ...
    'The returned array of jpeg_izigzag is not the same as the original rectangular one.');


fprintf('If you do not see any MATLAB error/warning messages above, your zigzag/izigzag functions are probably OK.\n');
