function new_array = jpeg_izigzag(zig_zag_vector, desired_size)
    idxs = reshape(1:prod(desired_size), desired_size);
    

    idxs = fliplr(idxs);
    idxs = spdiags(idxs);
    idxs = fliplr(idxs);
    
    idxs(:,1:2:end) = flipud(idxs(:,1:2:end));

    idxs(idxs==0) = [];
    new_array=zeros(desired_size);
    new_array(idxs)=zig_zag_vector;
end
