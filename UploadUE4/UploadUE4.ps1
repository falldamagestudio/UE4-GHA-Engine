param (
	[Parameter(Mandatory)] [string] $CloudStorageBucket,
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

	$UE4Location = "\\?\$(Join-Path -Path $Here -ChildPath $LocalConfiguration.ue4_location | Resolve-Path)"

	$EngineBuildLocation = "${UE4Location}\LocalBuilds\Engine\Windows"

	$VersionIndexURI = "gs://${CloudStorageBucket}/store/index/engine-${BuildId}-win64.lvi"
	$StorageURI = "gs://${CloudStorageBucket}/store"

	UpsyncEngineBuild -EngineBuildLocation $EngineBuildLocation -VersionIndexURI $VersionIndexURI -StorageURI $StorageURI -CredentialsFile $CredentialsFile

	Write-Host "Engine upload done"

} catch {

	Write-Host "An error occured during engine build upload"
	throw

}


