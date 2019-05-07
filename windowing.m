function [stackedX] = windowing(x, samp_freq)
%define the windowing function as a hanning function with segment length
%corresponding to 22.5ms as per TROULLINOS paper
window_fn = hann(floor(22.5*0.001*samp_freq), 'periodic');
N = length(x);
window_length = floor(22.5*0.001*samp_freq);
overlap = floor(0.5*window_length); % 50% overlap
% X is of order num of segments * segment length
num_seg = round((N - window_length)/overlap) ;
stackedX = zeros(num_seg,window_length);
for i= 1:num_seg
    stackedX(i, :) = window_fn.*x((1+ (i-1)*overlap): (window_length + (i-1)*overlap) );
end
