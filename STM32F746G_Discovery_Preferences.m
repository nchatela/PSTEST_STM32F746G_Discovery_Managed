classdef STM32F746G_Discovery_Preferences < pstest.target.TargetPreferences
    %

    %   Copyright 2024 The MathWorks, Inc.

    methods(Access=public)
        function this = STM32F746G_Discovery_Preferences(jsonName)
            arguments
                jsonName (1,1) string = "pstestPreferences.json"
            end
            jsonFullPath = fullfile(fileparts(which(mfilename)), jsonName);
            this@pstest.target.TargetPreferences(jsonFullPath);
        end
    end
end


