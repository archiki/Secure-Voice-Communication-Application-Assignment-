# Secure-Voice-Communication-(Application-Assignment)
We propose to build a secure voice communincation system for narrow bandwidth applications.Here, we have written the MATLAB code to effectively demonstrate the working in software.
There are 4 major blocks:
### Encoding/ Compression
This was achieved using __Linear Predictive Coding__ which essentially tries to model the speech signal as a gaussian or a impulse train.The frequency of the impulse train is estimated using a __pitch detection__ algorithm estimated using the peaks in the FFT. Prior to compression the signal is split into segments and hanning wndowing function is applied.

### Encryption
2 layers of encryption are provided. First, is by using FIR filter banks whose coeficients give the key. On top of that, the output of a Rossler discrete time chaotic system is solved using coeficients and initial conditions(key) and added to the result. This is the end of the transmitter

### Decryption
At the reciever, the chatoic noise is subtracted out (regenerated using the key) and the inverse IIR filter is created using the coeficients of the FIR filter used for encryption as key. The recieved signal is now decrypted.

### Decoding
Inverse of LPC is done to recreate the speech signal. Since the compression is lossy there is some additive noise. All the segments are stiched together and the entire signal is generated.




