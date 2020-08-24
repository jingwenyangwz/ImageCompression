% to test jpeg_rle_encoder and jpeg_rle_decoder
close all;
clear;
clc;
format long;

vector_1_decoded = [0, 0, 0, 31, 13, 24, 0, 42, 0, 0, 11, 0, 0, 5];
vector_1_encoded = [31,3,13,0,24,0,42,1,11,2,5,2,0];

vector_2_decoded = [0, 0, 0, 31, 13, 24, 0, 42, 0, 0, 11, 0, 0, 0];
vector_2_encoded = [31,3,13,0,24,0,42,1,11,2,3];

fprintf('Checking rle_encoder ...\n');

% encode 1
encoded_1 = jpeg_rle_encoder(vector_1_decoded);
assert(isequal(size(encoded_1), size(vector_1_encoded)), ...
    'Problem with the size of the returned array of jpeg_rle_encoder (when there are no trailing zeros); \nexpected vs. your size:\n%s vs %s.', ...
     mat2str(size(vector_1_encoded)), mat2str(size(encoded_1)));
assert(isequal(encoded_1, vector_1_encoded), ...
    'The content of the rle-encoded vector is not correct (when there are no trailing zeros).');

% encode 2
encoded_2 = jpeg_rle_encoder(vector_2_decoded);
assert(isequal(size(encoded_2), size(vector_2_encoded)), ...
    'Problem with the size of the returned array of jpeg_rle_encoder (when there are trailing zeros); \nexpected vs. your size:\n%s vs %s.', ...
     mat2str(size(vector_2_encoded)), mat2str(size(encoded_2)));
assert(isequal(encoded_2, vector_2_encoded), ...
    'The content of the rle-encoded vector is not correct (when there are trailing zeros).');


fprintf('Checking rle_decoder ...\n');
% decode_1
decoded_1 = jpeg_rle_decoder(vector_1_encoded);
assert(isequal(size(decoded_1), size(vector_1_decoded)), ...
    'Problem with the size of the returned array of jpeg_rle_decoder (when there are no trailing zeros); \nexpected vs. your size:\n%s vs %s.', ...
     mat2str(size(vector_1_decoded)), mat2str(size(decoded_1)));
assert(isequal(decoded_1, vector_1_decoded), ...
    'The content of the decoded vector is not correct (when there are no trailing zeros).');

% decode_1
decoded_2 = jpeg_rle_decoder(vector_2_encoded);
assert(isequal(size(decoded_2), size(vector_2_decoded)), ...
    'Problem with the size of the returned array of jpeg_rle_decoder (when there are no trailing zeros); \nexpected vs. your size:\n%s vs %s.', ...
     mat2str(size(vector_2_decoded)), mat2str(size(decoded_2)));
assert(isequal(decoded_2, vector_2_decoded), ...
    'The content of the decoded vector is not correct (when there are no trailing zeros).');


fprintf('If you do not see any MATLAB error/warning messages above, your rle_encoder/rle_decoder functions are probably OK.\n');
