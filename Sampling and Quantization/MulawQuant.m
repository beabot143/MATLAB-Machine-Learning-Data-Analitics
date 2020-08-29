function MulawQuant (inFile, outFile, N, Mu)
% This function applies the Mulaw quantization to the inFile and saves the
% quantized sequence as the outFile.
%   inFile -> audio file to be quantized
%   outfile -> sill hold the qunatized file
%   N -> number of bits
%   Mu - scaling factor; set to 100

[y,fs] = audioread(inFile)
ych1 = y(:,1)
ymax = max(ych1)
yratio = y./ymax

% scaling
r = ((log(1+(Mu.*yratio)))/log(1+Mu)).*sign(ych1)
realr = real(r)

audiowrite(outFile, realr, fs)




end

