clear;
close all;
clc;

files = dir('images/*.bmp');
images = cell(1,30);
eigen_values = zeros(1,30);
all_images = cell(1,50);
count = 1;
figure;
c = 1;
%% Getting the face images
disp('Getting all faces from the directory');
for i = 1:length(files)
    filename =  ['images/' files(i).name];
    
    if mod(i,5)<= 3 && mod(i,5) >= 1
        file = imread(filename);
        
        subplot(3,10,c);
        imshow(file,[]);
        title(['Image #' num2str(c)]);
        
        % Mean face calculation 
        file = reshape(file,900,1);
        images{count} = file;
        
        
        count = count + 1;
        c = count;
    end
    all_images{i} = reshape(imread(filename),900,1);
end


%% Mean face calculations
images = cell2mat(images);
sumImage = zeros(900,1);

all_images = cell2mat(all_images);
disp('calculating the mean face');
for j = 1:30
    for k =  1:900
        sumImage(k,1) = mean(images(k,:));
        
    end
end

meanFace = reshape(sumImage,30,30);
imshow(meanFace,[]);

%% Original face subtracted by the mean face
for i = 1: sqrt(length(images))
   A(:,i)=double(images(:,i))-sumImage(:,1);
end

%% Mean Faces subtracted images
figure;
for i = 1:30
    subplot(3,10,i);
    imshow(reshape(A(:,i),30,30),[]);
    title(['Image #' num2str(i)]);
end
covariance = cov(A');

% %% Each Function Calling
% disp('Processing 25...');
% face(50,25,5,5, covariance, all_images, sumImage,'n');
% disp('End of process for 25');
% 
% disp('Processing 20...');
% face(50,20,5,4, covariance, all_images, sumImage,'n');
% disp('End of process for 20');
% 
% disp('Processing 10...');
% face(50,10,2,5, covariance, all_images, sumImage,'n');
% disp('End of process for 10');
% 
% disp('Processing 5...');
% face(50,5,1,5, covariance, all_images, sumImage,'n');
% disp('End of process for 5');


%% My Images
disp('Running my Face Images');
files2 = dir('My_Face_Pictures/*.jpg');
all_my_images = cell(1,10);
count = 1;
figure;

for i = 1:length(files2)
    filename =  ['My_Face_Pictures/' files2(i).name];
    file2 = imread(filename);
    
    subplot(2,5,i);
    imshow(file2,[]);
    title(['Image #' num2str(i)]);
    all_my_images{i} = reshape(file2,900,1);
end
all_my_images = cell2mat(all_my_images);

disp('Processing My face in 3.....2.....1.... GO !!!!!...');
face(10,25,5,5, covariance, all_my_images, sumImage,'m');
disp('End of processing my faces yaaaaa!');
