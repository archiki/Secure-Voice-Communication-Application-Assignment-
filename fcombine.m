function f = fcombine(F,samp_freq)
[num_seg,window_length] = size(F);
window_length = floor(22.5*0.001*samp_freq);
overlap = floor(0.5*window_length); % for 50% overlap
N = (num_seg)*overlap+window_length;

%temp=X';
%x= temp(:)
f = zeros(N,1);
for i= 1:num_seg
    f((1+ (i-1)*overlap): (window_length + (i-1)*overlap) ) = repmat(F(i,:),1,window_length);
end
