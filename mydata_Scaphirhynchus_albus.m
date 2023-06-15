function [data, auxData, metaData, txtData, weights] = mydata_Scaphirhynchus_albus

%% set metadata
metaData.phylum     = 'Chordata'; 
metaData.class      = 'Actinopterygii'; 
metaData.order      = 'Acipenseriformes'; 
metaData.family     = 'Acipenseridae';
metaData.species    = 'Scaphirhynchus_albus'; 
metaData.species_en = 'Pallid sturgeon'; 

metaData.ecoCode.climate = {'Cfb','Dfb','MB'};
metaData.ecoCode.ecozone = {'THn'};
metaData.ecoCode.habitat = {'0iFr'};
metaData.ecoCode.embryo  = {'Fg'};
metaData.ecoCode.migrate = {'Ma'};
metaData.ecoCode.food    = {'biCi', 'biCvf'};
metaData.ecoCode.gender  = {'D'};
metaData.ecoCode.reprod  = {'O'};

metaData.T_typical  = C2K(13); % K, body temp 
metaData.data_0     = {'ab'; 'ap'; 'am'; 'Li'; 'Wwb'; 'Wwi'; 'Ri'}; 
metaData.data_1     = {'LWw', 't-L', 't-Ww'};

metaData.COMPLETE = 2.5; % using criteria of LikaKear2011

metaData.author    = {'Starrlight Augustine'};                             
metaData.date_subm = [2020 06 22];                          
metaData.email     = {'sta@akvtplan.niva.no'};                 
metaData.address   = {'Akvaplan-niva, FRAM, Tromso, Norway'};      

metaData.author_mod_1    = {'Nicole Daigle'};                             
metaData.date_mod_1 = [2023 06 15];                          
metaData.email_mod_1     = {'Nicole.Daigle@unb.ca'};                 
metaData.address_mod_1   = {'University of New Brunswick, Canada'};      

% metaData.curator     = {'Bas Kooijman'};
% metaData.email_cur   = {'bas.kooijman@vu.nl'}; 
% metaData.date_acc    = [2020 06 23]; 

%% set data
% % zero-variate data;
data.ab = 8; units.ab = 'd';      label.ab = 'age at hatch';   bibkey.ab = 'Wiki';    
  temp.ab = C2K(13); units.temp.ab = 'K'; label.temp.ab = 'temperature';
  comment.ab = 'temp is guessed, wiki says 5-8 days for hatching, and we are not sure how long between hatch and first feeding.'; 
data.tp = 9 * 365;  units.tp = 'd'; label.tp = 'age at puberty'; bibkey.tp = 'KeenJenk1993'; 
  temp.tp = C2K(13); units.temp.tp = 'K'; label.temp.tp = 'temperature'; 
  comment.tp = 'temp is guessed- value for females, study says Females began egg development at ages 9-12 yr and first spawned at age 15 yr';
data.tp_m = 5 * 365;  units.tp_m = 'd'; label.tp_m = 'age at puberty'; bibkey.tp_m = 'KeenJenk1993';
  temp.tp_m = C2K(13); units.temp.tp_m = 'K'; label.temp.tp_m = 'temperature'; 
  comment.tp_m = 'temp is guessed- Males reached sexual maturity at ages 5-7 yr';
data.am = 100*365; units.am = 'd';  label.am = 'life span';      bibkey.am = 'Wiki';   
  temp.am = C2K(13);units.temp.am = 'K'; label.temp.am = 'temperature';
  comment.am = 'temperature is guessed';
  
data.Li  = 0.85*200;  units.Li  = 'cm';  label.Li  = 'ultimate fork length'; bibkey.Li  = 'FishBase';
  comment.Li = 'based on TL of 2m, with FL = 0.85*TL from photo';

data.Wwb = 14.1e-3;    units.Wwb = 'g';   label.Wwb = 'wet weight at birth';   bibkey.Wwb = 'GeorSlac2012';
  comment.Wwb = 'based on egg diameter of 3 mm: pi/6*0.3^3'; 
data.Wwi = 45e3;    units.Wwi = 'g';   label.Wwi = 'ultimate wet weight';   bibkey.Wwi = 'FishBase'; %this is off, waa orig 130e3

data.Ri  = 58913/365; units.Ri  = '#/d'; label.Ri  = 'maximum reprod rate';   bibkey.Ri  = 'GeorSlac2012';   

  temp.Ri = C2K(13);  units.temp.Ri = 'K'; label.temp.Ri = 'temperature';
  comment.Ri = 'temperature is guessed, max value estimated used here';
% 
% uni-variate data 
data.LW = [ ... % fork length (mm), wet weight (g)
864 2239
897 2948
990 3402
1096 6500
794 1941
893 2835
940 3266
1130 4990
1274 12247
1384 9979
1433 15422
1244 10433
1356 14515
1378 15000
1404 17100
1397 15700
1454 17700
1448 18000
1479 19051
];
data.LW(:,1) = data.LW(:,1)/10; % convert mm to cm
 units.LW = {'cm', 'g'};     label.LW = {'fork length', 'wet weight'};  bibkey.LW = 'KeenMax1993';
   temp.LW = C2K(13);  units.temp.LW = 'K'; label.temp.LW = 'temperature'; comment.LW = 'see source for converting between SL, TL and FL lengths.';
  
 data.tL = [ ... year, mm fork length
     7 601
     10 864
     11 705
     12 657
     12 910
     14 853
     17 865
     25 1274
     41 1404];
 data.tL(:,2) = data.tL(:,2)/ 10; % convert mm to cm
  data.tL(:,1) = data.tL(:,1) * 365; % convert yr to d
 units.tL = {'d', 'cm'};     label.tL = {'time since birth', 'fork length'};  bibkey.tL = 'KeenJenk1993';
   temp.tL = C2K(13);  units.temp.tL = 'K'; label.temp.tL = 'temperature'; comment.tL = 'females, temp is guessed';

 data.tWw = [ ... yr, kg
     7 0.8
     10 2.2
     11 2.0
     12 1.2
     12 4.0
     14 3.9
     17 4.2
     25 12.2
     41 17.1];
data.tWw(:,2) = data.tWw(:,2) * 1e3; % convert kg to g
  data.tWw(:,1) = data.tWw(:,1) * 365; % convert yr to d
 units.tWw = {'d', 'g'};     label.tWw = {'time since birth', 'wet weight'};  bibkey.tWw = 'KeenJenk1993';
   temp.tWw = C2K(13);  units.temp.tWw = 'K'; label.temp.tWw = 'temperature'; comment.tWw = 'females, temp is guessed';
   
   
 data.tL_m = [ ...
     8 640
     8 738
     9 710
     11 724
     37 1244];
  data.tL_m(:,2) = data.tL_m(:,2)/ 10; % convert mm to cm
  data.tL_m(:,1) = data.tL_m(:,1) * 365; % convert yr to d
 units.tL_m = {'d', 'cm'};     label.tL_m = {'time since birth', 'fork length'};  bibkey.tL_m = 'KeenJenk1993';
   temp.tL_m = C2K(13);  units.temp.tL_m = 'K'; label.temp.tL_m = 'temperature'; comment.tL_m = 'males, temp guessed';

   
 data.tWw_m = [ ... yr, kg
     8 1.2
     8 1.9
     9 1.7
     11 1.6
     37 10.4];
data.tWw_m(:,2) = data.tWw_m(:,2) * 1e3; % convert kg to g
  data.tWw_m(:,1) = data.tWw_m(:,1) * 365; % convert yr to d
 units.tWw_m = {'d', 'g'};     label.tWw_m = {'time since birth', 'wet weight'};  bibkey.tWw_m = 'KeenJenk1993';
   temp.tWw_m = C2K(13);  units.temp.tWw_m = 'K'; label.temp.tWw_m = 'temperature'; comment.tWw_m = 'males, temp guessed'; 
   
% % data.LW2 = [ ... % fork length (mm), wet weight (g), from Shuman's regression
% % 200	  20.9726
% % 300	  79.7179
% % 400	  205.591
% % 500	  428.695
% % 600	  781.462
% % 700	  1298.31
% % 800	  2015.38
% % 900	  2970.38
% % 1000  4202.43
% % 1100  5751.94
% % 1200  7660.55
% % 1300  9970.99
% % 1400  12727.1
% % 1500  15973.6
% % 1600  19756.4];
% % data.LW2(:,1) = data.LW2(:,1)/10; % convert mm to cm
% %  units.LW2 = {'cm', 'g'};     label.LW2 = {'fork length', 'wet weight'};  bibkey.LW2 = 'ShumKlum2011';
% %    temp.LW2 = C2K(13);  units.temp.LW2 = 'K'; label.temp.LW2 = 'temperature'; comment.LW2 = 'temp is guessed (metadata from field collections)';
% % 

%start of growth (length and weight data) for fish at different feeding levels    
% weight for f=0 (fasted) group 
data.tWw_f1 = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 112 112 112 112 112 112 112 112 112 112 112 112 112 135 135 135 135 135 135 135 135 135 135 135 135 135; %this is is feeding group 1 (fasted)
                1855 3553 3197 3244 4286 2774 2743 3225 2853 2957 3182 3581 3046 3717 3869 1762 3378 3155 3041 4069 2634 2624 3160 2768 2850 3040 3519 2926 3586 3740 1716 3304 3068 2808 3990 2506 2535 3105 2676 2766 2938 3428 2887 3465 3649 1675 3227 2992 2689 3900 3054 2627 2722 2879 3342 2837 3409 3553 1626 3166 2914 2616 3821 3025 2568 2701 2817 3298 2774 3365 3392 ]';
%             data.tWw_f1(:,1) = data.tWw_f1(:,1) + 365 * 15; % 
            temp.tWw_f1 = C2K(17.8);  units.temp.tWw_f1 = 'K'; label.temp.tWw_f1 = 'temperature (K)'; %hatchery setting; temp is confident
          Ww0.tWw_f1 = 3205; units.Ww0.tWw_f1 = 'g'; label.Ww0.tWw_f1 = 'initial wet weight (g)'; %average initial wet weight
          units.tWw_f1 = {'d', 'g'};  label.tWw_f1 = {'time (d)', 'wet weight (g)'};   
          bibkey.tWw_f1 = 'Daigetal2023'; comment.tWw_f1 = 'this group was fasted for 4.5 months, beginning at day 0, f=0';
          
%fork length for f=0 (fasted) group 
data.tL_f1 = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 112 112 112 112 112 112 112 112 112 112 112 112 112 135 135 135 135 135 135 135 135 135 135 135 135 135; %this is is feeding group 1 (fasted)
               69.2 82 80.5 80.5 90.6 79.1 76.2 78.1 77.6 81.2 82.3 90.8 78.2 86.3 83.7 70.5 83.4 81.5 80.5 91.6 79.8 76.7 78.9 79.2 82 83.3 91.4 80 86.8 83.5 70.4 83 81.5 80.3 91.6 79.6 76.7 79.1 79.6 80.5 82.9 91 80 86.8 83.9 69.8 83.9 81 79.6 92.1 79.6 79.3 81.8 82.9 91.3 80 86.3 83.9 71.4 85.2 82.1 80 92.7 79.3 80.2 82.9 83.9 91 81.1 86.3 84.7 ]';
%             data.tL_f1(:,1) = data.tL_f1(:,1) + 365 * 15; % 
            temp.tL_f1 = C2K(17.8);  units.temp.tL_f1 = 'K'; label.temp.tL_f1 = 'temperature (K)'; %hatchery setting; temp is confident
%           Lw0.tL_f1 = 81.1; units.Lw0.tL_f1 = 'cm'; label.Lw0.tL_f1 = 'initial fork length (cm)'; %average initial fork length
          units.tL_f1 = {'d', 'cm'};  label.tL_f1 = {'time (d)', 'fork length (cm)'};   
          bibkey.tL_f1 = 'Daigetal2023'; comment.tL_f1 = 'forklength acquired using conversion from total length FL=(TL-47.59)/1.04';
          
%weight for f=X (medium ration) group 
data.tWw_f2 = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 112 112 112 112 112 112 112 112 112 112 112 112 112 112 112 135 135 135 135 135 135 135 135 135 135 135 135 135 135 135; %this is is feeding group 2 (medium ration)
                3973 2236 3903 4490 3593 2688 3884 2381 2745 3215 3315 2819 2725 3524 2845 4032 2440 4046 4683 3777 2800 4017 2455 2650 3250 3433 2809 2767 3778 2836 4013 2467 4064 4691 3810 2759 3957 2453 2520 3274 3501 2834 2819 3726 2712 3987 2490 4078 4757 3802 2770 4000 2461 2436 3254 3474 2861 2816 3715 2566 4114 2492 4061 4710 3803 2737 3949 2445 2408 3227 3473 2860 2831 3687 2425 ]';
%             data.tWw_f2(:,1) = data.tWw_f2(:,1) + 365 * 15; % 
            temp.tWw_f2 = C2K(17.8);  units.temp.tWw_f2 = 'K'; label.temp.tWw_f2 = 'temperature (K)'; %hatchery setting; temp is confident
          Ww0.tWw_f2 = 3222.4; units.Ww0.tWw_f2 = 'g'; label.Ww0.tWw_f2 = 'initial wet weight (g)'; %average initial wet weight
          units.tWw_f2 = {'d', 'g'};  label.tWw_f2 = {'time (d)', 'wet weight (g)'};   
          bibkey.tWw_f2 = 'Daigetal2023'; comment.tWw_f2 = 'fed same ration for 4.5 months, beginning at day 0, f= MED'; % play around with f values starting at f = 0.5 and move up or down to best fit data
          
%fork length for f=X (medium ration) group 
data.tL_f2 = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 35 35 35 35 35 35 35 35 35 35 35 35 35 77 77 77 77 77 77 77 77 77 77 77 77 77 77 77 112 112 112 112 112 112 112 112 112 112 112 112 112 112 112 135 135 135 135 135 135 135 135 135 135 135 135 135 135 135; %this is is feeding group 2 (medium ration)
               76.7 74.8 84.8 85.8 84.8 77.2 79.9 73.8 78.6 87.3 79.1 80 79.1 81.0 83.4 86.3 75.7 85.3 86.4 85.3 78.3 81.2 75.7 79.4 87.5 80.2 82 77.8 82.4 83.9 86.3 76.2 85.8 86.3 86.3 78.6 81 75.9 78.6 86.8 80.5 82.4 80 82.9 83.6 86.8 75.4 86 86.8 86.3 79.1 82 76.2 78.9 86.8 81 82.4 78.6 82.9 83.4 87.5 77.7 86.9 88.4 87.7 79.7 82.8 77.3 80 87.7 81.9 83.4 80.5 83.9 83.9]';
%             data.tL_f2(:,1) = data.tL_f2(:,1) + 365 * 15; % 
            temp.tL_f2 = C2K(17.8);  units.temp.tL_f2 = 'K'; label.temp.tL_f2 = 'temperature (K)'; %hatchery setting; temp is confident
%           Lw0.tL_f2 = 80.4; units.Lw0.tL_f2 = 'cm'; label.Lw0.tL_f2 = 'initial fork length (cm)'; %average initial fork length
          units.tL_f2 = {'d', 'cm'};  label.tL_f2 = {'time (d)', 'fork length (cm)'};   
          bibkey.tL_f2 = 'DaigDjok2023'; comment.tL_f2 = 'forklength acquired using conversion from total length FL=(TL-47.59)/1.04'; % play around with f values starting at f = 0.5 and move up or down to best fit data
%           
%weight for f=X (high ration) group  
data.tWw_f3 = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 35 35 35 35 35 35 35 35 35 35 35 35 77 77 77 77 77 77 77 77 77 77 77 77 77 77 112 112 112 112 112 112 112 112 112 112 112 112 112 112 135 135 135 135 135 135 135 135 135 135 135 135 135 135 ; %this is is feeding group 3 (high ration)
                4463 2521 3665 3317 2107 3972 3661 2145 3647 3354 3415 3719 2920 2775 4757 2665 3955 3551 2274 4219 3875 2181 3857 3650 3700 3976 3030 2959 5119 2772 4291 3663 2404 4011 4144 2318 4034 3975 3897 4197 3337 3104 5354 2866 4482 3821 2531 3830 4377 2413 4206 4167 4047 4441 3465 3325 5429 2880 4544 3839 2655 3710 4404 2387 4233 4237 4136 4494 3542 3375 ]';
%             data.tWw_f3(:,1) = data.tWw_f3(:,1) + 365 * 15; % 
            temp.tWw_f3 = C2K(17.8);  units.temp.tWw_f3 = 'K'; label.temp.tWw_f3 = 'temperature (K)'; %hatchery setting; temp is confident
          Ww0.tWw_f3 = 3262.9; units.Ww0.tWw_f3 = 'g'; label.Ww0.tWw_f3 = 'initial wet weight (g)'; %average initial wet weight
          units.tWw_f3 = {'d', 'g'};  label.tWw_f3 = {'time (d)', 'wet weight (g)'};   
          bibkey.tWw_f3 = 'DaigDjok2023'; comment.tWw_f3 = 'fed same ration for 4.5 months, beginning at day 0, f= HIGH'; % play around with f values starting at f = 0.5 and move up to best fit data
          
%fork length for f=X (high ration) group 
data.tL_f3 = [ 0 0 0 0 0 0 0 0 0 0 0 0 0 0 35 35 35 35 35 35 35 35 35 35 35 35 35 35 77 77 77 77 77 77 77 77 77 77 77 77 77 77 112 112 112 112 112 112 112 112 112 112 112 112 112 112 135 135 135 135 135 135 135 135 135 135 135 135 135 135 ; %this is is feeding group 3 (high ration)
               90.6 74.8 80.5 82.9 72.8 80.6 85.2 75.1 83.9 79.1 84.3 86 80 80.5 91.1 75.7 81 83.4 72.3 81.5 86.3 75.2 85.3 80.5 85.3 87.3 82.2 82 92.1 77.3 82.3 84.8 73.3 81.5 87.7 75.4 85.8 81.5 85.8 87.7 82.9 82.4 92.5 78.1 82 85.5 73.8 82 88.2 75.7 85.8 82 86.3 88 83.9 83.1 93 79.7 82.9 87.5 74.3 82.4 91 76.2 87.8 82.9 88.5 89.8 87 84.6 ]';          
%             data.tL_f3(:,1) = data.tL_f3(:,1) + 365 * 15; % 
            temp.tL_f3 = C2K(17.8);  units.temp.tL_f3 = 'K'; label.temp.tL_f3 = 'temperature (K)'; %hatchery setting; temp is confident
%           Lw0.tL_f3 = 81.2; units.Lw0.tL_f3 = 'cm'; label.Lw0.tL_f3 = 'initial fork length (cm)'; %average initial fork length
          units.tL_f3 = {'d', 'cm'};  label.tL_f3 = {'time (d)', 'fork length (cm)'};   
          bibkey.tL_f3 = ''; comment.tL_f3 = 'forklength acquired using conversion from total length FL=(TL-47.59)/1.04'; % play around with f values starting at f = 0.5 and move up to best fit data
          
          % i think we need to get the Lw0 and Ww0 bits working bc for the
          % fasted i think it thinks these are baby fish?????
          %even the fed datasets dont fit well at all - may need to give it
         %some info on the age/starting size?
%% set weights for all real data
weights = setweights(data, []);
weights.Wwi = 3 * weights.Wwi;        %this was orig set to 0 i set for 3
weights.tL = 5 * weights.tL;
weights.tWw_m = 5 * weights.tWw_m;
weights.tL_m = 5 * weights.tL_m;
weights.tWw = 5 * weights.tWw;
% weights.LW2 = 5 * weights.LW2;
weights.LW = 5 * weights.LW;
% weights.tWw_f1 = 5 * weights.tWw_f1
% weights.tL_f1 = 5 * weights.tL_f1
% weights.tWw_f2 = 5 * weights.tWw_f2
% weights.tL_f2 = 5 * weights.tL_f2
% weights.tWw_f3 = 5 * weights.tWw_f3
% weights.tL_f3 = 5 * weights.tL_f3
%% set pseudodata and respective weights
[data, units, label, weights] = addpseudodata(data, units, label, weights);
weights.psd.k_J = 0; weights.psd.k = 0.2;
data.psd.k = 0.3; units.psd.k  = '-'; label.psd.k  = 'maintenance ratio'; 

%% pack auxData and txtData for output
auxData.temp = temp;
auxData.Ww0 = Ww0; % add initial weights for DaigDjok2023
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;
txtData.comment = comment;

%% Group plots
set1 = {'tL','tL_m'}; comment1 = {'Data for females, males'};
set2 = {'tWw','tWw_m'}; comment2 = {'Data for females, males'};
% set3 = {'LW','LW2'}; comment3 = {'Data from KeenMax1993, ShumKlum2011'};
set3 = {'LW'}; comment3 = {'Data from KeenMax1993'};
set4 = {'tL_f1', 'tL_f2', 'tL_f3'}; comment4 = {'3 feeding groups'};
set5 = {'tWw_f1', 'tWw_f2', 'tWw_f3'}; comment5 = {'3 feeding groups'};

metaData.grp.sets = {set1,set2,set3, set4,set5};
metaData.grp.comment = {comment1,comment2,comment3,comment4,comment5};
%% Discussion points
D1 = 'Wwi = 130 kg was ignored, because of inconsistency with Li and LW data; probably includes gonads';
metaData.discussion = struct('D1', D1); 

%% Facts
F1 = 'The pallid sturgeon is the largest freshwater fish in North America';
metaData.bibkey.F1 = 'Wiki';
metaData.facts = struct('F1',F1);

%% Links
metaData.links.id_CoL = '7129d609c8439a24e475e3d8c1c3ec6f'; % Cat of Life
metaData.links.id_EoL = '205909'; % Ency of Life
metaData.links.id_Wiki = 'Scaphirhynchus_albus'; % Wikipedia
metaData.links.id_ADW = 'Scaphirhynchus_albus'; % ADW
metaData.links.id_Taxo = '42456'; % Taxonomicon
metaData.links.id_fishbase = 'Scaphirhynchus-albus'; % fishbase

%% References
bibkey = 'Wiki'; type = 'Misc'; bib = ...
'howpublished = {\url{https://en.wikipedia.org/wiki/Pallid_sturgeon}}';  
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'FishBase'; type = 'Misc'; bib = ...
'howpublished = {\url{https://www.fishbase.se/summary/2595}}';  
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
% 
bibkey = 'KeenMax1993'; type = 'Article'; bib = [ ...    
'author = {K. D. Keenlyne and S. J. Maxwell}, ' ...
'year  = {1993}, ' ...
'title = {Length Conversions and Length-Weight Relations for Pallid Sturgeon}, ' ...  
'journal = {North American Journal of Fisheries Management}, ' ...
'volume = {13}, ' ...
'number = {2}, ' ...
'doi = {10.1577/1548-8675(1993)013<0395:LCALWR>2.3.CO;2},' ...
'pages = {395--397}']; 
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
% 
bibkey = 'KeenJenk1993'; type = 'Article'; bib = [ ...    
'author = {K. D. Keenlyne and L. G. Jenkins}, ' ...
'year  = {1993}, ' ...
'title = {Age at Sexual Maturity of the Pallid Sturgeon}, ' ...  
'journal = {Transactions of the American Fisheries Society}, ' ...
'volume = {122}, ' ...
'number = {3}, ' ...
'doi = {10.1577/1548-8659(1993)122<0393:AASMOT>2.3.CO;2},' ...
'pages = {393--396}']; 
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
% 
bibkey = 'GeorSlac2012'; type = 'Article'; bib = [ ...    
'author = {S. G. George and W. T. Slack and J. J. Hoover}, ' ...
'year  = {2012}, ' ...
'title = {A note on the fecundity of pallid sturgeon}, ' ...  
'journal = {Journal of Applied Ichthyology}, ' ...
'volume = {}, ' ...
'number = {}, ' ...
'doi = {10.1111/j.1439-0426.2011.01931.x},' ...
'pages = {1--4}']; 
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
% bibkey = 'ShumKlum2011'; type = 'Article'; bib = [ ...    
% 'author = {D.A. Shuman and R.A. Klumb and R.H. Wilson and M.E. Jaeger and T. Haddix and W.M. Gardner and W.J. Doyle and P.T. Horner and M. Ruggles and K.D. Steffensen and S. Stukel and G.A. Wanner}, ' ...
% 'year  = {2011}, ' ...
% 'title = {Pallid sturgeon size structure, condition, and growth in the Missouri River Basin}, ' ...  
% 'journal = {Journal of Applied Ichthyology}, ' ...
% 'volume = {27}, ' ...
% 'number = {}, ' ...
% 'doi = {10.1111/j.1439-0426.2010.01645.x},' ...
% 'pages = {269--281}']; 
% metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'DaigDjok2023'; type = 'Article'; bib = [ ...    
'author = {N.J. Daigle and M.A. Djokic and K.M Kappenman and T.G. Gaylord and S. Quinn and C.E. Verhille}, ' ...
'year  = {2023}, ' ...
'title = {Validation of a microwave energy meter to non-lethally estimate energetic reserves in sturgeon}, ' ...  
'journal = {Conservation Physiology}, ' ...
'volume = {11}, ' ...
'number = {}, ' ...
'doi = {10.1093/conphys/coad023},' ...
'pages = {1--10}']; 
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

