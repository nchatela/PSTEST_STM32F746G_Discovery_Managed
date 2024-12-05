%

%   Copyright 2024 The MathWorks, Inc.

%% add path required here for ExecutionTool
addpath(fileparts(mfilename('fullpath')));

STM32F746G_Discovery_BoardDefinition();

STM32F746G_Discovery_ToolchainDefinition();

if savepath
    warning('Error while saving path!');
end


rehash toolboxcache;
