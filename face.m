function [] = face( total, num, px, py, covariance, all_images, sumImage,type)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

[V,D] = eigs(covariance,num);
figure;
% Comuting the 25 eigen faces and displaying them

for i = 1:num
    subplot(px,py,i);
    imshow(reshape(V(:,i),30,30),[]);
    title(['Image #' num2str(i)]);
end

E = V';
% Getting the eigen-coefficients for all the images in the database set
for i = 1:total
    W(:,i) = E*(double(all_images(:,i))-sumImage(:,1));
end

genCount = 1;
impCount = 1;
scoCount = 1;
for i= 1:total
    for j = i+1:total
        temp = sqrt(sum((W(:,i)-W(:,j)).^2));
        scores(i,j) = temp;
        score_dis(scoCount,1) = temp;
        scoCount = scoCount + 1;
        if type=='n'
            if idivide(i-1,int32(5)) == idivide (j-1,int32(5))
                gen(genCount) = temp;
                genCount = genCount + 1; 
            else
                imp(impCount) = temp;
                impCount = impCount + 1;
            end
        end
    end
end

if type=='n'
    drawROC(gen',imp','d');

elseif type=='m'
    figure;
    hist(score_dis);
end

end

