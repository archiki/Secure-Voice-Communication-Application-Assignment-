function [xhat] = decode(A, GF, fs,lowcut)

[n_windows, ne] = size(GF);
w = hann(floor(22.5*0.001*fs), 'periodic');
nw = length(w);
est_X = [];
    F = GF(:,2);
    G = GF(:,1);
    offset = 0;
    
    nw2 = round(nw/2);
    overlap = floor(0.5*nw); % for 50% overlap
    N = (n_windows)*nw2+nw;
    x_hat = zeros(N,1);
    
    for i = 1:n_windows,
        if F(i) > 0,
%             src = zeros(nw2,1);
             step = (F(i)-1)/fs;
%             pts = (offset+1):step:nw2;
            
%             if ~isempty(pts),
%                 offset = step + pts(end) - nw2;
%                 src(pts) = sqrt(step);
                f=1/step; %frequency of the impulse in Hz
                %fs=f*10; % sample frequency is 10 times higher
                t=0:1/fs:(0.0225-1/fs); % time vector
                y=zeros(size(t));
                y(1:round(fs/f):end)=1;
                src = y + 0.01*randn(round(0.0225*fs),1)';
            
        else 
            src = randn(round(0.0225*fs),1)';
            %offset = 0;
        end 
        %xhat( nw2*i + (1:nw2) ) = filter( 1, A(i,:), sqrt(G(i))*src); sqrt(G(i))*
        temp = w'.*filter( 1, A(i,:),  sqrt(abs(G(i)))*src);
        
        est_X = [est_X;temp];
    end
    
    xhat = combine(est_X);
    if lowcut > 0
        [b,a] = butter(10, lowcut, 'high'); 
        xhat = filter(b,a,xhat);
    end
   
end

    