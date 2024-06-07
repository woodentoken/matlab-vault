function x_smooth = smoothed_finite_difference(x, order, framelen)
% convolution coefficients from savitsky-golay algorithm
coefficients = sgolay(order, framelen);

ycenter = conv(x, coefficients((framelen+1)/2,:), 'valid');

% only the beginning window
ybegin = coefficients(end:-1:(framelen+3)/2, :) * x(framelen:-1:1);

% only the ending window
yend = coefficients((framelen-1)/2:-1:1, :) * x(end:-1:end-(framelen-1));

x_smooth = [ybegin; ycenter; yend];
end

