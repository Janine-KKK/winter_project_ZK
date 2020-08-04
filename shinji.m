
folder1 = 'C:\dynare\neuroscience\winter_project_ZK\shinji images';
mkdir('shinji_Zhao')
folder2 = 'C:\dynare\neuroscience\winter_project_ZK\shinji_zhao';
copyfile(folder1,folder2);
filePattern2 = fullfile(folder2,'*.jpg');
theFiles2 = dir(filePattern2);
filename2 = {theFiles2.name};
%ID of zhao's images
N=[3
9
14
41
50
56
63
69
84
85
97
104
109
113
126
151
177
183
205
221
229
236
239
245
249
260
261
268
277
282
285
293
308
313
321
332
333
341
355
376
385
390
393
402
405
413
423
434
441
444
446
452
457
469
474
475
494
499
507
520
521
529
538
541
550
558
570
584
589
606
614
625
628
631
634
638
641
651
655
664
675
685
694
706
721
725
730
739
743
753
764
774
784
787
796
801
805
811
816
820
823
835
843
847
849
875
880
897
901
914
916
918
933
939
943
950
954
958
964
979
986
988
996
1006
1023
1026
1032
1035
1045
1048
1058
1076
1078
1079
1087
1090
1105
1110
1124
1125
1133
1136
1137
1149
1154
1167
1171
1180
1185
1207
1218
1229
1234
1238
1263
1277
1288
1290
1304
1309
1321
1326
1329
1333
1337
1348
1349
1361
1373
1383
1387
1402
1406
1413
1418
1428
1429
1443
1445
1457
1471
1477
1481
1487
1491
1493
1501
1515
1517
1537
1549
1563
1574
1581
1591
1602
1610
1628
1630
1631
1635
1645
1656
1659
1662
1663
1669
1679
1684
1715
1719
1734
1736
1737
1744
1748
1758
1774
1780
1801
1805
1820
1824
1837
1851
1876
1878
1883
1898
1903
1911
1921
1923
1928
1937
1951
1958
1963
1965
1981
1994
1998
2033
2037
2045
2068
2080
2105
2109
2116
2141
2145
2153
2161
2164
2173
2187
2197
2201
2209
2213
2221
2244
2260
2271
2277
2303
2320
2321
2367
2380
2381
2385
2407
2415
2419
2434
2440
2464
2466
2485
2487
2537
2563
2572
2589
2599
2657
2667
2702
2707
2716
2729
2748
2769
2774
2813
2817
2837
2853
2860
2863
2872
2875
2877
2923
2937
2949
2961
2969
2971
2975
2979
2991
2995
3003
3016
3038
3069
3089
3106
3143
3207
3222
3223
3230
3233
3247
3260
3279
3315
3321
3329
3372
3401
3415
3447
3508
3522
3547
3553
3591
3617
3723
3783
3837
3841
3930
3967
3988
4004
4014
4047
4086
4124
4197
4251
4266
4288
4299
4304
4351
4446
4466
4473
4490
4531
4538
4557
4570
4709
4719
4733
4746
4755
4865
4875
4884
4934
5971
6135
6173
6485
6488
6833
7205
7336
7360
7396
7467
7483
7549
7733
7829
7924
7936
7944
8010
8381
8478
8736
8777
8786
8811
8836
8852
8885
8934
8945
8992
9012
9015
9039
9091
9120
9999001
9999002
9999003
9999004
9999005
9999006
9999007
9999008
];

%keep zhao's files
filezhao = sprintfc('im%07d.jpg',N);
filename = sprintf('im%07d.jpg\n',N);
List_file= ismember(filename2,filezhao);
for a = 1:length(filename2)
    if List_file(a)==0
       deletefile1 = string(filename2(a));
       filepath2 = strcat('C:\dynare\neuroscience\winter_project_ZK\shinji_Zhao\',deletefile1);
       delete(filepath2);
    end
end  
        
%Drop Duplicate
M = [9
104
109
405
520
694
721
753
774
2464
843
1428
1471
1837
1758
1921
1951
1958
2033
2068
2367
2969
4288
1058
1563
9999001
9999003
9999005
9999007
787
1631
];%31 identified duplicate images

%delete duplicate
mkdir('shinji_without_duplicate')
folder3 = 'C:\dynare\neuroscience\winter_project_ZK\shinji_without_duplicate';
copyfile(folder2,folder3);
filePattern3 = fullfile(folder3,'*.jpg');
theFiles3 = dir(filePattern3);
filename3 = {theFiles3.name};
fileDuplicate = sprintfc('im%07d.jpg',M);
List_Duplicate = ismember(filename3, fileDuplicate);
for b = 1:length(filename3)
    if List_Duplicate(b)==1
    deletefile2 = string(filename3(b));
    filepath3 = strcat('C:\dynare\\neuroscience\winter_project_ZK\shinji_without_duplicate\',deletefile2);
    delete(filepath3);
    end
end
%%
folder3 = 'C:\dynare\neuroscience\winter_project_ZK\shinji_without_duplicate';
mkdir('null images')

nullpath = 'C:\dynare\neuroscience\winter_project_ZK\null images\';
edge=440;
%Reading  image
filePattern3 = fullfile(folder3,'*.jpg');
theFiles3 = dir(filePattern3);
for c=1:length(theFiles3)
filename3 = theFiles3(c).name;
fullname3 = fullfile(folder3,filename3);
fprintf(1,'Now reading %s\n',fullname3');
originalImage = imread(fullname3);

%crop image a 440*440 image out of original image

[rows, columns, numberOfColorChannels] = size(originalImage);
y = (rows-2*edge)/2;
x = (columns-2*edge)/2;
croppedImage = imcrop(originalImage, [x y 2*edge 2*edge]);
croppedImage = imresize(croppedImage, 0.5);
cropImname = string(filename3);
filename_N = strcat(nullpath,cropImname);
imwrite(croppedImage, filename_N);
end
%%
%dividing cropped image into 12 patches
%load the files and file names
folder4 = 'C:\dynare\neuroscience\winter_project_ZK\square_images\Nullselected';
filePattern4 = fullfile(folder4,'*.jpg');
theFiles4 = dir(filePattern4);
mkdir('null_periphery')
mkdir('null_center')



%crop patches in location 1-8
edge = 440/3;
for a = 1:length(theFiles4)
    filename4 = theFiles4(a).name;
    fullname4 = fullfile(folder4,filename4);
    fprintf(1,'Now reading %s\n',fullname4');
    croppedImage = imread(fullname4);
    cropImname = extractBefore(filename4,'.jpg');
for j = 1:3
    for i = 1:2:3
            dividedimage_NP = imcrop(croppedImage, [(j-1)*edge/3 (i-1)*edge/3 edge/3 edge/3]);
         if i == 1
            filename_NP = fullfile('C:\dynare\neuroscience\winter_project_ZK\null_periphery',strcat(cropImname,['_' num2str(j) '.jpg']));
         else
            filename_NP = fullfile('C:\dynare\neuroscience\winter_project_ZK\null_periphery',strcat(cropImname,['_' num2str(j+5) '.jpg']));
         end
         imwrite(dividedimage_NP,filename_NP);
    end
end 
%%%crop patches in locations 4-5
            dividedimage_N_4 = imcrop(croppedImage, [0 edge/3 edge/3 edge/3]);
            filename_N_4 = fullfile('C:\dynare\neuroscience\winter_project_ZK\null_periphery',strcat(cropImname,['_4' '.jpg']));
            dividedimage_N_5 = imcrop(croppedImage, [2*edge/3 edge/3 edge/3 edge/3]);
            filename_N_5 = fullfile('C:\dynare\neuroscience\winter_project_ZK\null_periphery',strcat(cropImname,['_5' '.jpg']));
            imwrite(dividedimage_N_4, filename_N_4);
            imwrite(dividedimage_N_5, filename_N_5);
%%%crop patches in locations 9-12
for k = 1:2%column
    for s = 1:2%row
        dividedimage_NC = imcrop(croppedImage, [edge/3+(k-1)*edge/6 edge/3+(s-1)*edge/6 edge/6 edge/6]);
        filename_NC = fullfile('C:\dynare\neuroscience\winter_project_ZK\null_center',strcat(cropImname,['_' num2str(8+k+2*(s-1)) '.jpg']));
        imwrite(dividedimage_NC, filename_NC);
    end
end

end
