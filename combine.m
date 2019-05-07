function x = combine(X)
[num_seg,window_length] = size(X);
overlap = floor(0.5*window_length); % for 50% overlap
N = (num_seg)*overlap+window_length;
%temp=X';
%x= temp(:)
x = zeros(N,1);
for i= 1:num_seg
    x((1+ (i-1)*overlap): (window_length + (i-1)*overlap) ) = 0.4*x((1+ (i-1)*overlap): (window_length + (i-1)*overlap) ) + 0.6*X(i,:)';
end
