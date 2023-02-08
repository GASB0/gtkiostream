%/* Copyright 2000-2021 Matt Flax <flatmax@flatmax.org>
%   This file is part of GTK+ IOStream class set
%
%   GTK+ IOStream is free software; you can redistribute it and/or modify
%   it under the terms of the GNU General Public License as published by
%   the Free Software Foundation; either version 2 of the License, or
%   (at your option) any later version.
%
%   GTK+ IOStream is distributed in the hope that it will be useful,
%   but WITHOUT ANY WARRANTY; without even the implied warranty of
%   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%   GNU General Public License for more details.
%
%   You have received a copy of the GNU General Public License
%   along with GTK+ IOStream
%*/

function x=ImpPink(s, fs, fi, fa)
% Generate an impulse which is the  band limited ramp down in power spectral density
% Inputs :
%         s : duration in s
%         fs: sample rate in Hz
%         fi: Minimum frequency in Hz
%         fa: Maximum frequency in Hz
% Output :
%         x : The signal

if nargin==0
    psdRampDownTest;
    return;
end

% generate the band limited impulse signal
x=ImpBandLim(s, fs, fi, fa);
X=fft(x);
N=size(x,1);
% f=linspace(0,fs,N+1); f(end)=[];
k=(1:N)';
X=X./sqrt(k);
x=ifft(X,'symmetric');
end

function psdRampDownTest

s=1; fs=48000; fi=20; fa=20e3;
x=psdRampDown(s, fs, fi, fa);
ax(1)=subplot(211);
semilogx(x);
ax(2)=subplot(212);
semilogx(20*log10(abs(fft(x)))); grid on
xlabel('DFT bin'); ylabel('dB')
end
