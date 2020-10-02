function [ res ] = gaussianfilter( x, y, sigma, filter, M, extrapolation )
%gaussianFILT Non-Uniform 1D-gaussian Filter
%Window size: [t-M,t+M], t in filter 
    if nargin < 3
       error('wrong parameter count') 
    elseif nargin == 3
        filter = x;
        M = 3 * sigma;
        extrapolation = 0;
    elseif nargin == 4
        M = 3 * sigma;
        extrapolation = 0;
    elseif nargin == 5
        extrapolation = 0;
    end
    res = zeros(size(filter));
    for i = 1:length(filter)
        indices = (x > (filter(i)-M)) & (x < (filter(i)+M));
        if ~isempty(x(indices))
            gaussianFactors = gaussianKernel(x(indices)-filter(i), sigma);
            res(i) = sum(gaussianFactors .* y(indices)) ./ sum(gaussianFactors);
        else
            res(i) = extrapolation;
        end
    end
end

function [ k ] = gaussianKernel( x, sigma)
    k =  1 / (sigma * sqrt(2 * pi)) * exp(-0.5 * (x ./ sigma).^2);
end
