function UpsyncEngineBuild {

	param (
		[Parameter(Mandatory)] [string] $EngineBuildLocation,
		[Parameter(Mandatory)] [string] $VersionIndexURI,
		[Parameter(Mandatory)] [string] $StorageURI,
		[Parameter(Mandatory)] [string] $CredentialsFile
	
	)

	$Here = $PSScriptRoot

	$OldGoogleApplicationCredentials = $env:GOOGLE_APPLICATION_CREDENTIALS
	$env:GOOGLE_APPLICATION_CREDENTIALS = $CredentialsFile
	& (Join-Path -Path $Here -ChildPath "longtail-win32-x64.exe") upsync --source-path $EngineBuildLocation --target-path $VersionIndexURI --storage-uri $StorageURI
	$env:GOOGLE_APPLICATION_CREDENTIALS = $OldGoogleApplicationCredentials

	if ($LASTEXITCODE -ne 0) {
		throw
	}
}
