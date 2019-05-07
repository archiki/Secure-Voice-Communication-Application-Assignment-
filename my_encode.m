function [A,G,Err] = my_encode(x, fs, p)

X = windowing(x, fs);
[no_segments, seg_len] = size(X);
A = [];
G = [];
Err = [];
for i = 1:no_segments
    [a,g] = lpc(X(i,:),p);
    if isnan(g)
        g = 0;
    end
    a(isnan(a)) = 0;
    A = [A;a];
    G = [G;g];
    Err= [Err;X(i,:) - filter([0 -a(2:end)],1,X(i,:))];
end

