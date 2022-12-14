%% Read image
stackNinjaOne = imread("StackNinja1.bmp");
stackNinjaTwo = imread("StackNinja2.bmp");
stackNinjaThree = imread("StackNinja3.bmp");

%% First plots of the original images being plotted out 
figure();
subplot(5,3,1);
imshow(stackNinjaOne);
title('Figure 1: StackNinjaOne');

subplot(5,3,2);
imshow(stackNinjaTwo);
title('Figure 2: StackNinjaTwo');

subplot(5,3,3);
imshow(stackNinjaThree);
title('Figure 3: StackNinjaThree');

%% Changing colour space 
% getting the grayscale array of green colour pane of cell nucleii
% multiply stack ninja to alter contrast 

greyOne = stackNinjaOne(:,:,2) * 2; 
subplot(5,3,4);
imshow(greyOne);
title('Figure 1a: Colour space conversion');
% higher value needed due to more shade - not as automatic 
greyTwo = stackNinjaTwo(:,:,2) * 1.5; 
subplot(5,3,5);
imshow(greyTwo);
title('Figure 2a: Colour space conversion');

greyThree = stackNinjaThree(:,:,2) * 1.5; 
subplot(5,3,6);
imshow(greyThree);
title('Figure 3a: Colour space conversion');

%{ 

%% Test: Grey colour space conversion using matlab function (rgb2gray)
greySNOne = rgb2gray(stackNinjaTwo);
subplot(4,3,4);
imshow(greySNTwo);
title('Figure 2a:');

greySNTwo = rgb2gray(stackNinjaTwo);
subplot(4,3,5);
imshow(greySNTwo);
title('Figure 2a:');

greySNThree = rgb2gray(stackNinjaThree);
subplot(4,3,6);
imshow(greySNThree);
title('Figure 3a:');

%}

%% Noise Reduction 

fixedMedOne = medfilt2(greyOne);
fixedMedTwo = medfilt2(greyTwo);
fixedMedThree = medfilt2(greyThree);

subplot(5,3,7);
imshow(fixedMedOne);
title('Figure1b: Noise removal with Median Filter');

subplot(5,3,8);
imshow(fixedMedTwo);
title('Figure2b: Noise removal with Median Filter');

subplot(5,3,9);
imshow(fixedMedThree);
title('Figure3b: Noise removal with Median Filter');


%% Test: Gaussian filtering 
%{
gauss1 = fspecial('gaussian',[3 3],0.5);
gauss2 = fspecial('gaussian',[5 5],1.0);
gauss3 = fspecial('gaussian',[7 7],1.5);
gauss4 = fspecial('gaussian',[12 12],3.0);

fixedGuassOne = imfilter(greyOne,gauss4);
fixedGuassTwo = imfilter(greyTwo,gauss4);
fixedGuassThree = imfilter(greyThree,gauss4);

subplot(4,3,7);
imshow(fixedGuassOne);
title('Noise removal with Gaussian Smoothing');

subplot(4,3,8);
imshow(fixedGuassTwo);
title('Noise removal with Gaussian Smoothing');

subplot(4,3,9);
imshow(fixedGuassThree);
title('Noise removal with Gaussian Smoothing');
%}

%% Thresholding 

% adapative thresholding 

otsuThreshOne = graythresh(fixedMedOne);
otsuThreshTwo = graythresh(fixedMedTwo);
otsuThreshThree = graythresh(fixedMedThree); 


otsuThreshOneLocal = adaptthresh(fixedMedOne,0.1);
otsuThreshTwoLocal = adaptthresh(fixedMedTwo,0.1);
otsuThreshThreeLocal = adaptthresh(fixedMedThree,0); 

%{
otsuThreshOne = graythresh(fixedMedOne);
otsuThreshTwo = graythresh(fixedMedTwo);
otsuThreshThree = graythresh(fixedMedThree); 
%otsuThreshTwo = adaptthresh(fixedMedTwo,0.1);
%otsuThreshThree = adaptthresh(fixedMedThree,0); 
%otsuThreshThree = medfilt2(otsuThreshThree);
%}
%{
%% Test:  Using fixed threshold
thresholdOne = 170;
thresholdTwo = 100;
thresholdThree = 100;

%fixedMedThree = fixedMedThree/255;

BWThree = fixedMedThree;
BWThree(BWThree>otsuThreshThree) = 255;
BWThree(BWThree<=otsuThreshThree) = 0;

FixedBWOne = fixedMedOne;
FixedBWOne(FixedBWOne>otsuThreshOne) = 255;
FixedBWOne(FixedBWOne<=otsuThreshOne) = 0;

FixedBWTwo = fixedMedThree;
FixedBWTwo(FixedBWTwo>thresholdTwo) = 255;
FixedBWTwo(FixedBWTwo<=thresholdTwo) = 0;

FixedBWThree = fixedMedThree;
FixedBWThree(FixedBWThree>thresholdThree) = 255;
FixedBWThree(FixedBWThree<=thresholdThree) = 0;
%}


%% Binary Image
%{
%% Test: using fixed threshold
binaryOne = imbinarize(FixedBWOne); 
binaryTwo = imbinarize(FixedBWTwo); 
binaryThree = imbinarize(FixedBWThree); 
%}

% extracting binary image using adaptive thresholding 
%global thresholding
binaryOne = imbinarize(fixedMedOne, otsuThreshOne); 
binaryTwo = imbinarize(fixedMedTwo, otsuThreshTwo); 
binaryThree = imbinarize(fixedMedThree, otsuThreshThree);

%local thresholding
binaryOneLocal = imbinarize(fixedMedOne, otsuThreshOneLocal); 
binaryTwoLocal = imbinarize(fixedMedTwo, otsuThreshTwoLocal); 
binaryThreeLocal = imbinarize(fixedMedThree, otsuThreshThreeLocal);

subplot(5, 3, 10),
imshow(binaryOne),
title('Figure 1c: Gloabl Binary Image');

subplot(5, 3, 11),
imshow(binaryTwo),
title('Figure 2c: Global Binary Image');

subplot(5, 3, 12),
imshow(binaryThree),
title('Figure 3c: Gloabl Binary Image');

subplot(5, 3, 13),
imshow(binaryOneLocal),
title('Figure 1d: Local Binary Image');

subplot(5, 3, 14),
imshow(binaryTwoLocal),
title('Figure 2d: Local Binary Image');

subplot(5, 3, 15),
imshow(binaryThreeLocal),
title('Figure 3d: Local Binary Image');

