# Project-Based Workflow for Running C/C++ Tests and Collecting Coverage on STM32 Discovery Board Using Polyspace Test

## Introduction

This demo contains target registration files to register an STM32F746G Discovery board with Polyspace Test. After using the files to register this target, you will be able to:

- Build tests in a [Polyspace Platform](https://www.mathworks.com/help/polyspace_test/ug/what-is-polyspace-platform.html) project using the GNU ARM toolchain for ARM Cortex-M processor families.
- Run tests on the registered target board and review test results
- Compute code coverage after running the tests on the target board

This demo shows the workflow for running tests on a target board using a Polyspace Platform project (in the Polyspace Platform user interface or at the command line). If you are used to authoring and running tests from within the STM32Cube IDE, see [Running C/C++ Tests and Collecting Coverage on STM32 Discovery Board](https://www.mathworks.com/matlabcentral/fileexchange/161941-pstest_stm32f746g_discovery_unmanaged).

## Prerequisites

To register the target using the files in this repository, you need the following:

- [GNU ARM Compiler](https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-win32.zip): Extract the GNU ARM compiler files into a folder that does not contain spaces. For instance, avoid a subfolder of `C:\Program Files`.
- [STM32CubeProgrammer](https://www.st.com/en/development-tools/stm32cubeprog.html): Install the STM32Programmer tool.
- [STM32CubeF7](https://github.com/STMicroelectronics/STM32CubeF7): Clone the STM32CubeF7 Git repository. For instance, you can enter the following at the command line:
```
git clone --recursive https://github.com/STMicroelectronics/STM32CubeF7.git
```

## Download Demo and Configure Paths

The target registration files contain some information that is specific to the end user. Make sure you adapt this information to your installations *before registering your target*. If you forget to make the changes before registering your target, you can unregister the target, make the changes, and re-register the target.

1. Download the demo and extract into a folder `pstest_custom_target_tutorial`.
2. Edit the paths in `pstestPreferences.json` to point to your installation folders:
- `ProgrammerPath`: Enter the full path to the STM32Programmer executable, `STM32_Programmer_CLI.exe`.
- `GnuARMPath`: Enter the full path to the GNU ARM compiler compiler installation. This folder is the one where you extracted the GNU ARM compiler files in the Prerequisites section. The folder contains subfolders such as `arm-none-eabi`, `bin`, `include`, `lib`, and `share`.
- `STM32CubeF7Path`: Enter the full path to the STM32 Cube F7 Git repository cloned in the Prerequisites section.
- `ComPort`: Enter the STLink Virtual communication port, for instance, `COM4`. In Windows, you can find the communication port by going to Device Manager and looking under **Ports**.


## Register Target
After configuring paths, you can register the target in the user interface or from the command line. 

### Polyspace Platform User Interface

To register the target in the Polyspace Platform user interface:
1. Open a project configuration. You can use any project including the project in the folder `pstest_custom_target_tutorial\ex`.
2. On the **Build** tab, click the gear icon next to **Target board name**.
3. On the **Manage Boards** window, select **Register a target**.
4. Navigate to the folder `pstest_custom_target_tutorial` and select the file `STM32F746G_Discovery_PackageRegister.m`.

To unregister the target:
1. Open a project configuration.
2. On the **Build** tab, click the gear icon next to **Target board name (Testing)**.
3. On the **Manage Boards** window, select **Unregister a target**.
4. Navigate to the folder `pstest_custom_target_tutorial` and select the file `STM32F746G_Discovery_UnPackageRegister.m`.

### Command line
You can also register and unregister the target at the command-line.

To register the target, at the command line, enter:
```
<pstest_install_root>/polyspace/bin/polyspace-test.exe -manage-target-package -register-from-file <target_install_root>/STM32F746G_Discovery_PackageRegister.m
```

To unregister the target, at the command line, enter:
```
<pstest_install_root>/polyspace/bin/polyspace-test.exe -manage-target-package -unregister-from-file <target_install_root>/STM32F746G_Discovery_PackageUnregister.m
```
Here:
- `<pstest_install_root>` is the Polyspace installation folder.
- `<target_install_root>` is the path to the folder `pstest_custom_target_tutorial`.

## Select Target for Building and Running tests
After you register the target, you can select this target for building and running the tests.

### User Interface

Select the previously registered target in your project configuration.
1. Open your project configuration. You can use any project including the project in the folder `pstest_custom_target_tutorial\ex`.
2. On the **Build** tab, from the dropdown for **Target board name (Testing)**, select `STM32F746G_Custom_Target`.
3. You should see the following selections for these options:
- **Processor**: `ST-STM32F746NGH6`. You cannot change the processor. To see the processor characteristics, click the gear icon next to the dropdown
- **Compilation toolchain (Testing)**: `GCC ARM Cortex M | STM32F746G`. You can pick a different compilation toolchain if available.

When you build a project and run tests, the build and run uses the target that you selected in the project configuration.


### Command line

To build a project with the registered target board and toolchain, at the command line, enter:

```
<pstest_install_root>/polyspace/bin/polyspace-test.exe -build -project <project> -board STM32F746G_Custom_Target - toolchain "GCC ARM Cortex M | STM32F746G"
```

To run tests in a project with the registered target board and toolchain, at the command line, enter:

```
<pstest_install_root>/polyspace/bin/polyspace-test.exe -run -project <project> -board STM32F746G_Custom_Target - toolchain "GCC ARM Cortex M | STM32F746G"
```