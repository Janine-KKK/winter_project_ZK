%this code cuts images into 12 patches, among which 4 locate in the center
%of the square image

%load the files and file names
folder1 = 'C:\dynare\neuroscience\winter_project_ZK\square_images\congruent cropped';
folder2 = 'C:\dynare\neuroscience\winter_project_ZK\square_images\incongruent cropped';
folder3 = 'C:\dynare\neuroscience\winter_project_ZK\square_images\mask';

filePattern1 = fullfile(folder1,'*.jpg');
filePattern2 = fullfile(folder2,'*.jpg');
filePattern3 = fullfile(folder3,'*.jpg');

theFiles1 = dir(filePattern1);
theFiles2 = dir(filePattern2);
theFiles3 = dir(filePattern3);
 
%%
%crop patches in location 1-8
edge = 440/3;
for a = 1:length(theFiles1)

%%%Reading congruent image

filename1 = theFiles1(a).name;
fullname1 = fullfile(folder1,filename1);
fprintf(1,'Now reading %s\n',fullname1');
congruent = imread(fullname1);

%%%Reading incongruent image
filename2 = theFiles2(a).name;%see listing-file attributes in dir
fullname2 = fullfile(folder2,filename2);
fprintf(1,'Now reading %s\n',fullname2);
incongruent = imread(fullname2);

%%%Reading mask

filename3 = theFiles3(a).name;
fullname3 = fullfile(folder3,filename3);
fprintf(1,'Now reading %s\n',fullname3');
mask = imread(fullname3);
mkdir('cong_periphery')
mkdir('incong_periphery')
mkdir('cong_center')
mkdir('incong_center')
mkdir('mask_center')
%%%crop patches in locations 1-3, 6-8
for j = 1:3
    for i = 1:2:3
            dividedimage_CP = imcrop(congruent, [(j-1)*edge (i-1)*edge edge edge]);
            dividedimage_IP = imcrop(incongruent, [(j-1)*edge (i-1)*edge edge edge]);
 
         if i == 1
            filename_CP = fullfile('C:\dynare\neuroscience\winter_project_ZK\cong_periphery',['cong_' num2str(a) '_' num2str(j) '.jpg']);
            filename_IP = fullfile('C:\dynare\neuroscience\winter_project_ZK\incong_periphery',['incong_' num2str(a) '_' num2str(j) '.jpg']);
        
         else
            filename_CP = fullfile('C:\dynare\neuroscience\winter_project_ZK\cong_periphery',['cong_' num2str(a) '_' num2str(j+5) '.jpg']);
            filename_IP = fullfile('C:\dynare\neuroscience\winter_project_ZK\incong_periphery',['incong_' num2str(a) '_' num2str(j+5) '.jpg']);

         end
         imwrite(dividedimage_CP, filename_CP);
         imwrite(dividedimage_IP, filename_IP);
     
    end
end 
%%%crop patches in locations 4-5
            dividedimage_C_4 = imcrop(congruent, [0 edge edge edge]);
            dividedimage_I_4 = imcrop(incongruent, [0 edge edge edge]);
   
            filename_C_4 = fullfile('C:\dynare\neuroscience\winter_project_ZK\cong_periphery',['cong_' num2str(a) '_4' '.jpg']);
            filename_I_4 = fullfile('C:\dynare\neuroscience\winter_project_ZK\incong_periphery',['incong_' num2str(a) '_4' '.jpg']);
 
            dividedimage_C_5 = imcrop(congruent, [2*edge edge edge edge]);
            dividedimage_I_5 = imcrop(incongruent, [2*edge edge edge edge]);
        
            filename_C_5 = fullfile('C:\dynare\neuroscience\winter_project_ZK\cong_periphery',['cong_' num2str(a) '_5' '.jpg']);
            filename_I_5 = fullfile('C:\dynare\neuroscience\winter_project_ZK\incong_periphery',['incong_' num2str(a) '_5' '.jpg']);
           
            imwrite(dividedimage_C_4, filename_C_4);
            imwrite(dividedimage_I_4, filename_I_4);
           
            imwrite(dividedimage_C_5, filename_C_5);
            imwrite(dividedimage_I_5, filename_I_5);
           
%%%crop patches in locations 9-12
for k = 1:2%column
    for s = 1:2%row
        dividedimage_CC = imcrop(congruent, [edge+(k-1)*edge/2 edge+(s-1)*edge/2 edge/2 edge/2]);
        dividedimage_IC = imcrop(incongruent, [edge+(k-1)*edge/2 edge+(s-1)*edge/2 edge/2 edge/2]);
        dividedimage_MC = imcrop(mask, [edge+(k-1)*edge/2 edge+(s-1)*edge/2 edge/2 edge/2]);
        filename_CC = fullfile('C:\dynare\neuroscience\winter_project_ZK\cong_center',['cong_' num2str(a) '_' num2str(8+k+2*(s-1)) '.jpg']);
        filename_IC = fullfile('C:\dynare\neuroscience\winter_project_ZK\incong_center',['incong_' num2str(a) '_' num2str(8+k+2*(s-1)) '.jpg']);
        maskname = sprintf('maskCropc_%03d.jpg\n',a);
        filename_MC = fullfile('C:\dynare\neuroscience\winter_project_ZK\mask_center',strcat(maskname));
        imwrite(dividedimage_CC, filename_CC);
        imwrite(dividedimage_IC, filename_IC);
        imwrite(dividedimage_MC, filename_MC);
    end
end
end
       