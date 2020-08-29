%*****************************************************************
% ELE725 Lab1: Sampling and Quantizaion (Audio)
% Author: Bethany Santos
% Date: January 17, 2019
%*****************************************************************
close ALL
clear

% Variables
N = 4
audioFile = 'ELE725_lab1.wav'
pf = 1
Mu = 100

%% Audio File Properties

[y,Fs] = audioread(audioFile)
audio_info = audioinfo(audioFile)

% file size = BitsPerSample*SampeRate*NumChannels*Duration
audiofile_size = (audio_info.BitsPerSample * audio_info.SampleRate * audio_info.NumChannels * audio_info.Duration)/8

%% Sampling
% plot original audio in time domain
ych1 = y(:,1) % take only one channel from .wav file
t = 0:1/Fs:length(ych1)*(1/Fs)-(1/Fs)
plot(t,ych1)
grid MINOR
xlabel('Time(s)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Audio in Time Domain')

% plot original adio in frequency domain
Y = abs(fftshift(fft(ych1)))
figure
plot(Y)
grid MINOR
xlabel('Frequency(Hz)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Audio in Frequency Domain')

% plot audio in freq domain after LPF
yLPF = lowpass(ych1,0.1)
YLPF = abs(fftshift(fft(yLPF)))
figure
plot(YLPF)
grid MINOR
axis ([-0.3 0.3 0 200])
xlabel('Frequency(Hz)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Audio in Frequency Domain (FILTERED)')

% downsample by a factor of N
DownSample(audioFile,'downSampled.wav',N,pf)

% plot interpolated and fft audio in freq domain
YInterp = abs(fftshift(fft(interp(ych1,N))))
figure
plot(YInterp)
grid MINOR
xlabel('Frequency(Hz)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Audio: Interpolated in Frequency Domain')

%% Quantization

% Uniform Quant uses midrise quantization
UniformQuant('ELE725_lab1.wav','uniform.wav',N)

% Apply u law quantization
MulawQuant('ELE725_lab1.wav', 'mulaw.wav', N, Mu)
UniformQuant('mulaw.wav','mulawQuant.wav', N)

[yUni,fs] = audioread('uniform.wav')
[yMu,fs] = audioread('mulawQuant.wav')

y200 = y(20600:20800,1)
yUni200 = yUni(20600:20800,1)
yMu200 = yMu(20600:20800,1)

t200 = 0:200

figure
subplot(3,1,1)
plot(t200,y200)
grid MINOR
axis ([0 200 -0.25 0.3])
xlabel('Time(s)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Original 200 Samples')

subplot(3,1,2)
plot(t200,yUni200)
grid MINOR
axis ([0 200 -0.25 0.3])
xlabel('Time(s)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Uniform Quantized 200 Samples')

subplot(3,1,3)
plot(t200,yMu200)
grid MINOR
axis ([0 200 -1.25 1.25])
xlabel('Time(s)')
ylabel('Signal Amplitude')
title('ELE725lab1.wav Mulaw Quantized 200 Samples')

% Calculating Mean Squared error
mseUni = immse(ych1,yUni)
mseMu = immse(ych1,yMu)
