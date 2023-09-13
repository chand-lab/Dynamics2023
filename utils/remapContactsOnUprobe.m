function newV = remapContactsOnUprobe(old);

newV = zeros(1,length(old));

for k=1:length(old)
    if mod(old(k),2) == 1
        newV(k) = floor(old(k)/2)+1;
    else
        newV(k) = 8+floor(old(k)/2);
    end
end