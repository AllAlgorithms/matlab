I = magic(10); % Sample input

[rows, cols] = size(I);
mid_row = ceil(rows / 2);
mid_col = ceil(cols / 2);

% Rearrange the image pixels to shift the center
top_left = I(mid_row+1:end, mid_col+1:end);
top_right = I(mid_row+1:end, 1:mid_col);
bottom_left = I(1:mid_row, mid_col+1:end);
bottom_right = I(1:mid_row, 1:mid_col);

shifted_image = [top_left, top_right; bottom_left, bottom_right];

% Display the original and shifted images
figure("Name","FFTShift");
subplot(1, 2, 1), imshow(I, []), title('Original Image');
subplot(1, 2, 2), imshow(shifted_image, []), title('Shifted Image');