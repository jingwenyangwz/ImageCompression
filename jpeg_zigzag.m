function zig_zag_vector = jpeg_zigzag(array)
    idxs = reshape(1:numel(array), size(array));
    
    idxs = fliplr(idxs);
    idxs = spdiags(idxs);
    idxs = fliplr(idxs);
    
    
    idxs(:,1:2:end) = flipud(idxs(:,1:2:end));
    
    idxs(idxs==0) = [];
    zig_zag_vector=array(idxs);
    
    
end
