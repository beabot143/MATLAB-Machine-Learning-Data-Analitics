function DownSample(inFile, outFile, N, pf)
% DownSample function will take in an audio file, downsamples it, plays it
% back and saves the downsampled file as output.
% inFile -> audio file to be downsampled
% outFile -> Filename of the downsample audio to be saved
% N -> downsampling factor
% pf -> boolean flag indicating whether a pre filter should be used.
% *************************************************************************

[y,fs] = audioread(inFile)
ych1 = y(:,1)
ych2 = y(:,2)

if (pf == 1)
    ych1 = lowpass(ych1,.01)
end

yDownSampled = decimate(ych1,N)
YDownSampled = abs(fftshift(fft(yDownSampled)))
figure
plot(YDownSampled)
grid MINOR
xlabel('Frequency(Hz)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Audio Signal Down Sampled')

sound(y,fs)
pause(2.5)
sound(yDownSampled,fs/N)

audiowrite(outFile,yDownSampled,round(fs/N))
end

