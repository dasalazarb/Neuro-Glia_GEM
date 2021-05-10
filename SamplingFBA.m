%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% In this script we upload the model of Supplementary File 1
% and run the random sampling algorithm.
%---------------------------------------------------------------------

% Clean workspace variables
clear all, close all;

% Set the solver you are using, this can be differnt for you
% you see which solvers are available via the 
% initCobraToolbox call
% changeCobraSolver('glpk', 'all');
changeCobraSolver('gurobi5', 'all');

%% Read the file
model = xls2model("Neuron-Glia_GEM.xls")

%% Write as SBML model
str = "Supplementary file 1.xml"
writeCbToSBML(model, str);

%% objective functions
rxn_objfunc = {'g_ATPtm'; 'n_ATPtm'};

%% Prepare the model
model = readCbModel(str);
model = changeObjective(model, rxn_objfunc, 1);

%% Run the analysis
for i = [0,1]
	% set 0 or 1 the UB to ARSA rxn in glia and neuron
	model = changeRxnBounds(model, 'g_ARSA', i, 'u');
	model = changeRxnBounds(model, 'n_ARSA', i, 'u');
	
	%% RandomSampling
	[modelSampling,samples] = sampleCbModel(model,'superModelSamples');
	
	%% Save the results
    xlswrite('ARSA_fluxes_KO_vs_WT.xlsx', samples, 1, strcat('a', i+1));
end

%%----------------------------------------------------------------
