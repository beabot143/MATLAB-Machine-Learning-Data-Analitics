function UniformQuant(inFile,outFile,N)
% This function quantizes an input sequence using a unifrom quantizer with
% a user specified number of levels (midtread)
%   inFile --> the audio file to quantized
%   outFile --> named of quantized audio to be saved
%   N --> number of bits to quantize signal

[y,fs] = audioread(inFile)
ych1 = y(:,1)
t = 0:(1/fs):length(y)*(1/fs)-(1/fs)

vmax = max(ych1)
vmin = min(ych1)
q = (vmax-vmin)/(2^N-1)     %using midtread quantization
Q = round(ych1./q)
s = Q.*q                    %reconstructed signal

figure
plot(t,s)
grid MINOR
xlabel('Time(s)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Audio Uniformly Quantized (Midtread)')

figure
S = abs(fftshift(fft(s)))
plot(S)
grid MINOR
axis([0 120000 0 500])
xlabel('Frequency(Hz)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Audio Uniformly Quantized (Midtread)')

audiowrite(outFile,s,fs)

sound(ych1,fs)
pause(2.5)
sound(s,fs)



end

