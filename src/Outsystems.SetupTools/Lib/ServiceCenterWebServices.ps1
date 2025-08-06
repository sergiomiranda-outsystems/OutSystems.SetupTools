
function SCWS_GetPlatformServicesProxy([string]$SCHost, [switch]$UseHTTPS)
{
    $platformServicesUri = "http://$SCHost/ServiceCenter/PlatformServices_v8_0_0.asmx?WSDL"
    if ($UseHTTPS -eq $true) {$platformServicesUri = $platformServicesUri.Replace('http://', 'https://')}

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Connecting to $platformServicesUri"

    if ( ($null -eq $platformServicesWS) -or ($platformServicesWS.Url.Contains($SCHost) -eq $false) ) {
        $script:platformServicesWS = New-WebServiceProxy -Uri $platformServicesUri -ErrorAction Stop -Namespace 'OutSystems.PlatformServices'
    }

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Connection successful"

    return $platformServicesWS
}

function SCWS_GetSolutionsProxy([string]$SCHost, [switch]$UseHTTPS)
{
    $solutionsUri = "http://$SCHost/ServiceCenter/Solutions.asmx?WSDL"
    if ($UseHTTPS -eq $true) {$solutionsUri = $solutionsUri.Replace('http://', 'https://')}

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Connecting to $solutionsUri"

    if ( ($null -eq $solutionsWS) -or ($solutionsWS.Url.Contains($SCHost) -eq $false) ) {
        $script:solutionsWS = New-WebServiceProxy -Uri $solutionsUri -ErrorAction Stop -Namespace 'OutSystems.Solutions'
    }

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Connection successful"

    return $solutionsWS
}

function SCWS_GetOutSystemsPlatformProxy([string]$SCHost, [switch]$UseHTTPS)
{
    $platformUri = "http://$SCHost/ServiceCenter/OutSystemsPlatform.asmx?WSDL"
    if ($UseHTTPS -eq $true) {$platformUri = $platformUri.Replace('http://', 'https://')}

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Connecting to $platformUri"

    if ( ($null -eq $platformWS) -or ($platformWS.Url.Contains($SCHost) -eq $false) ) {
        $script:platformWS = New-WebServiceProxy -Uri $platformUri -ErrorAction Stop -Namespace 'OutSystems.Platform'
    }

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Connection successful"

    return $platformWS
}

function SCWS_GetPlatformInfo([string]$SCHost, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Getting platform info from $SCHost"

    $dummy = ""

    $platformWS = SCWS_GetOutSystemsPlatformProxy -SCHost $SCHost -UseHTTPS:$UseHTTPS
    $result = $($platformWS).GetPlatformInfo(([ref]$dummy))

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Returning $result"

    return $result
}

function SCWS_Applications_Get([string]$SCHost, [string]$SCUser, [string]$SCPass, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Getting applications from $SCHost"

    $platformServicesWS = SCWS_GetPlatformServicesProxy -SCHost $SCHost -UseHTTPS:$UseHTTPS
    $result = $($platformServicesWS).Applications_Get($SCUser, $(GetHashedPassword($SCPass)), $true, $true)

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Returning $($result.Count) applications"

    return $result
}

function SCWS_Modules_Get([string]$SCHost, [string]$SCUser, [string]$SCPass, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Getting modules from $SCHost"

    $platformServicesWS = SCWS_GetPlatformServicesProxy -SCHost $SCHost -UseHTTPS:$UseHTTPS
    $result = $($platformServicesWS).Modules_Get($SCUser, $(GetHashedPassword($SCPass)))

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Returning $($result.Count) modules"

    return $result
}

function SCWS_Module_GetVersions([string]$SCHost, [string]$SCUser, [string]$SCPass, [string]$ModuleKey, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Getting modules versions of module key $ModuleKey"

    $errorCode = 0
    $errorMessage = ""
    $publishedVersion = 0

    $platformServicesWS = SCWS_GetPlatformServicesProxy -SCHost $SCHost -UseHTTPS:$UseHTTPS
    $result = $($platformServicesWS).Module_GetVersions($SCUser, $(GetHashedPassword($SCPass)), $ModuleKey, [ref]$publishedVersion, [ref]$errorCode, [ref]$errorMessage)

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Returning $($result.Count) module versions"

    $returnResult = [pscustomobject]@{
        ErrorCode        = $errorCode
        ErrorMessage     = $errorMessage
        PublishedVersion = $publishedVersion
        ModuleVersions   = $result
    }

    return $returnResult
}

function SCWS_Staging_PublishWith2StepOption([string]$SCHost, [string]$SCUser, [string]$SCPass, [object[]]$ModulesToPublish, [object[]]$ApplicationsToUpdate, [string]$StagingName, [bool]$TwoStepMode, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Publishing $($ModulesToPublish.Count) modules"

    $uri = "http://$SCHost/ServiceCenter/rest/PlatformServices/Staging_PublishWith2StepOption?StagingName=$StagingName&TwoStepMode=$TwoStepMode"
    if ($UseHTTPS -eq $true) {$uri = $uri.Replace('http://', 'https://')}
    $body = [pscustomobject]@{
        ModulesToPublish     = $ModulesToPublish
        ApplicationsToUpdate = $ApplicationsToUpdate
    } | ConvertTo-Json -Depth 20

    $base64AuthInfo = [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f $SCUser, $(GetHashedPassword($SCPass)))))

    $result = Invoke-RestMethod -Uri $uri -Headers @{Authorization = "Basic $base64AuthInfo" } -Method POST -ContentType "application/json" -Body $body -Verbose:$false

    return $result
}

function SCWS_SolutionPack_PublishWith2StepOption([string]$SCHost, [string]$SCUser, [string]$SCPass, [Byte[]]$Solution, [bool]$TwoStepMode, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Publishing solution to $SCHost"

    $publishId = 0

    $platformServicesWS = SCWS_GetPlatformServicesProxy -SCHost $SCHost -UseHTTPS:$UseHTTPS
    $result = $($platformServicesWS).SolutionPack_PublishWith2StepOption($SCUser, $(GetHashedPassword($SCPass)), $Solution, $TwoStepMode, [ref]$publishId)

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Returning publishing id $publishId"

    $returnResult = [pscustomobject]@{
        PublishId = $publishId
        Messages  = $result
    }

    return $returnResult
}

function SCWS_SolutionPack_GetPublicationMessages([string]$SCHost, [string]$SCUser, [string]$SCPass, [int]$PublishId, [int]$AfterMessageId, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Getting messages from publishing id $PublishId"

    $lastMessageId = 0
    $finished = $false

    $platformServicesWS = SCWS_GetPlatformServicesProxy -SCHost $SCHost -UseHTTPS:$UseHTTPS -UseHTTPS:$UseHTTPS
    $result = $($platformServicesWS).SolutionPack_GetPublishMessages($SCUser, $(GetHashedPassword($SCPass)), $PublishId, $AfterMessageId, [ref]$lastMessageId, [ref]$finished)

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Returning messages"

    $returnResult = [pscustomobject]@{
        Finished      = [bool]$finished
        LastMessageId = $lastMessageId
        Messages      = $result
    }

    return $returnResult
}

function SCWS_SolutionPack_PublishContinue([string]$SCHost, [string]$SCUser, [string]$SCPass, [int]$PublishId, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Continuing publish id $PublishId on $SCHost"

    $platformServicesWS = SCWS_GetPlatformServicesProxy -SCHost $SCHost -UseHTTPS:$UseHTTPS
    $null = $($platformServicesWS).SolutionPack_PublishContinue($SCUser, $(GetHashedPassword($SCPass)), $PublishId)
}

function WSSC_SolutionPack_PublishAbort([string]$SCHost, [string]$SCUser, [string]$SCPass, [int]$PublishId, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Stopping publish id $PublishId on $SCHost"

    $platformServicesWS = SCWS_GetPlatformServicesProxy -SCHost $SCHost -UseHTTPS:$UseHTTPS
    $null = $($platformServicesWS).SolutionPack_PublishAbort($SCUser, $(GetHashedPassword($SCPass)), $PublishId)
}


#>###########
Function WSGetModuleVersionPublished([string]$SCHost, [string]$SCUser, [string]$SCPass, [string]$ModuleKey, [switch]$UseHTTPS)
{
    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Getting module published version of module key $ModuleKey"

    $errorCode = 0
    $errorMessage = ""
    $publishedVersion = 0

    $platformServicesWS = GetPlatformServicesWS -SCHost $SCHost -UseHTTPS:$UseHTTPS
    $result = $($platformServicesWS).Module_GetVersions($SCUser, $(GetHashedPassword($SCPass)), $ModuleKey, [ref]$publishedVersion, [ref]$errorCode, [ref]$errorMessage)

    LogMessage -Function $($MyInvocation.Mycommand) -Phase 1 -Stream 2 -Message "Returning module version $publishedVersion"

    $returnResult = [pscustomobject]@{
        ErrorCode     = $errorCode
        ErrorMessage  = $errorMessage
        ModuleVersion = $result | Where-Object -FilterScript { $_.Version -eq $publishedVersion }
    }

    return $returnResult
}
