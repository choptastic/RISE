; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

#include ReadReg(HKEY_LOCAL_MACHINE,'Software\Sherlock Software\InnoTools\Downloader','ScriptPath','') 

#define MyAppName "RISE"
#define MyAppVersion "0.1.1"
#define MyAppPublisher "Sovereign Prime"
#define MyAppURL "http://souvereignprime.com/"
#define MyAppExeName "rise.exe"

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{25DE33E6-557A-4275-94A8-6FD06F51A804}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
;AppVerName={#MyAppName} {#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}
AppUpdatesURL={#MyAppURL}
DefaultDirName={pf}\{#MyAppName}
DefaultGroupName={#MyAppName}
LicenseFile=C:\RISE\LICENSE
OutputDir=C:\RISE\rel\Release
OutputBaseFilename={#MyAppName}_{#MyAppVersion}
Compression=lzma
SolidCompression=yes

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked
Name: "quicklaunchicon"; Description: "{cm:CreateQuickLaunchIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked; OnlyBelowVersion: 0,6.1

[Files]
Source: "C:\RISE\rel\rise\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "C:\Qt\5.3\mingw482_32\plugins\platforms\*"; DestDir: "{app}\bin\platforms"; Flags: recursesubdirs
Source: "C:\Qt\5.3\mingw482_32\bin\*.dll"; DestDir: "{app}\bin"
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Dirs]
Name: "{app}/spool"; Flags: uninsneveruninstall
Name: "{app}/scratch"; Flags: uninsneveruninstall

[Code]
procedure InitializeWizard();
var 
    Installed : Cardinal;
begin
ITD_Init;
Installed := 0;
RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\VisualStudio\10.0\VC\VCRedist\x86', 'Installed', Installed);
if Installed <> 1 then
begin
    if IsWin64() then
    begin
        if RegQueryDWordValue(HKLM, 'SOFTWARE\Microsoft\VisualStudio\10.0\VC\VCRedist\x64', 'Installed', Installed) then
        begin
            if Installed <> 1 then
            begin 
                ITD_AddFile('http://download.microsoft.com/download/3/2/2/3224B87F-CFA0-4E70-BDA3-3DE650EFEBA5/vcredist_x64.exe', expandconstant('{tmp}\vcredist.exe'));
            end;
        end;
    end else
    begin
        ITD_AddFile('http://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe', expandconstant('{tmp}\vcredist.exe'));
    end;
    ITD_DownloadAfter(wpReady);
end;
end;
    
[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; WorkingDir: "{app}\bin"
Name: "{commondesktop}\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; Tasks: desktopicon; WorkingDir: "{app}\bin"
Name: "{userappdata}\Microsoft\Internet Explorer\Quick Launch\{#MyAppName}"; Filename: "{app}\bin\{#MyAppExeName}"; WorkingDir: "{app}\bin"; Tasks: quicklaunchicon

[Run]
Filename: "{tmp}\vcredist.exe"; Parameters: "/q:a /c:""VCREDI~3.EXE /q:a /c:""""msiexec /i vcredist.msi /qn"""" """; Flags: skipifdoesntexist; StatusMsg: Installing Visual Studio 2010 C++ CRT Libraries...
Filename: "{app}\build-ini.bat"; StatusMsg: "Configuring..."; Flags: nowait
Filename: "{app}\bin\{#MyAppExeName}"; WorkingDir: "{app}\bin"; Description: "{cm:LaunchProgram,{#StringChange(MyAppName, '&', '&&')}}"; Flags: nowait postinstall skipifsilent

