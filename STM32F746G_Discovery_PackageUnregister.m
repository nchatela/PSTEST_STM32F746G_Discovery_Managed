%

%   Copyright 2024 The MathWorks, Inc.

try
    prefs = STM32F746G_Discovery_Constant();
    %% 1: Toolchain
    target.remove("Toolchain", prefs.ToolChainName, 'IncludeAssociations', true);
    %% 2: Custom Target
    target.remove("TargetConnection", prefs.TargetConnectionName, 'IncludeAssociations', true);
catch
end

try
    %% remove path required here for ExecutionTool
    rmpath(fileparts(mfilename('fullpath')));
    if savepath(fullfile(userpath, 'pathdef.m'))
        warning('Error while saving path!');
    end
catch
end