[x,fs]= audioread('sample.wav');

x = mean(x, 2); % mono
x = x/max(abs(x));
x_hf=filter([1 -0.9375],1,x);
[A,G,Err]= my_encode(x_hf,fs,48);

F=pitchdetect(Err,G);
%F = zeros(size(F));
est_x=decode(A,[G F], fs,0/(fs));
f = fcombine(F,fs);
%est_x=filter(1,[1 -0.9375],est_x);
est_x = est_x/max(abs(est_x));
esxf = fft(est_x);
esxf(1) = 0;
xnew = ifft(esxf);
%compression done
figure(1);
subplot(2,1,1);
plot(abs(fft(x)));
%hold on
subplot(2,1,2);
plot(abs(fft(xnew)));
%sound(xnew,fs);
%designing filter for encryption
Fnew=F./100;
encoded_vector = [A G Fnew];
m = randi([1,6],16,1);
m=[m;m];
z_re = randi([1,50],40,1);
Z_re= [z_re;z_re];
z_im = randi([0,50],40,1);
Z_im = [z_im ;-1*z_im];
Z = [Z_re+ Z_im*1i];
%Z= Z./(min(abs(Z)));
%Z=Z.^m;
H = zpk(Z,[],1, []);
[num,den,Ts]=tfdata(H);
num = cell2mat(num);
den = cell2mat(den);
encrypted_vector = filter(fliplr(num),fliplr(den),encoded_vector,[],2);
%encryption done
temp_enc_vector=(encrypted_vector);
Aen= temp_enc_vector(:,1:end-2);
Gen= temp_enc_vector(:,end-1);
Fen= temp_enc_vector(:,end).*100;
encr_x=decode(Aen,[Gen Fen], fs,0/(fs));
encr_x=filter(1,[1 -0.9375],encr_x);
encr_x = encr_x/max(abs(encr_x));
esxf = fft(encr_x);
esxf(1) = 0;
xencr= ifft(esxf);%decode encrypted vector

noisy_encrypted_vector=encrypted_vector+ 0.5*std(encrypted_vector).*randn(size(encrypted_vector));
%decryption and decoding
decrypted_vector=filter(fliplr(den./num(end)),fliplr(num./num(end)),encrypted_vector,[],2);
Adec= decrypted_vector(:,1:end-2);
Gdec= decrypted_vector(:,end-1);
Fdec= decrypted_vector(:,end).*100;
decr_x=decode(Adec,[Gdec Fdec], fs,0/(fs));
%decr_x=filter(1,[1 -0.9375],decr_x);
decr_x = decr_x/max(abs(decr_x));
esxf = fft(decr_x);
esxf(1) = 0;
xndr = ifft(esxf);
bandpass(x,[100 200],fs)
 

