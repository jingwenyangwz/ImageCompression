function [decompressed_image] = lossless_decompress(compressed_image)
    decompressed_image = [];
    H = size(compressed_image,1);
    for y = 1:H
        symbol = compressed_image{y}(1);
        row_pixels = [];
        N = size(compressed_image{y},2);
        for x = 2:N
            block = repmat(symbol, 1, compressed_image{y}(x));
            row_pixels = [row_pixels, block];
            symbol = ~symbol;
        end
        decompressed_image(y,:) = row_pixels;

    end
    
    
    
end