%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                 %
%       % Run DEB model %         %
%    % R. Lavaud 28/04/2019 %     %
% % N. Daigle Edited 24/11/2021 % %
%    % Pallid sturgeon model %    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% READ ME FIRST
% I am using Romain's T_AL, T_AH and X_K, T and X right now to see if the
% code will run with the changes I made (need to correct these above-mentioned values)
clc
clear variables
%% Parameters
 % Temperature correction parameters
T_ref = 293;              %  1 K, reference temperature
T_L   = 263;              %  2 K, lower boundary tolerance range (from Wise et al. 2017)
T_H   = 308;              %  3 K, upper boundary tolerance range (max from Chipps et al. 2008)
T_A   = 8000;             %  4 K, Arrehnius temperature
T_AL  = 45430;            %  5 K, Arrehnius temperature at lower boundary of tolerance range
T_AH  = 31376;            %  6 K, Arrehnius temperature at upper boundary of tolerance range

 % Primary parameters (Pallid sturgeon; taken from html file)
v         = 0.2697;       %  7 cm/d,     energy conductance
kap       = 0.7744;       %  8 -,        allocation fraction to soma
kap_X     = 0.8;          %  9 -,        assimilation efficiency
kap_X_P   = 0.1;          % 10 -,        defecation efficiency
kap_R     = 0.95;         % 11 -,        reproduction efficiency
p_M       = 6.052;        % 12 J/d/cm^3, volume-specific somatic maintenance rate
k_J       = 0.0003479;    % 13 1/d,      maturity maintenance rate coefficient
E_G       = 5420;         % 14 J/cm^3,   volume-specific cost for structure
E_Hp      = 3356000;      % 15 J,        maturity at puberty 
del_M     = 0.1625;       % 16 -,        shape coefficient

 % Additional parameters 
X_K       = 70000;        % 17 ug/L, half-saturation coefficient ; messing with this to get accurate growth
z         = 26.12;        % 18 -,        zoom factor
%k_M       = 0.0012;      % 19 1/d,      somatic maintenance rate coefficient %calculated in DEB estimation files
p_Am      = z * p_M/ kap; % 20 J/d/cm^2, calculating maximum surface-specific assimilation rate

 % Chemical conversion coefficients parameters
%      CO2 H2O O2 NH3
n_M  = [1   0   0  0;     % C/C
        0   2   0  3;     % H/C
        2   1   2  0;     % O/C
        0   0   0  1];    % N/C
%        X     V     E     P
n_O  = [1.00 1.00 1.00 1.00;  % C/C
        1.80 1.80 1.80 1.80;  % H/C
        0.50 0.50 0.50 0.50;  % O/C
        0.15 0.15 0.15 0.15]; % N/C
d_O  = [0.19 0.19 0.19 0.19]';      % g/cm^3, specific densities for organics
w_O  = n_O' * [12; 1; 16; 14];      % g/mol,  molecular weights for organics
mu_O = [525  500  516  480]' * 1e3; % J/mol,  chemical potentials for organics
dwm  = [d_O, w_O, mu_O];

d_V = dwm(2,1); w_V = dwm(2,2); w_E = dwm(3,2); mu_X = dwm(1,3); mu_E = dwm(3,3); mu_P = dwm(4,3); %trying this

 % Compound parameters
E_m = p_Am / v;                     % J/cm^3, maximum reserve density
g   = E_G / (kap * E_m);            % -,      energy investment ratio
k_M = p_M / E_G;                    % 1/d,    somatic maintenance rate

 % eta_O matrix for mass-energy coupling
eta_XA = 1 / (kap_X * mu_X);        % mol/J, food-assimilation energy coupler
eta_PA = kap_X_P / mu_P / kap_X;    % mol/J, faeces-assimilation energy coupler
eta_VG = d_V / w_V / E_G;           % mol/J, structure-growth energy coupler
 %        A       D       G
eta_O = [-eta_XA 0       0;       % X
         0       0       eta_VG;  % V
         1/mu_E  -1/mu_E -1/mu_E; % E
         eta_PA  0  0]; % P
%% Pack parameters %might need this
% pars = [T_ref T_L T_H T_A T_AL T_AH v kap kap_X kap_X_P kap_R p_M k_J E_G E_Hp del_M X_K z p_Am];
%% Initial conditions
Li   = 1.93;                 % cm,   initial physical length; trying post-hatch length
Vi   = (Li * del_M)^3;       % cm^3, initial structural volume
ei   = 0.8;                  % -,    initial scaled reserve e = [E] / [E_m] = E / V / [E_m]
Ei   = ei * p_Am / v * Vi;   % J,    initial reserve
E_Hi = 0;                    % J,    initial maturity; NJD changed to 0
E_Ri = 0;                    % J,    initial reproduction buffer
condini = [Vi Ei E_Hi E_Ri]; % pack initial conditions

%% Simulation parameters
dt     = 1;    % d, time step
Ti     = 1;    % d, start 
Tf     = 7300; % d, end, 20 y
tT     = (Ti:dt:Tf);
parsim = [Ti Tf dt];

%% Environmental conditions %may need to alter temp and food conc
T = repmat(12.78,Tf,1);  % °C,   temperature
%f = repmat(0.9,Tf,1); % constant food at f=0.9, could write function in here to vary f
f =  [1:7300;ones(1,3650), zeros(1,200), ones(1,3450)]'; % days %this is to vary f - if you want it constant comment this and use the above one instead
 % functional response
%replace with f here
%instead of indicating x, could create own f function
env = [T f]; %also replace with f         

%% Run the model
%Results = rundeb_std(pars, dwm, parsim, condini, env);

     % Set initial conditions
V   = condini(1);                         % cm^3, initial structural volume
E   = condini(2);                         % J,    initial reserves
E_H = condini(3);                         % J,    initial maturity
E_R = condini(4);                         % J,    initial reproduction buffer
DW  = V * d_V + ((E + E_R) * w_E / mu_E); % g,    initial body dry weight

 % Initate simulation
%time = Ti; % d, set initial time

%% Integration %moved up stock state variables and integration and differential
Ti   = 1; % d, initial time
Timet = Ti + dt;  %0 changed time to Ti

for j=1:Tf % beginning of the integration loop
    
      % Current environmental conditions
  T = env(j,1) + 273.15; % K,    current temperature
  f = env(j,2);          %  current food conditions
 % f = f / (f + X_K);     % -,    functional response
%replace with f=1, 0.9, 0.8

      % Compute length and weight
  L   = V^(1/3);                            % cm, structural length
  L_w = L / del_M;                          % cm, physical length
  WW  = V + ((E + E_R) * w_E / mu_E);       % g,  body wet weight
  DW  = V * d_V + ((E + E_R) * w_E / mu_E); % g,  body dry weight
  
       % Temperature correction %moved this up as test
  TC = exp(T_A / T_ref - T_A / T) * (1 + exp(T_AL / T_ref - T_AL / T_L) + exp(T_AH / T_H - T_AH / T_ref)) ...
       * 1 / (1 + exp(T_AL / T - T_AL / T_L) + exp(T_AH / T_H - T_AH / T));
  p_AmT = p_Am * TC; % J/d/cm^2, maximum surface-specific assimilation rate at T
  p_MT  = p_M * TC;  % J/d/cm^3, volume-specific somatic maintenance rate at T
  vT    = v * TC;    % cm/d,     energy conductance at T
  k_MT  = k_M * TC;  % 1/d,      somatic maintenance rate coefficient at T
  k_JT  = k_J * TC;  % 1/d,      maturity maintenance rate coefficient at T

      % Allocation fluxes
  e   = E / V / E_m;                                         % -,   scaled reserve density
  p_A = p_AmT * f * V^(2/3);                                 % J/d, assimilation flux
  p_C = E_m * (vT * V^(2/3) + k_MT * V) * (e * g) / (e + g); % J/d, mobilisation flux
  p_S = p_MT * V;                                            % J/d, somatic maintenance flux
  p_G = max(0,kap * p_C - p_S);                              % J/d, growth flux
  p_J = E_H * k_JT;                                          % J/d, maturity maintenance flux
  if E_H < E_Hp
     p_H = max(0,(1 - kap) * p_C - p_J);                     % J/d, maturation flux
     p_R = 0;                                                % J/d, reproduction buffer flux
  else
     p_H = 0;                                                % J/d, maturation flux
     p_R = max(0,(1 - kap) * p_C - p_J) * kap_R;             % J/d, reproduction buffer flux
  end
  p_D = p_S + p_J + p_H + (1 - kap_R) * p_R;                 % J/d, dissipation flux
  
    % Mineral fluxes from scaled powers
  pADGs = [p_A, p_D, p_G];                  % J/d,       powers
  J_M   = (-n_M \ n_O) * eta_O * pADGs';    % mol/d,     J_C, J_H, J_O, J_N in rows
  J_OmL = -J_M(3,:)' * 22.4e3 / 24 / DW;    % mLO2/h/g,  O2 consumption (22.4 L/mol) % is this param 24 - should this change to 23?
  J_Omg = -J_M(3,:)' * 32e3 / 24 / DW;      % mgO2/h/g,  O2 consumption (32 g/mol)
  J_N   = J_M(4,:)' * 18e6 / 24 / DW;       % µgNH4/h/g, NH4 production (18 g/mol)
  
%      % Temperature correction
%   TC = exp(T_A / T_ref - T_A / T) * (1 + exp(T_AL / T_ref - T_AL / T_L) + exp(T_AH / T_H - T_AH / T_ref)) ...
%        * 1 / (1 + exp(T_AL / T - T_AL / T_L) + exp(T_AH / T_H - T_AH / T));
%   p_AmT = p_Am * TC; % J/d/cm^2, maximum surface-specific assimilation rate at T
%   p_MT  = p_M * TC;  % J/d/cm^3, volume-specific somatic maintenance rate at T
%   vT    = v * TC;    % cm/d,     energy conductance at T
%   k_MT  = k_M * TC;  % 1/d,      somatic maintenance rate coefficient at T
%   k_JT  = k_J * TC;  % 1/d,      maturity maintenance rate coefficient at T
    %% Stock state variables before integration
  Timet(j) = Timet;   %  1 %changed from time
  Tt(j)    = T;      %  2 
  Xt(j)    = f;      %  3
  TCt(j)   = TC;     %  4
  ft(j)    = f;      %  5
  Vt(j)    = V;      %  6
  Et(j)    = E;      %  7
  E_Ht(j)  = E_H;    %  8
  E_Rt(j)  = E_R;    %  9
  L_wt(j)  = L_w;    % 10
  WWt(j)   = WW;     % 11
  DWt(j)   = DW;     % 12
  pAt(j)   = p_A;    % 13
  pCt(j)   = p_C;    % 14
  pSt(j)   = p_S;    % 15
  pGt(j)   = p_G;    % 16
  pJt(j)   = p_J;    % 17
  pHt(j)   = p_H;    % 18
  pRt(j)   = p_R;    % 19
  pDt(j)   = p_D;    % 20
  JOmLt(j) = J_OmL;  % 21
  JOmgt(j) = J_Omg;  % 22
  JNt(j)   = J_N;    % 23
  
    % Differential equations of state variables
  dVdt   = p_G / E_G;
  dEdt   = p_A - p_C;
  dE_Hdt = p_H;
  dE_Rdt = p_R;

    % Integration
  V    = max(0,V + dVdt * dt);     % structure
  E    = max(0,E + dEdt * dt);     % reserves
  E_H  = max(0,E_H + dE_Hdt * dt); % maturity
  E_R  = max(0,E_R + dE_Rdt * dt); % reproduction buffer
  Timet = Ti + dt;
  
%       % Differential equations of state variables
%   dVdt   = p_G / E_G;
%   dEdt   = p_A - p_C;
%   dE_Hdt = p_H;
%   dE_Rdt = p_R;
end % End of the integration loop

%% Pack OUTPUT
%Output = [Timet' tT' Xt' TCt' ft' Vt' Et' E_Ht' E_Rt' L_wt' WWt' DWt' ...
    %      pAt' pCt' pSt' pGt' pJt' pHt' pRt' pDt' JOmLt' JOmgt' JNt'];

    
%% Plots
figure(1)
x = tT; y = WWt;
plot(x,y)
%xlim([0,15000]), ylim([0,20000]); %add amount of time in age to x-axis when doing hatchery sims
xlabel('time (days)'); ylabel('body wet weight (grams)')

figure(2)
x2 = tT; y2 = E_Ht;
plot(x2,y2)
%xlim([0,15000]), ylim([0,4000000]);
xlabel('time (days)'); ylabel('maturity (J)')

figure(3)
x3 = tT; y3 = L_wt;
plot(x3,y3)
%xlim([0,15000]), ylim([0,200]);
xlabel('time (days)'); ylabel('physical length (cm)')

figure(4)
plot(pAt,'DisplayName','pAt');hold on;plot(pCt,'DisplayName','pCt');plot(pDt,'DisplayName','pDt');plot(pGt,'DisplayName','pGt');plot(pHt,'DisplayName','pHt');plot(pJt,'DisplayName','pJt');plot(pRt,'DisplayName','pRt');plot(pSt,'DisplayName','pSt');hold off;

figure(5)
x = L_wt; y = WWt; z = tT;
scatter3(x,y,z)
%xlim([0,150]), ylim([0,15000]); zlim([0,15000]);
xlabel('physical length (cm)'); ylabel('body wet weight (grams)'); zlabel('time (days)')

