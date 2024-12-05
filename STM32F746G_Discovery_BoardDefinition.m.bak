%

%   Copyright 2024 The MathWorks, Inc.
	
function [connection, stm32F746gDiscoveryBoard] = STM32F746G_Discovery_BoardDefinition(varargin)

prefs = STM32F746G_Discovery_Constant();

processor = target.create("Processor", ...
                            "Name", "STM32F746NGH6", ...
                            "Manufacturer", 'ST');

% Add Language Implementation
langImpl = target.create("LanguageImplementation",...
    "Name", "ARM Cortex-M Compatible", ...
    "Copy", "GNU GCC ARM 32-bit");
processor.LanguageImplementations = langImpl;

% Add specific execution profiling part
timer = target.create("Timer", "Name", "STM32 Timer", ...
    "FunctionName", "getTimerCounter", ...
    "FunctionReturnType", "uint32", ...
    "FunctionLanguage", target.Language.C, ...
    "IncludeFiles", {'STM32F746G_Discovery_board.h'});

processor.Timers = timer;

stm32F746gDiscoveryBoard = target.create("Board", "Name", prefs.BoardName);

% Assign processor
stm32F746gDiscoveryBoard.Processors = processor;

% Add the deployment and execution information for the target

% Associate STM32F746G_Discovery_ExecutionTool
buildDeps = target.create("MATLABDependencies", ...
    "Classes", "STM32F746G_Discovery_ExecutionTool");

% API Implementation
api = target.get("API", "ExecutionTool");
customExecutionService = target.create("APIImplementation", ...
    "Name", "STLink V2 VCP - Execution Tool", ...
    "API", api, ...
    "BuildDependencies", buildDeps);

% Execution Service
executionTool = target.create("ExecutionService", ...
    "Name", "STLink V2 VCP  - Target Process Execution", ...
    "APIImplementation", customExecutionService);
stm32F746gDiscoveryBoard.Tools.ExecutionTools = executionTool;

% Create the communication interface for the target
comms = target.create("CommunicationInterface");

comms.Name = "STLink V2 VCP - Communication Interface";
comms.Channel = "RS232Channel";
comms.APIImplementations = target.create("APIImplementation", ...
    "Name", "STLink V2 VCP - APIImplementation");
comms.APIImplementations.API = target.get("API", "rtiostream");
comms.APIImplementations.BuildDependencies = target.create("BuildDependencies");

%for makefile,
% - path must be short (! limit of 255 !)
% - the separator must be "/" (to make it work in a option file)

cubeF7Dir = prefs.STM32CubeF7Path;

cubeF7HalDir = [cubeF7Dir, '/Drivers/STM32F7xx_HAL_Driver/Src'];
baseSoftDir = [strrep(fileparts(mfilename('fullpath')), '\','/') '/src'];
comms.APIImplementations.BuildDependencies.SourceFiles = { ...
    [baseSoftDir, '/startup_stm32f746nghx.s'], ...
    [baseSoftDir, '/STM32F746G_Discovery_board.c'] ...
    [baseSoftDir, '/STM32F746G_Discovery_serial.c'] ...
    [baseSoftDir, '/syscalls.c'] ...
    [baseSoftDir, '/sysmem.c'] ...
    [cubeF7Dir, '/Projects/STM32746G-Discovery/Templates/Src/system_stm32f7xx.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_cortex.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_dma.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_exti.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_flash.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_gpio.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_pwr.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_rcc.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_rcc_ex.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_tim.c'] ...
    [cubeF7HalDir, '/stm32f7xx_hal_uart.c'] ...
};
comms.APIImplementations.BuildDependencies.IncludePaths = ...
{
    [cubeF7Dir, '/Drivers/STM32F7xx_HAL_Driver/Inc'] ...
    [cubeF7Dir, '/Drivers/CMSIS/Device/ST/STM32F7xx/Include'], ...
    [cubeF7Dir, '/Drivers/CMSIS/Include'], ...
    baseSoftDir
};

comms.APIImplementations.BuildDependencies.Defines = ...
{
    'STM32F746xx', 'USE_HAL_DRIVER'
};

mainFunction = target.create("MainFunction", "Name", "Test Main");
mainFunction.IncludeFiles = {'STM32F746G_Discovery_board.h'};
mainFunction.InitializationCode = sprintf('initSTM32F746GDiscovery();\n');
stm32F746gDiscoveryBoard.MainFunctions = mainFunction;

stm32F746gDiscoveryBoard.CommunicationInterfaces = comms;

% Specify target specific PIL protocol information
pilProtocol = target.create("PILProtocol");
pilProtocol.Name = "STM32F746G-Discovery - PIL Protocol";
pilProtocol.ReceiveTimeout = 30;
pilProtocol.OpenTimeout = 30;
stm32F746gDiscoveryBoard.CommunicationProtocolStacks = pilProtocol;

% Add a connection to the target
% Define how the host connects to the target
connection = target.create("TargetConnection");
connection.Name = prefs.TargetConnectionName;
connection.CommunicationChannel = target.create("RS232Channel");
connection.CommunicationChannel.Name = "STLink V2 VCP - RS232Channel";
connection.CommunicationChannel.BaudRate = 115200;
connection.ConnectionProperties = target.create("Port",PortNumber=prefs.ComPort);
connection.Target = stm32F746gDiscoveryBoard;


target.add(connection, "UserInstall", true,  "SuppressOutput", false);

end

