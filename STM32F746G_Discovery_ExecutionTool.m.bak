%

%   Copyright 2024 The MathWorks, Inc.

classdef STM32F746G_Discovery_ExecutionTool < target.ExecutionTool
    % STM32F746G_Discovery_ExecutionTool programs the software to the target
    methods
        % Start executing the application on the target.
        function errFlag = startApplication(this)
            csts = STM32F746G_Discovery_Constant();
            binFullPath = char(this.Application);

            [~,name,ext] = fileparts(binFullPath);
            disp(['Programming ' name ext]);

            cwd = ['"' csts.ProgrammerPath '" --connect port=swd --erase all --download "' binFullPath '" --go'];
            [status, cmdout] = system(cwd);

            if status ~= 0
                error(cmdout);
                errFlag = true;
            else
                disp('Programming successfull !');
                errFlag = false;
            end
        end
    end

end