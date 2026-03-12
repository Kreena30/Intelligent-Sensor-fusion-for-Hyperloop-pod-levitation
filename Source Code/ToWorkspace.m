% Name of your Simulink model
modelName = 'Hyperloop_Levitation_System';

% Run the simulation and capture output (assumes Single simulation output enabled)
simOut = sim(modelName);

% List all logged variables (variable names specified in To Workspace blocks)
toWorkspaceVarNames = {'gapWS', 'GapEstWS', 'forceWS'};  % Modify to your variable names

% Extract logged data variables to base workspace
for i = 1:length(toWorkspaceVarNames)
    varName = toWorkspaceVarNames{i};
    if isprop(simOut, varName)
        data = simOut.(varName);
        assignin('base', varName, data);
        fprintf('Variable "%s" saved to base workspace.\n', varName);
    else
        warning('Variable "%s" not found in simulation output.\n', varName);
    end
end
