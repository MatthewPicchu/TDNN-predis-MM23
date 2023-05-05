%% QAM signal generation
M = 256;
% x will transition from each possible QAM state to each of the other QAM
% states, all possible transitions are captured
x = [];
for i = 0:M-1
    for j = 0:M-1
        x = [x,i,j];
    end
end

% generate QAM signal and normalise
CleanQamInput = qammod(x,M)/15;

%% Saleh distortion

% Saleh Coefficients
AMAM = [2.1587,	1.1517];
AMPM = [4.0033, 9.1040];

absy = abs(CleanQamInput);
AM = (absy    .* AMAM(1)) ./ ...
     (absy.^2 .* AMAM(2) + 1);
PM = (pi/3)*(absy.^2    .* AMPM(1)) ./ ...
     (absy.^2 .* AMPM(2) + 1);

PAQam = (AM.* exp(1i.*(angle(CleanQamInput) + PM)));

%% Pre-distortion

absy = abs(CleanQamInput)/(max(abs(CleanQamInput))/(sqrt((AMAM(1)^2)/(4*AMAM(2)))));

AMpre = zeros(1,length(absy));
count = 0;
for X = absy
    count = count + 1;
    if ((sqrt((AMAM(1)^2)/4*AMAM(2))>X) && (0 < X))
        new_val = ((AMAM(1) - sqrt(AMAM(1)^2 -(4 .* AMAM(2) .* X .^ 2)))./ (2 .* AMAM(2) .* X));
    else
        new_val = 1/AMAM(2);
    end
    AMpre(count)= new_val;
end

PMpre = - (pi/3) * (AMpre.^2    .* AMPM(1)) ./ ...
        ((AMpre.^2 .* AMPM(2)) + 1);

PAQamPre = (AMpre.* exp(1i.*(angle(CleanQamInput) + PMpre)));

%% applying saleh model post pre-distortion
absypre = abs(PAQamPre);

AMpost = (absypre    .* AMAM(1)) ./ ...
     (absypre.^2 .* AMAM(2) + 1);
PMpost = (pi/3)*(absypre.^2    .* AMPM(1)) ./ ...
     (absypre.^2 .* AMPM(2) + 1);

PAQamOutPredis = (AMpost.* exp(1i.*(angle(PAQamPre) + PMpost)));


%% Plots 
% plot input, distorted signal, predistorted signal and distorted 
% pre-distorted signal

scatterplot(CleanQamInput)
scatterplot(PAQam)
scatterplot(PAQamPre)
scatterplot(PAQamOutPredis)

%% Test predistortion
%% encode an image with 256 QAM

% Read PNG image
img = imread('TestImage.png');

% Convert image to grayscale
gray_img = rgb2gray(img);

% Reshape grayscale image into a vector
data = reshape(gray_img, [], 1);

% Modulate data using 256-QAM
modulated_data = qammod(data, 256)/15;

%% 

absy = abs(modulated_data)/(max(abs(modulated_data))/(sqrt((AMAM(1)^2)/(4*AMAM(2)))));
absy = absy.';
AMpre = zeros(1,length(absy));
count = 0;
for X = absy
    count = count + 1;
    if ((sqrt((AMAM(1)^2)/4*AMAM(2))>X) && (0 < X))
        new_val = ((AMAM(1) - sqrt(AMAM(1)^2 -(4 .* AMAM(2) .* X .^ 2)))./ (2 .* AMAM(2) .* X));
    else
        new_val = 1/AMAM(2);
    end
    AMpre(count)= new_val;
end

PMpre = - (pi/3) * (AMpre.^2    .* AMPM(1)) ./ ...
        ((AMpre.^2 .* AMPM(2)) + 1);

ImagePredis = (AMpre.* exp(1i.*(angle(modulated_data.') + PMpre)));
ImagePredis = ImagePredis.';

scatterplot(ImagePredis)

%% Apply saleh
absypre = abs(ImagePredis);

AMpost = (absypre    .* AMAM(1)) ./ ...
     (absypre.^2 .* AMAM(2) + 1);
PMpost = (pi/3)*(absypre.^2    .* AMPM(1)) ./ ...
     (absypre.^2 .* AMPM(2) + 1);

correct = (max(abs(modulated_data))/(sqrt((AMAM(1)^2)/(4*AMAM(2)))));

PAImageOut = ((AMpost*correct).* exp(1i.*(angle(ImagePredis) + PMpost)));
%% Demodulate the QAM signal

% Demodulate modulated data using 256-QAM
demodulated_data = qamdemod(modulated_data*15, 256);

% Reshape demodulated data into grayscale image
gray_img = reshape(demodulated_data, size(gray_img));

% Convert grayscale image to RGB image
rgb_img = cat(3, gray_img, gray_img, gray_img);

% Write RGB image to PNG file
imwrite(rgb_img, 'output.png');
%% Training & Test data output

% Training data input
real_train_input = real(CleanQamInput);
csvwrite("saleh_real_train_input.csv",real_train_input);
imag_train_input = imag(CleanQamInput);
csvwrite("saleh_imag_train_input.csv",imag_train_input);

% Training data output
real_train_output = real(PAQamPre);
csvwrite("saleh_real_train_output.csv",real_train_output);
imag_train_output = imag(PAQamPre);
csvwrite("saleh_imag_train_output.csv",imag_train_output);

% Test data input
real_test_input = real(modulated_data).';
csvwrite("saleh_real_test_input.csv",real_test_input);
imag_test_input = imag(modulated_data).';
csvwrite("saleh_imag_test_input.csv",imag_test_input);

% Test data output
real_test_output = real(ImagePredis).';
csvwrite("saleh_real_test_output.csv",real_test_output);
imag_test_output = imag(ImagePredis).';
csvwrite("saleh_imag_test_output.csv",imag_test_output);

