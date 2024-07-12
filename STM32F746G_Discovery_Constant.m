%

%   Copyright 2024 The MathWorks, Inc.
	
classdef STM32F746G_Discovery_Constant < dynamicprops

    properties (Constant)
        PrefsFile = fullfile(fileparts(which(mfilename)), 'STM32F746GPrefs.json')
    end

    methods
        function this = STM32F746G_Discovery_Constant()
            try
                jsonStr = fileread(this.PrefsFile);
                jsonStruct = jsondecode(jsonStr);
            catch Me
                error('pstest:utils:TargetJsonError', 'Unexpected error when reading ''%s'':\n%s\n',...
                    this.PrefsFile, Me.message);
            end
            keys = fieldnames(jsonStruct);
            for ii = 1:numel(keys)
                this.addprop(keys{ii});
                this.(keys{ii}) = jsonStruct.(keys{ii});
            end
        end
    end
end

