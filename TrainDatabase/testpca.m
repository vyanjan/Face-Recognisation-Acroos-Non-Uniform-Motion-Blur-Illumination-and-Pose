clc;
load pcadb; 
% Loading pcadb.mat file
% pcadb loads the following in the workspace
% image size [M, N]
% mean image [m]
% reduced eigen vectors transformation matrix (Ppca)
% transformed dataset [T]

[filename, pathname] = uigetfile('*.*', 'Select The Input Image');
filewithpath = strcat(pathname, filename);
img = imread(filewithpath);
imgo = img;
img = rgb2gray(img);

% Debugging information
fprintf('Expected image size: [%d, %d]\n', M, N);
fprintf('Actual image size: [%d, %d]\n', size(img));

% Ensure the number of elements matches
img = double(reshape(img, [1, numel(img)])); 

if numel(img) ~= M * N
    error('The number of elements in the image does not match M * N. Check the values of M and N.');
end

% Projecting query image to PCA space
imgpca = (img - m) * Ppca; 
% Initialize difference array
distarray = zeros(size(T, 1), 1); % Initialize difference array

for i = 1:size(T, 1)
    % Finding L1 distance
    distarray(i) = sum(abs(T(i, :) - imgpca)); 
end

% Getting best match
[result, indx] = min(distarray); 
% Getting best matched image
resultimg = imread(sprintf('%d.jpg', indx)); 

subplot(121)
imshow(imgo);
title('Query Face');
subplot(122)
imshow(resultimg);
title('Recognized Face');

% Display Project Name and Author
projectName = 'Face Recognition across non-uniform motion Blur, illumination and pose';
doneby = 'Kevat Vyanjan Kumar';
collegeName = 'Vaagdevi Institute of Technology and Science';
batch = 'Batch: B-6';

% Add text annotation for project name at the top center
annotation('textbox', [0.5, 0.95, 0, 0], 'string', projectName, 'FitBoxToText', 'on', 'LineStyle', 'none', 'HorizontalAlignment', 'center', 'FontSize', 12, 'FontWeight', 'bold');

% Add text annotation for batch above author's name
annotation('textbox', [0.85, 0.13, 0, 0], 'string', batch, 'FitBoxToText', 'on', 'LineStyle', 'none', 'HorizontalAlignment', 'right', 'FontSize', 10, 'FontWeight', 'bold');

% Add text annotation for author's name below batch
annotation('textbox', [0.95, 0.09, 0, 0], 'string', ['Done by: ', doneby], 'FitBoxToText', 'on', 'LineStyle', 'none', 'HorizontalAlignment', 'right', 'FontSize', 10);

% Add text annotation for college name below author's name, shifted up
annotation('textbox', [0.95, 0.05, 0, 0], 'string', ['College Name: ',collegeName], 'FitBoxToText', 'on', 'LineStyle', 'none', 'HorizontalAlignment', 'right', 'FontSize', 10);

disp(['Project Name: ', projectName]);
disp(['Done by: ', doneby]);
disp(['College Name: ', collegeName]);
disp(['Batch: ', batch]);