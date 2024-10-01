function [meanOutput,errorOutput] = weightedMean(valueArray,errorArray)
% [meanOutput, errorOutput] = weightedMean(valueArray,errorArray)
%   outputs are scalars. 
%   --------------------
%   The weight of each data is
%       1/variance = 1/(standard deviation)^2
%   The weighted mean is
%       \sum_i data_i * weight_i
%   and normalized by
%       \sum_i weight_i
%
%   Check out:
%   https://en.wikipedia.org/wiki/Weighted_arithmetic_mean

    if isempty(valueArray)
        meanOutput = [];
        errorOutput = [];
        return
    end
    weights = 1./(errorArray.^2);

    meanOutput = sum(valueArray.*weights)/sum(weights);

    errorOutput = sqrt(1/sum(weights));
        % no sqrt because 
end