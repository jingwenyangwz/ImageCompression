function [decompressed] = lossy_decompress(compressed)

    DICT = compressed.DICT;
    LUT = compressed.LUT;
    cut_size = compressed.cut_size;
    
    LIST = DICT(LUT, :);
    decompressed = uint8(zeros(cut_size));
    block_size = sqrt(size(LIST,2));
    counter = 1;
    for r = 1:block_size:cut_size(1)
        for c = 1:block_size:cut_size(2)
            part = reshape(LIST(counter,:), block_size, block_size);
            decompressed(r:r+block_size-1, c:c+block_size-1) = part;
            counter = counter +1;
            
            
        end
    end
    decompressed = uint8(decompressed);

end