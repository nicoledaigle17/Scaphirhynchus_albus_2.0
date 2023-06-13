close all; 
global pets 

pets = {'Scaphirhynchus_albus'}; 
check_my_pet(pets); 

estim_options('default'); 
estim_options('max_step_number', 5e2);  
estim_options('max_fun_evals', 5e3); 
estim_options('pars_init_method', 1); %option 2 only uses the parameters you've given it - option 1 will tweak them if they are 'free'
estim_options('results_output', 3); 
estim_options('method', 'nm'); %nm goes through the steps (1-500 or 1-5000) of nelder-mead approx, you can input 'no' to skip

estim_pars; 

