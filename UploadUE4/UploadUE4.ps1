param (
	[Parameter(Mandatory)] [string] $BuildId
)

$Here = $PSScriptRoot

. $Here\UpsyncEngineBuild.ps1

try {

	$OnlineConfigurationLocation = Join-Path -Path $Here -ChildPath "online_configuration.json"
	$OnlineConfiguration = Get-Content -Path $OnlineConfigurationLocation | ConvertFrom-Json

	$LocalConfigurationLocation = Join-Path -Path $Here -ChildPath "local_configuration.json"
	$LocalConfiguration = Get-Content -Path $LocalConfigurationLocation | ConvertFrom-Json

	$CredentialsFile = Join-Path -Path $Here -ChildPath "service-account-credentials.json"

	$UE4Location = Join-Path -Path $Here -ChildPath $LocalConfiguration.ue4_location | Resolve-Path

	$EngineBuildLocation = Join-Path -Path $UE4Location -ChildPath "LocalBuilds\Engine\Windows"

	$VersionIndexURI = "$($OnlineConfiguration.version_index_uri)/engine-${BuildId}-win64.lvi"

	UpsyncEngineBuild -EngineBuildLocation $EngineBuildLocation -VersionIndexURI $VersionIndexURI -StorageURI $OnlineConfiguration.storage_uri -CredentialsFile $CredentialsFile

	Write-Host "Engine upload done"

} catch {

	Write-Host "An error occured during engine build upload"
	throw

}


