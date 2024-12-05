%

%   Copyright 2024 The MathWorks, Inc.

function tc = STM32F746G_Discovery_ToolchainDefinition(varargin)

    baseSoftDir = [strrep(fileparts(mfilename('fullpath')), '\','/') '/src'];
    prefs = STM32F746G_Discovery_Preferences();
    gnuARMPath = prefs.GnuARMPath;

    % Create the Toolchain
    tc = target.create("Toolchain", "Name", prefs.ToolChainName);
    tc.Builder = target.create("MakefileBuilder", "GMake");

    if ispc
        tc.HostOperatingSystemSupport = target.HostOperatingSystemSupport.WindowsOnly;
        exeExt = '.exe';
        hostKind = "Windows";
    else
        tc.HostOperatingSystemSupport = target.HostOperatingSystemSupport.LinuxOnly;
        exeExt = '';
        hostKind = "Unix";
    end

    basictools1 = target.get("Toolset", hostKind + " system tools for Makefiles");
    tc.Tools(end+1) = basictools1;
    maketool = target.create("BuildTool", "Make Tool", "gmake -j$(NUM_CORES)", ...
                            "Name", "GNU GMake");
    maketool.FileSep = '/';
    tc.Tools(end+1) = maketool;

    % Common flags to the C/C++ compiler, the linker and the assembler
    commonFlags = {
        '-mcpu=cortex-m7', ...
        '-mthumb', ...
        '-mfpu=fpv5-sp-d16', ...
        '-mfloat-abi=hard'
    };

    % flags that may be given to C and C++ Compilers
    tc.BuildRequirements.CompilerFlags = [commonFlags, {'-ffunction-sections', '-fdata-sections', '-Wall'}];

    % flags that may be given to C and C++ Linker
    tc.BuildRequirements.LinkerFlags = [commonFlags, {'-Wl,--gc-sections', ['-T"' baseSoftDir '/STM32F746NGHX_FLASH.ld"']}];

    % Create the C Compiler
    cCompiler = target.create("BuildTool", "C Compiler", ...
        [gnuARMPath '/bin/arm-none-eabi-gcc' exeExt], ...
        "Name", "GCC C Compiler | (STM32F7 Windows)");
    cCompiler.setDirective("CommandFile", "@");
    cCompiler.setDirective("Debug", "-g");
    cCompiler.setDirective("EnableOptimization", "-O3");
    cCompiler.setDirective("DisableOptimization", "-O0");
    cCompiler.setFileExtensions("Source", {'.c', '.C'});
    cCompiler.FileSep = '/';
    cCompiler.Command.Arguments = {'-std=gnu11'};
    tc.Tools(end+1) = cCompiler;

    % Create the C++ Compiler
    cxxCompiler = target.create("BuildTool", "C++ Compiler", ...
        [gnuARMPath '/bin/arm-none-eabi-g++' exeExt], ...
        "Name", "GCC C++ Compiler | (STM32F7 Windows)");
    cxxCompiler.setDirective("CommandFile", "@");
    cxxCompiler.setDirective("Debug", "-g");
    cxxCompiler.setDirective("EnableOptimization", "-O3");
    cxxCompiler.setDirective("DisableOptimization", "-O0");
    cxxCompiler.FileSep = '/';
    cxxCompiler.Command.Arguments = {'-std=gnu++14'};
    cxxCompiler.setFileExtensions("Source", {'.cpp', '.cxx', '.CPP', '.CXX'});
    tc.Tools(end+1) = cxxCompiler;

    % Create the Assembler
    % arm-none-eabi-as doesn't process preprocessor directives.
    % So using gcc compiler with '-x assembler-with-cpp' option to compile assembly files.
    assembler = target.create("BuildTool", "Assembler", ...
        [gnuARMPath '/bin/arm-none-eabi-gcc' exeExt], ...
        "Name", "GCC Assembler | (STM32F7 Windows)");
    assembler.setFileExtensions("Source", {'.s', '.S'});
    assembler.FileSep = '/';
    assembler.Command.Arguments = [commonFlags, {'-g3', '-c', '-x', 'assembler-with-cpp', '--specs=nano.specs'}];
    tc.Tools(end+1) = assembler;

    % Create the C Linker
    cLinker = target.create("BuildTool", "Linker", ...
        [gnuARMPath '/bin/arm-none-eabi-gcc' exeExt], ...
        "Name", "GCC Linker | (STM32F7 Windows)");
    cLinker.setDirective("LibraryGroup", '-Wl,--start-group', '-Wl,--end-group');
    cLinker.setDirective("CommandFile", "@");
    cLinker.setDirective("Debug", "-g");
    cLinker.setFileExtensions("Executable", {'.elf'});
    cLinker.FileSep = '/';
    tc.Tools(end+1) = cLinker;

    % Create the C++ Linker
    cxxLinker = target.create("BuildTool", "C++ Linker", ...
        [gnuARMPath '/bin/arm-none-eabi-g++' exeExt ' -Wl,--start-group -lc -lm -lstdc++ -lsupc++ -Wl,--end-group'], ...
        "Name", "GCC C++ Linker | (STM32F7 Windows)");
    cxxLinker.setDirective("LibraryGroup", "-o $(PRODUCT).elf -Wl,--start-group", "-Wl,--end-group");
    cxxLinker.setDirective("CommandFile", "@");
    cxxLinker.setDirective("Debug", "-g");
    cxxLinker.setFileExtensions("Executable", {'.elf'});
    cxxLinker.FileSep = '/';
    tc.Tools(end+1) = cxxLinker;

    % Create the Archiver
    ar = target.create("BuildTool", "Archiver", ...
                        [gnuARMPath '/bin/arm-none-eabi-ar' exeExt],...
                        "Name", "GCC Archiver |(STM32F7 Windows)");
    ar.setDirective("LibrarySearchPath", '');
    ar.setDirective("OutputFlag", '');
    ar.setFileExtensions("Object", {'.o'});
    ar.setFileExtensions("Static Library", {'.lib'});
    ar.FileSep = '/';
    ar.Command.Arguments = {'rcs'};
    tc.Tools(end+1) = ar;

    % Associate the ST processor to this tool-chain
    proc = target.get('Processor', 'Name', 'STM32F746NGH6', 'Manufacturer', 'ST');
    tc.SupportedHardware = target.create('HardwareComponentSupport', 'Component', proc);

    % Register the tool-chain in the internal repository
    target.add(tc, "UserInstall", true, "SuppressOutput", false);
    end

