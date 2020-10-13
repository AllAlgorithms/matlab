function y = mfft(x)


% Y = MFFT(X) calculates the fast discrete fourier transform of vector x.


% Length of x must be a power of two. This implementation is


% intended to help understand the fast fourier algorithm. It is not


% optimized for speed.





% Copyright 2018


% Friedrich Welck, 28 May 2018


len = length(x);


if len >= 2


 % calculate fft of odd elements


 odd = mfft(x(1:2:len));


 % calculate fft of even elements


 even = mfft(x(2:2:len));


 % rotate even elements to prepare for recombination


 even = exp( (0:len/2-1)*(-2i*pi/len) ) .* even;


 % recombine fft of odd and even elements


 y = [odd + even , odd - even ];


else


 % end of recursion, do nothing

 y = x;


end