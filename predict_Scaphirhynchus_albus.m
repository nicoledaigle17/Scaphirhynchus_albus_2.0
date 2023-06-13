function [prdData, info] = predict_Scaphirhynchus_albus(par, data, auxData)

  % unpack par, data, auxData
  cPar = parscomp_st(par); vars_pull(par); 
  vars_pull(cPar);  vars_pull(data);  vars_pull(auxData);
   

%% compute temperature correction factors
  TC_ab = tempcorr(temp.ab, T_ref, T_A);
  TC_tp = tempcorr(temp.tp, T_ref, T_A);
  TC_tpm = tempcorr(temp.tp_m, T_ref, T_A);
  TC_am = tempcorr(temp.am, T_ref, T_A);
  TC_Ri = tempcorr(temp.Ri, T_ref, T_A);
  TC_tW = tempcorr(temp.tWw, T_ref, T_A);
  TC_tW1 = tempcorr(temp.tWw_f3, T_ref, T_A); %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% changed from f1 to f3 for now
  
%   filterChecks = f1 < 0 ; 
%     
%   if filterChecks
%       info = 0; prdData = []; return
%   end

  % life cycle
  pars_tp = [g k l_T v_Hb v_Hp];
  [tau_p, tau_b, l_p, l_b, info] = get_tp(pars_tp, f);
  if info == 0; prdData = []; return; end 
  % birth
  L_b = L_m * l_b;                  % cm, structural length at birth of foetus  at f = 1
  Ww_b = L_b^3 * (1 + f * ome);     % g, wet weight at birth
  aT_b = tau_b/ k_M/ TC_ab;         % d, age at birth of foetus at f and T

  % puberty 
  tT_p = (tau_p - tau_b)/ k_M/ TC_tp; % d, time since birth at puberty at f and T

  % ultimate
  l_i = f - l_T;                    % -, scaled ultimate length
  L_i = L_m * l_i;                  % cm, ultimate structural length at f
  Lw_i = L_i/ del_M;                % cm, ultimate physical length at f
  Ww_i = L_i^3 * (1 + f * w);       % g, ultimate wet weight 

  % reproduction
  pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp]; % compose parameter vector
  RT_i = TC_Ri * reprod_rate(L_i, f, pars_R);             % #/d, ultimate reproduction rate at T

  % life span
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];  % compose parameter vector at T_ref
  t_m = get_tm_s(pars_tm, f, l_b);      % -, scaled mean life span at T_ref
  aT_m = t_m/ k_M/ TC_am;               % d, mean life span at T
  
  % males
  p_Am_m = z_m * p_M/ kap;             % J/d.cm^2, {p_Am} spec assimilation flux
  E_m_m = p_Am_m/ v;                   % J/cm^3, reserve capacity [E_m]
  g_m = E_G/ (kap* E_m_m);             % -, energy investment ratio
  m_Em_m = y_E_V * E_m_m/ E_G;         % mol/mol, reserve capacity 
  w_m = m_Em_m * w_E/ w_V;             % -, contribution of reserve to weight
  L_mm = v/ k_M/ g_m;                  % cm, max struct length
  L_im = f * L_mm; Lw_im = L_im/ del_M; % cm, ultimate length
  pars_tpm = [g_m k l_T v_Hb v_Hpm];
  [tau_pm, tau_bm] = get_tp(pars_tpm, f);
  tT_pm = (tau_pm - tau_bm)/ k_M/ TC_tpm;
  
  % pack to output
  prdData.ab = aT_b;
  prdData.tp = tT_p;
  prdData.tp_m = tT_pm;
  prdData.am = aT_m;
  prdData.Li = Lw_i;
  prdData.Wwb = Ww_b;
  prdData.Wwi = Ww_i;
  prdData.Ri = RT_i;

  %% uni-variate data
    
  % t-Ww-data
  rT_B = TC_tW * k_M/ 3/ (1 + f/ g); % 1/d, von Bert growth rate
  L    = L_i - (L_i - L_b) * exp(- rT_B * tWw(:,1)); % cm, structural length
  EWw  = L.^3 * (1 + f * w); % g, wet weight
  ELw  = L/ del_M; % cm, fork length
  %
  rT_Bm = TC_tW * k_M/ 3/ (1 + f/ g_m); % 1/d, von Bert growth rate
  L    = L_im - (L_im - L_b) * exp(- rT_Bm * tWw_m(:,1)); % cm, structural length
  EWw_m  = L.^3 * (1 + f * w_m); % g, wet weight
  ELw_m  = L/ del_M; % cm, total length 
  
  % length-weight data
  ELW  = (LW(:,1) * del_M).^3 * (1 + f * ome); % g, wet weight %the 'E' means expected
  %
  %ELW2  = (LW2(:,1) * del_M).^3 * (1 + f * ome); % g, wet weight %this was
  %for the shuman dataset which will eventually come out

  
%   % t-Ww-data for f1
%   [tau_p, tau_b, l_p, l_b, info] = get_tp(pars_tp, f1);
%   if info == 0; prdData = []; return; end  
%   L_i   = L_m * f1; L_b = L_m * l_b;
%   rT_B1 = TC_tW1 * k_M/ 3/ (1 + f1/ g); % 1/d, von Bert growth rate
%   L     = L_i - (L_i - L_b) * exp(- rT_B1 * (tWw_f1(:,1) - t_0)); % cm, structural length
%   EWw_f1  = L.^3 * (1 + f1 * w); % g, wet weight
%   ELw_f1  = L/ del_M; % cm, fork length %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% TC_tW1 stays the same bc all at same temp           
%   
%   % t-Ww-data for f2
%   rT_B2 = TC_tW1 * k_M/ 3/ (1 + f2/ g); % 1/d, von Bert growth rate
%   L    = L_i - (L_i - L_b) * exp(- rT_B2 * tWw_f2(:,1)); % cm, structural length
%   EWw_f2  = L.^3 * (1 + f2 * w); % g, wet weight
%   ELw_f2  = L/ del_M; % cm, fork length %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  % t-Ww-data for f3 
  rT_B3 = TC_tW1 * k_M/ 3/ (1 + f3/ g); % 1/d, von Bert growth rate
  L    = L_i - (L_i - L_b) * exp(- rT_B3 * tWw_f3(:,1)); % cm, structural length
  EWw_f3  = L.^3 * (1 + f3 * w); % g, wet weight
  ELw_f3  = L/ del_M; % cm, fork length %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 
 %%function to make f3 connect with rearing reserve (~f=0.8)
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   
  
  % pack to output
  prdData.tWw = EWw;
  prdData.tWw_m = EWw_m;
  prdData.tL = ELw;
  prdData.tL_m = ELw_m;
  prdData.LW = ELW;
%   prdData.tWw_f1 = EWw_f1;
%   prdData.tL_f1 = ELw_f1; 
%   prdData.tWw_f2 = EWw_f2;
%   prdData.tL_f2 = ELw_f2;
  prdData.tWw_f3 = EWw_f3;
  prdData.tL_f3 = ELw_f3;
  %prdData.LW2 = ELW2;
  
  %disp([ ' k_M: ' num2str(k_M)])
   
  
%     % uni-variate data
%   % time-energy content
%   tf = [0 f_00; 5 f_05; 10 f_10; 15 f_15];
%   [t, EL] = ode45(@get_EL, tW(:,1), [E_m, L_b], [], tf, v * TC, g, E_m, L_m, p_Am * TC); % EL: {J/cm^3, cm}, with {[E], L}
%   EWw = EL(:,2).^3 .* (1 + EL(:,1) * w_E/ mu_E/ d_E); % g, wet weight
%   %
%   tf = [0 f4_00; 5 f4_05; 10 f4_10; 15 f4_15];
%   [t, EL] = ode45(@get_EL, tW(:,1), [E_m, L_b], [], tf, v * TC, g, E_m, L_m, p_Am * TC); % EL: {J/cm^3, cm}, with {[E], L}
%   EWw_4 = EL(:,2).^3 .* (1 + EL(:,1) * w_E/ mu_E/ d_E); % g, wet weight

end

%  
%  function dEL = get_EL(t, EL, tf, v, g, E_m, L_m, p_Am)
%   E = EL(1); % J/cm^3, reserve density [E}
%   L = EL(2); % cm, structural length 
%   %need to tell it that at t-0 to t-365*15 f-0.8, then after f=0.8 
%   f = spline1(t, tf);                    % -, scaled functional response at t
%   dE = (f3 * p_Am - E * v)/ L;            % J/d.cm^3, change in reserve density d/dt [E]
%   e = E/ E_m;                            % -, scaled reserve density
%   r = v * (e/ L - 1/ L_m)/ (e + g);      % 1/d, specific growth rate
%   dL = L * r/ 3;                         % cm/d, change in structural length d/dt L
%   
%   dEL = [dE; dL]; % catenate for output
% end  

     