clc
clear
% % Create the Base of Congruent Image Presentation
% Version for NEST FOLDER
file_path_Congruent_Center = 'cong_center\';
file_path_inCongruent_Center = 'incong_center\';
file_path_Congruent_Periphery = 'cong_periphery\';
file_path_inCongruent_Periphery = 'incong_periphery\';
file_path_N_periphery = 'nishimoto_periphery\';
file_path_N_center = 'nishimoto_center\';
file_path_CongruentCropped = 'squareimage\congruent cropped\';
file_path_InCongruentCropped = 'squareimage\incongruent cropped\';
file_path_mask = 'mask\';
file_path_Mask_Center = 'mask_center\';
file_path_Mask_Periphery = 'mask_periphery\';

% Version For individual folder
% file_path_Congruent_Patch = 'congruent patch\';
% file_path_inCongruent_Patch = 'incongruent patch\';
% file_path_N_patches = 'nishimoto patch\';
% file_path_CongruentCropped = 'squareimage\congruent cropped\';
% file_path_InCongruentCropped = 'squareimage\incongruent cropped\';
% file_path_mask = 'mask\';
% file_path_patch_mask = 'maskCrop\';

Total_Trial_number = 30; %% Define how many congruent images are used to presentation
Total_Trial_number_practice = 3; % was 3
Number_of_Masking = 20;
for subject = 1:1
    order_list_group = randperm(140,140); % Shuffle the order of the square image base
    for group = 1:5
        DesDir = sprintf('Subject_%d_Group_%d',subject,group);
        mkdir('WebVersion\',DesDir);
        DST_PATH_t = ['WebVersion\',DesDir];
        %%Allocate the square images in each group
        if group == 1 || group == 2 || group == 3 || group == 4
            order_list = order_list_group(1 + Total_Trial_number*(group-1):Total_Trial_number + Total_Trial_number*(group-1));
        else
            order_list = order_list_group(111:end);
        end
        order_list_Masking = randperm(140,Number_of_Masking);
        order_list_practice = randperm(140,Total_Trial_number_practice);
        filename = sprintf('BaseScript_B%d_G%d.iqx',subject,group);
        fid = fopen(filename,'w');%Open or create new file for writing. Discard existing contents, if any.
        NumberOfNpatch = 7044;
        
%% Create List of Images in Present Step 
%Need to mix the congruent and Incongruent images throughout the experiment
        fprintf(fid,'<item image_presentation>\n'); %Only create the congruent part
        PresentArray = string(ones(1,Total_Trial_number)); %Pre-create an array to represent the order of presentation image for INCONG and CONG
        if mod(Total_Trial_number,2) == 0
            ChooseINCONGorCONG = randerr(1,Total_Trial_number,Total_Trial_number/2)+1;
        elseif mod(Total_Trial_number,2) == 1
            ChooseINCONGorCONG = randerr(1,Total_Trial_number,(Total_Trial_number-1)/2)+1;
        end
        for presentation_number = 1:Total_Trial_number
            if ChooseINCONGorCONG(presentation_number) == 1
                PresentArray(presentation_number) = 'Cong';
                string_order = num2str(order_list(presentation_number).','%03d');
                address = sprintf('"%s%s.jpg"','SquareCongruent_',string_order);
                file_name = sprintf('%s%s%s.jpg',file_path_CongruentCropped,'SquareCongruent_',string_order); 
                fprintf(fid,'/%d = ',presentation_number);
                fprintf(fid,'%s\n',address);
                copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            elseif ChooseINCONGorCONG(presentation_number) == 2
                %Here to create part of Incongruent images
                PresentArray(presentation_number) = 'INcong';
                string_order = num2str(order_list(presentation_number).','%03d');
                address = sprintf('"%s%s.jpg"','SquareIncongruent_',string_order);
                file_name = sprintf('%s%s%s.jpg',file_path_InCongruentCropped,'SquareIncongruent_',string_order); 
                fprintf(fid,'/%d = ',presentation_number);
                fprintf(fid,'%s\n',address);
                copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
            end
        end
        fprintf(fid,'</item>\n\n');
   
%% Create List of Presentation for Practice        
fprintf(fid,'<item image_presentation_practice>\n');
PresentArray_practice = string(ones(1,Total_Trial_number_practice));
if mod(Total_Trial_number_practice,2) == 0
    ChooseINCONGorCONG_practice = randerr(1,Total_Trial_number_practice,Total_Trial_number_practice/2)+1;
elseif mod(Total_Trial_number_practice,2) == 1
    ChooseINCONGorCONG_practice = randerr(1,Total_Trial_number_practice,(Total_Trial_number_practice-1)/2)+1;
end
for presentation_number = 1:Total_Trial_number_practice
    if ChooseINCONGorCONG_practice(presentation_number) == 1
        PresentArray_practice(presentation_number) = 'Cong';
        string_order = num2str(order_list_practice(presentation_number).','%03d');
        address = sprintf('"%s%s.jpg"','SquareCongruent_',string_order);
        file_name = sprintf('%s%s%s.jpg',file_path_CongruentCropped,'SquareCongruent_',string_order);
        fprintf(fid,'/%d = ',presentation_number);
        fprintf(fid,'%s\n',address);
        copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
    elseif ChooseINCONGorCONG_practice(presentation_number) == 2
        %Here to create part of Incongruent images
        PresentArray_practice(presentation_number) = 'INcong';
        string_order = num2str(order_list_practice(presentation_number).','%03d');
        address = sprintf('"%s%s.jpg"','SquareIncongruent_',string_order);
        file_name = sprintf('%s%s%s.jpg',file_path_InCongruentCropped,'SquareIncongruent_',string_order);
        fprintf(fid,'/%d = ',presentation_number);
        fprintf(fid,'%s\n',address);
        copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
    end
end
fprintf(fid,'</item>\n\n');

%% Create List of Masking and the masking for patches
           for Masking_group = 1:5
                string_title_number = num2str(Masking_group.','%01d');
                fprintf(fid,'<item Masking_item_%s>\n',string_title_number);
                for content = 1:(Number_of_Masking/4)%was divided by 4
                    string_order = num2str(order_list_Masking(content+(Number_of_Masking/4)*(Masking_group-1)).','%03d');
                    fprintf(fid,'/%d = "mask_%s.jpg"\n',content,string_order);
                    file_name = sprintf('%smask_%s.jpg',file_path_mask,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
                fprintf(fid,'</item>\n\n');
            end

            for Masking_group_periphery = 1:5%%%%%%%%%%%%%%%%%%%%%%%%%%%change to include mask for small patches
                string_title_number = num2str(Masking_group_periphery.','%01d');
                fprintf(fid,'<item Masking_patch_item_%s>\n',string_title_number);
                for content = 1:(Number_of_Masking/4)%was divided by 5
                    string_order = num2str(order_list_Masking(content+(Number_of_Masking/4)*(Masking_group_periphery-1)).','%03d');
                    fprintf(fid,'/%d = "maskCrop_%s.jpg"\n',content,string_order);
                    file_name = sprintf('%smaskCrop_%s.jpg',file_path_mask_periphery,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
                fprintf(fid,'</item>\n\n');
            end
            
            for Masking_group_center = 1:5
                string_title_number = num2str(Masking_group_center.','%01d');
                fprintf(fid,'<item Masking_patch_item_%s>\n',string_title_number);
                for content = 1:(Number_of_Masking/4)%was divided by 5
                    string_order = num2str(order_list_Masking(content+(Number_of_Masking/4)*(Masking_group_center-1)).','%03d');
                    fprintf(fid,'/%d = "maskCrop_%s.jpg"\n',content,string_order);
                    file_name = sprintf('%smaskCrop_%s.jpg',file_path_mask_center,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
                fprintf(fid,'</item>\n\n');
            end
%% Here used to specify where the CP located 
%{          
IP_position = ones(1,length(order_list));
            for presentation_order = 1:length(order_list)
                Presentation_image_patch_name = sprintf('cong_%d_*.jpg',order_list(presentation_order));
                img_path_list = dir(strcat(file_path_Congruent_Patch,Presentation_image_patch_name));
                num_img = length(img_path_list);  
                temp_array = ones(1,num_img);
                for kk = 1:num_img
                    temp_array(kk) =
                    img_path_list(kk).name(length(img_path_list(kk).name)-4);%find
                    the last but 4 digit in the file name (the one before
                    ".jpg")
                end
                IP_position(presentation_order) = find(temp_array == 'p'); %%Find the CP position of the image
            end
            
            % Practice Part
            IP_position_practice = ones(1,length(order_list_practice));
            for presentation_order = 1:length(order_list_practice)
                Presentation_image_patch_name = sprintf('cong_%d_*.jpg',order_list_practice(presentation_order));
                img_path_list = dir(strcat(file_path_Congruent_Patch,Presentation_image_patch_name));
                num_img = length(img_path_list);  
                temp_array = ones(1,num_img);
                for kk = 1:num_img
                    temp_array(kk) = img_path_list(kk).name(length(img_path_list(kk).name)-4);
                end
                IP_position_practice(presentation_order) = find(temp_array == 'p'); %%Find the CP position of the image
            end
%% Create CP position group
            fprintf(fid,'<item CP_patch>\n');
            for presentation_number = 1:Total_Trial_number
                if PresentArray(presentation_number) == "Cong"
                   item_content = sprintf('incong_%d_%d_p.jpg',order_list(presentation_number),IP_position(presentation_number));
                   fprintf(fid,'/%d = "%s"\n',presentation_number,item_content);
                   file_name = sprintf('%s%s',file_path_inCongruent_Patch,item_content);
                   copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                elseif PresentArray(presentation_number) == "INcong"
                   item_content = sprintf('cong_%d_%d_p.jpg',order_list(presentation_number),IP_position(presentation_number));
                   fprintf(fid,'/%d = "%s"\n',presentation_number,item_content);
                   file_name = sprintf('%s%s',file_path_Congruent_Patch,item_content);
                   copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,'</item>\n\n');
            
%% Create CP position group for Practice Part
            fprintf(fid,'<item CP_patch_practice>\n');
            for presentation_number = 1:Total_Trial_number_practice
                if PresentArray_practice(presentation_number) == "Cong"
                   item_content = sprintf('incong_%d_%d_p.jpg',order_list_practice(presentation_number),IP_position_practice(presentation_number));
                   fprintf(fid,'/%d = "%s"\n',presentation_number,item_content);
                   file_name = sprintf('%s%s',file_path_inCongruent_Patch,item_content);
                   copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                elseif PresentArray_practice(presentation_number) == "INcong"
                   item_content = sprintf('cong_%d_%d_p.jpg',order_list_practice(presentation_number),IP_position_practice(presentation_number));
                   fprintf(fid,'/%d = "%s"\n',presentation_number,item_content);
                   file_name = sprintf('%s%s',file_path_Congruent_Patch,item_content);
                   copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,'</item>\n\n');
%% Create coordinates for CP position group

           CP_x_coordinates = string(ones(1,Total_Trial_number));
            CP_y_coordinates = string(ones(1,Total_Trial_number));
            for presentation_number = 1:Total_Trial_number
                if IP_position(presentation_number) == 1 || IP_position(presentation_number) == 4 || IP_position(presentation_number) == 7
                    CP_x_coordinates(presentation_number) = "33.3";
                elseif IP_position(presentation_number) == 2 || IP_position(presentation_number) == 5 || IP_position(presentation_number) == 8
                    CP_x_coordinates(presentation_number) = "50";
                elseif IP_position(presentation_number) == 3 || IP_position(presentation_number) == 6 || IP_position(presentation_number) == 9
                    CP_x_coordinates(presentation_number) = "66.7";
                end    
            end

            for presentation_number = 1:Total_Trial_number
                if IP_position(presentation_number) == 1 || IP_position(presentation_number) == 2 || IP_position(presentation_number) == 3
                    CP_y_coordinates(presentation_number) = "25";
                elseif IP_position(presentation_number) == 4 || IP_position(presentation_number) == 5 || IP_position(presentation_number) == 6
                    CP_y_coordinates(presentation_number) = "50";
                elseif IP_position(presentation_number) == 7 || IP_position(presentation_number) == 8 || IP_position(presentation_number) == 9
                    CP_y_coordinates(presentation_number) = "75";
                end    
            end

            fprintf(fid,'<item CP_x_coordinates>\n');
            for presentation_number = 1:Total_Trial_number
                fprintf(fid,'/%d = "%s%%"\n',presentation_number,CP_x_coordinates(presentation_number));
            end
            fprintf(fid,'</item>\n\n');

            fprintf(fid,'<item CP_y_coordinates>\n');
            for presentation_number = 1:Total_Trial_number
                fprintf(fid,'/%d = "%s%%"\n',presentation_number,CP_y_coordinates(presentation_number));
            end
            fprintf(fid,'</item>\n\n');

            
%% Practice Part
%Practice Part
            CP_x_coordinates_practice = string(ones(1,Total_Trial_number_practice));
            CP_y_coordinates_practice = string(ones(1,Total_Trial_number_practice));
            for presentation_number = 1:Total_Trial_number_practice
                if IP_position_practice(presentation_number) == 1 || IP_position_practice(presentation_number) == 4 || IP_position_practice(presentation_number) == 7
                    CP_x_coordinates_practice(presentation_number) = "33.3";
                elseif IP_position_practice(presentation_number) == 2 || IP_position_practice(presentation_number) == 5 || IP_position_practice(presentation_number) == 8
                    CP_x_coordinates_practice(presentation_number) = "50";
                elseif IP_position_practice(presentation_number) == 3 || IP_position_practice(presentation_number) == 6 || IP_position_practice(presentation_number) == 9
                    CP_x_coordinates_practice(presentation_number) = "66.7";
                end    
            end

            for presentation_number = 1:Total_Trial_number_practice
                if IP_position_practice(presentation_number) == 1 || IP_position_practice(presentation_number) == 2 || IP_position_practice(presentation_number) == 3
                    CP_y_coordinates_practice(presentation_number) = "25";
                elseif IP_position_practice(presentation_number) == 4 || IP_position_practice(presentation_number) == 5 || IP_position_practice(presentation_number) == 6
                    CP_y_coordinates_practice(presentation_number) = "50";
                elseif IP_position_practice(presentation_number) == 7 || IP_position_practice(presentation_number) == 8 || IP_position_practice(presentation_number) == 9
                    CP_y_coordinates_practice(presentation_number) = "75";
                end    
            end

            fprintf(fid,'<item CP_x_coordinates_practice>\n');
            for presentation_number = 1:Total_Trial_number_practice
                fprintf(fid,'/%d = "%s%%"\n',presentation_number,CP_x_coordinates_practice(presentation_number));
            end
            fprintf(fid,'</item>\n\n');

            fprintf(fid,'<item CP_y_coordinates_practice>\n');
            for presentation_number = 1:Total_Trial_number_practice
                fprintf(fid,'/%d = "%s%%"\n',presentation_number,CP_y_coordinates_practice(presentation_number));
            end
            fprintf(fid,'</item>\n\n'); 
%}
%% Create Picture Stimuli

%% Randomly selcet 3 patches from 9 positions in the original image, and the position keep the same location from the image

%% Create group of position 1
            fprintf(fid,'<picture Patch_locate_1_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location1.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            %% Create group of position 2
            fprintf(fid,'<picture Patch_locate_2_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location2.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
%% Create group of position 3
            %Create Group of Position 3
            fprintf(fid,'<picture Patch_locate_3_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location3.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 4
            fprintf(fid,'<picture Patch_locate_4_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location4.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            %% Create group of position 5
            %Create Group of Position 5
            fprintf(fid,'<picture Patch_locate_5_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location5.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 6
            fprintf(fid,'<picture Patch_locate_6_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location6.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 7
%Create Group of Position 7
            fprintf(fid,'<picture Patch_locate_7_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location7.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
        
%% Create group of position 8
            fprintf(fid,'<picture Patch_locate_8_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location8.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
%% Create group of position 9
%Create Group of Position 9
            fprintf(fid,'<picture Patch_locate_9_present>\n');
            fprintf(fid,'  / size = (values.present_image_size,values.present_image_size)\n');
            fprintf(fid,'  / position = (50%%,50%%)\n');
            fprintf(fid,'  /items = ("location9.png")\n');
            fprintf(fid,'  /select = sequence\n');
            fprintf(fid,'</picture>\n\n');
            
            
            
%% Create Absent patch stimuli step
% Randomly select from the base, but it needs to be in the same location from
% that image.
            num_N_patch = Total_Trial_number * 3;
            n_patch_order = 1:7044;
            n_patch_order(mod(n_patch_order,4) == 0) = [];%delete the number in n_patch_order that can be divided by 4
            temp = randperm(length(n_patch_order),length(n_patch_order));
            for i = 1:length(n_patch_order)
                n_patch_order(i) = n_patch_order(temp(i));%%%%%%%%%%%%%%%%%?????
            end
            
            n_patch_order = n_patch_order(1:num_N_patch);
            n_patch_location = mod(n_patch_order,12);
 %% Create group of position 1
            fprintf(fid,'<picture nPatch_locate_1_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_1,values.location_vertical_1)\n');
            fprintf(fid,'  /items = (');
            for n_patch_list = 1:length(n_patch_order)
                if n_patch_location(n_patch_list) == 1
                    string_order = num2str(n_patch_order(n_patch_list).','%07d');
                    fprintf(fid,'"patch%s.jpg",\n',string_order);
                    file_name = sprintf('%spatch%s.jpg',file_path_N_patches,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 2
             fprintf(fid,'<picture nPatch_locate_2_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_2,values.location_vertical_1)\n');
            fprintf(fid,'  /items = (');
            for n_patch_list = 1:length(n_patch_order)
                if n_patch_location(n_patch_list) == 2
                    string_order = num2str(n_patch_order(n_patch_list).','%07d');
                    fprintf(fid,'"patch%s.jpg",\n',string_order);
                    file_name = sprintf('%spatch%s.jpg',file_path_N_patches,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 3
             fprintf(fid,'<picture nPatch_locate_3_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_3,values.location_vertical_1)\n');
            fprintf(fid,'  /items = (');
            for n_patch_list = 1:length(n_patch_order)
                if n_patch_location(n_patch_list) == 3
                    string_order = num2str(n_patch_order(n_patch_list).','%07d');
                    fprintf(fid,'"patch%s.jpg",\n',string_order);
                    file_name = sprintf('%spatch%s.jpg',file_path_N_patches,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 4
            fprintf(fid,'<picture nPatch_locate_4_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_1,values.location_vertical_2)\n');
            fprintf(fid,'  /items = (');
            for n_patch_list = 1:length(n_patch_order)
                if n_patch_location(n_patch_list) == 5
                    string_order = num2str(n_patch_order(n_patch_list).','%07d');
                    fprintf(fid,'"patch%s.jpg",\n',string_order);
                    file_name = sprintf('%spatch%s.jpg',file_path_N_patches,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 5
              fprintf(fid,'<picture nPatch_locate_5_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_2,values.location_vertical_2)\n');
            fprintf(fid,'  /items = (');
            for n_patch_list = 1:length(n_patch_order)
                if n_patch_location(n_patch_list) == 6
                    string_order = num2str(n_patch_order(n_patch_list).','%07d');
                    fprintf(fid,'"patch%s.jpg",\n',string_order);
                    file_name = sprintf('%spatch%s.jpg',file_path_N_patches,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 6
               fprintf(fid,'<picture nPatch_locate_6_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_3,values.location_vertical_2)\n');
            fprintf(fid,'  /items = (');
            for n_patch_list = 1:length(n_patch_order)
                if n_patch_location(n_patch_list) == 7
                    string_order = num2str(n_patch_order(n_patch_list).','%07d');
                    fprintf(fid,'"patch%s.jpg",\n',string_order);
                    file_name = sprintf('%spatch%s.jpg',file_path_N_patches,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 7
            fprintf(fid,'<picture nPatch_locate_7_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_1,values.location_vertical_3)\n');
            fprintf(fid,'  /items = (');
            for n_patch_list = 1:length(n_patch_order)
                if n_patch_location(n_patch_list) == 9
                    string_order = num2str(n_patch_order(n_patch_list).','%07d');
                    fprintf(fid,'"patch%s.jpg",\n',string_order);
                    file_name = sprintf('%spatch%s.jpg',file_path_N_patches,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 8
             fprintf(fid,'<picture nPatch_locate_8_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_2,values.location_vertical_3)\n');
            fprintf(fid,'  /items = (');
            for n_patch_list = 1:length(n_patch_order)
                if n_patch_location(n_patch_list) == 10
                    string_order = num2str(n_patch_order(n_patch_list).','%07d');
                    fprintf(fid,'"patch%s.jpg",\n',string_order);
                    file_name = sprintf('%spatch%s.jpg',file_path_N_patches,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
 %% Create group of position 9
            fprintf(fid,'<picture nPatch_locate_9_resource>\n');
            fprintf(fid,'  / size = (values.present_image_size/3,values.present_image_size/3)\n');
            fprintf(fid,'  / position = (values.location_horizontal_3,values.location_vertical_3)\n');
            fprintf(fid,'  /items = (');
            for n_patch_list = 1:length(n_patch_order)
                if n_patch_location(n_patch_list) == 11
                    string_order = num2str(n_patch_order(n_patch_list).','%07d');
                    fprintf(fid,'"patch%s.jpg",\n',string_order);
                    file_name = sprintf('%spatch%s.jpg',file_path_N_patches,string_order);
                    copyfile(file_name,DST_PATH_t);%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%COPY
                end
            end
            fprintf(fid,')\n');
            fprintf(fid,'  / select = noreplace\n');
            fprintf(fid,'</picture>\n\n');
            
            %% List to define the image whether a Cong or Incong
            fprintf(fid,'<item CongOrIncong>\n');
            for presentation_order = 1:length(order_list)
                if PresentArray(presentation_order) == "Cong"
                    fprintf(fid,'/%d = "Cong" \n',presentation_order);
                elseif PresentArray(presentation_order) == "INcong"
                    fprintf(fid,'/%d = "Incong" \n',presentation_order);
                end
            end
            fprintf(fid,'</item>\n\n');

%% List to define whether an object in that patch(The list of location of the object patch)
            fprintf(fid,'<item Object_Patch>\n');
            for presentation_order = 1:length(order_list)
                fprintf(fid,'/%d = "%d"\n',presentation_order,IP_position(presentation_order));
            end
            fprintf(fid,'</item>\n\n');

            fprintf(fid,'<item Object_Patch_practice>\n');
            for presentation_order = 1:length(order_list_practice)
                fprintf(fid,'/%d = "%d"\n',presentation_order,IP_position_practice(presentation_order));
            end
            fprintf(fid,'</item>\n\n');

%% List of Image ID
            fprintf(fid,'<item Image_ID>\n');
            for presentation_order = 1:length(order_list)
                fprintf(fid,'/%d = "%d"\n',presentation_order,order_list(presentation_order));
            end
            fprintf(fid,'</item>\n\n');


%             fprintf(fid,'<page intro>\n');
%             fprintf(fid,'^^Welcome to our experiment!\n');
%             fprintf(fid,'</page>\n');
% 
%             fprintf(fid,'<page end>\n');
%             fprintf(fid,'^^This is the end of the experiment !\n');
%             fprintf(fid,'^^Thank you for your coorperation !\n');
%             fprintf(fid,'</page>\n');


%             fprintf(fid,'<expt Throughout>\n');
%             fprintf(fid,'/ preinstructions = (intro)\n');
%             fprintf(fid,'/ postinstructions = (end)\n');
%             fprintf(fid,'/ blocks = [');
%             fprintf(fid,']\n');
%             fprintf(fid,'</expt>\n\n');
%             fclose(fid);
 
            
    end
end   














