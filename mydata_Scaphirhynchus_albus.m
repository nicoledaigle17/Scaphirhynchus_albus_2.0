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
metaData.address   = {'Akvtplan-niva, FRAM, Tromso, Norway'};      

metaData.curator     = {'Bas Kooijman'};
metaData.email_cur   = {'bas.kooijman@vu.nl'}; 
metaData.date_acc    = [2020 06 23]; 

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
data.Wwi = 130e3;    units.Wwi = 'g';   label.Wwi = 'ultimate wet weight';   bibkey.Wwi = 'FishBase';

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
   
data.LW2 = [ ... % fork length (mm), wet weight (g), from Shuman's regression
200	  20.9726
300	  79.7179
400	  205.591
500	  428.695
600	  781.462
700	  1298.31
800	  2015.38
900	  2970.38
1000  4202.43
1100  5751.94
1200  7660.55
1300  9970.99
1400  12727.1
1500  15973.6
1600  19756.4];
data.LW2(:,1) = data.LW2(:,1)/10; % convert mm to cm
 units.LW2 = {'cm', 'g'};     label.LW2 = {'fork length', 'wet weight'};  bibkey.LW2 = 'Shumanetal2011';
   temp.LW2 = C2K(13);  units.temp.LW2 = 'K'; label.temp.LW2 = 'temperature'; comment.LW2 = 'temp is guessed (metadata from field collections)';
  
%% set weights for all real data
weights = setweights(data, []);
weights.Wwi = 0 * weights.Wwi;
weights.tL = 5 * weights.tL;
weights.tWw_m = 5 * weights.tWw_m;
weights.tL_m = 5 * weights.tL_m;
weights.tWw = 5 * weights.tWw;
weights.LW2 = 5 * weights.LW2;
weights.LW = 5 * weights.LW;

%% set pseudodata and respective weights
[data, units, label, weights] = addpseudodata(data, units, label, weights);
weights.psd.k_J = 0; weights.psd.k = 0.2;
data.psd.k = 0.3; units.psd.k  = '-'; label.psd.k  = 'maintenance ratio'; 

%% pack auxData and txtData for output
auxData.temp = temp;
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;
txtData.comment = comment;

%% Group plots
set1 = {'tL','tL_m'}; comment1 = {'Data for females, males'};
set2 = {'tWw','tWw_m'}; comment2 = {'Data for females, males'};
set3 = {'LW','LW2'}; comment3 = {'Data from KeenMax1993, Shumanetal2011'};
metaData.grp.sets = {set1,set2,set3};
metaData.grp.comment = {comment1,comment2,comment3};
%% Discussion points
D1 = 'Wwi = 130 kg was ignored, becasue of inconsistency with Li and LW data; probably includes gonads';
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
bibkey = 'Shumanetal2011'; type = 'Article'; bib = [ ...    
'author = {D.A. Shuman and R.A. Klumb and R.H. Wilson and M.E. Jaeger and T. Haddix and W.M. Gardner and W.J. Doyle and P.T. Horner and M. Ruggles and K.D. Steffensen and S. Stukel and G.A. Wanner}, ' ...
'year  = {2011}, ' ...
'title = {Pallid sturgeon size structure, condition, and growth in the Missouri River Basin}, ' ...  
'journal = {Journal of Applied Ichthyology}, ' ...
'volume = {27}, ' ...
'number = {}, ' ...
'doi = {10.1111/j.1439-0426.2010.01645.x},' ...
'pages = {269--281}']; 
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
