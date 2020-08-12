# Goal of the script is to execute the cli from the constructed cli command in the GUI.

# Retrieve the parameters given to the script (i.e the constructed cli command in the GUI).
param(
[int]$auda_parameters
)

# Debug: check the parameters given to the scripts and wait.
#Write-Output $auda_parameters;
#Read-Host -Prompt "Press Enter to continue"

$i = $auda_parameters

# Debug: check the parameters given to the scripts and wait.
#Write-Output $i;
#Read-Host -Prompt "Press Enter to continue"


# Define an empty string that will store the absolute path this PowerShell script and the name of the PowerShell script.
$scriptPath = [string]::Empty;
$scriptName = [string]::Empty;

# Define a string that will store the absolute path this PowerShell script and its name.
# If PowerShell version is greater than v2, we can use $PSScriptRoot to retrieve the path location. Else, use $MyInvocation.MyCommand.Definition.
if ($PSVersionTable.PSVersion.Major -gt 2)
{
    $scriptPath = $PSScriptRoot;
    $scriptName = $PSCommandPath;
}
else
{
    $scriptPath = split-path -parent $MyInvocation.MyCommand.Definition;
    $scriptName = $MyInvocation.MyCommand.Name;
}

# Check if the path $scriptPath exists.
if(!(Test-Path -Path $scriptPath))
{
    Write-Host "Error in: $scriptName.";
    Write-Host "$scriptPath doesn't exist.";
    Write-Host "Exiting...";
    exit;
}

$path="$scriptPath"
# https://stackoverflow.com/questions/5427506/how-to-sort-by-file-name-the-same-way-windows-explorer-does
$files=Get-ChildItem $path -Recurse -File -Exclude *.ps1 | Sort-Object { [regex]::Replace($_.Name, '\d+', { $args[0].Value.PadLeft(20) }) }


Foreach($obj in $files){
   $pathWithFilename=  Join-Path -Path $path -ChildPath $obj.Name;
   #$newFilename= "Iphone_"+$obj.BaseName+"_"+$i+$obj.Extension; 
   $newFilename= "Iphone_"+$i+$obj.Extension;

   Rename-Item -Path $pathWithFilename -NewName $newFilename
   $i++;

}