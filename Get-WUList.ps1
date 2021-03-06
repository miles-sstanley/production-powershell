Function Get-WUList
{
    <#
 .SYNOPSIS
     Get list of available updates meeting the criteria.
 
 .DESCRIPTION
     Use Get-WUList to get list of available or installed updates meeting specific criteria.
  There are two types of filtering update: Pre search criteria, Post search criteria.
  - Pre search works on server side, like example: ( IsInstalled = 0 and IsHidden = 0 and CategoryIds contains '0fa1201d-4330-4fa8-8ae9-b877473b6441' )
  - Post search work on client side after downloading the pre-filtered list of updates, like example $KBArticleID -match $Update.KBArticleIDs
 
  Status list:
        D - IsDownloaded, I - IsInstalled, M - IsMandatory, H - IsHidden, U - IsUninstallable, B - IsBeta
   
 .PARAMETER UpdateType
  Pre search criteria. Finds updates of a specific type, such as 'Driver' and 'Software'. Default value contains all updates.
 
 .PARAMETER UpdateID
  Pre search criteria. Finds updates of a specific UUID (or sets of UUIDs), such as '12345678-9abc-def0-1234-56789abcdef0'.
 
 .PARAMETER RevisionNumber
  Pre search criteria. Finds updates of a specific RevisionNumber, such as '100'. This criterion must be combined with the UpdateID param.
 
 .PARAMETER CategoryIDs
  Pre search criteria. Finds updates that belong to a specified category (or sets of UUIDs), such as '0fa1201d-4330-4fa8-8ae9-b877473b6441'.
 
 .PARAMETER IsInstalled
  Pre search criteria. Finds updates that are installed on the destination computer.
 
 .PARAMETER IsHidden
  Pre search criteria. Finds updates that are marked as hidden on the destination computer.
  
 .PARAMETER IsNotHidden
  Pre search criteria. Finds updates that are not marked as hidden on the destination computer. Overwrite IsHidden param.
    
 .PARAMETER Criteria
  Pre search criteria. Set own string that specifies the search criteria.
 
 .PARAMETER ShowSearchCriteria
  Show choosen search criteria. Only works for pre search criteria.
 
 .PARAMETER RootCategories
  Post search criteria. Finds updates that contain a specified root category name 'Critical Updates', 'Definition Updates', 'Drivers', 'Feature Packs', 'Security Updates', 'Service Packs', 'Tools', 'Update Rollups', 'Updates', 'Upgrades', 'Microsoft'
 
 .PARAMETER Category
  Post search criteria. Finds updates that contain a specified category name (or sets of categories name), such as 'Updates', 'Security Updates', 'Critical Updates', etc...
   
 .PARAMETER KBArticleID
  Post search criteria. Finds updates that contain a KBArticleID (or sets of KBArticleIDs), such as 'KB982861'.
  
 .PARAMETER Title
  Post search criteria. Finds updates that match part of title, such as ''
 
 .PARAMETER Severity
  Post search criteria. Finds updates that match part of severity, such as 'Important', 'Critical', 'Moderate', etc...
 
 .PARAMETER NotCategory
  Post search criteria. Finds updates that not contain a specified category name (or sets of categories name), such as 'Updates', 'Security Updates', 'Critical Updates', etc...
   
 .PARAMETER NotKBArticleID
  Post search criteria. Finds updates that not contain a KBArticleID (or sets of KBArticleIDs), such as 'KB982861'.
  
 .PARAMETER NotTitle
  Post search criteria. Finds updates that not match part of title.
    
 .PARAMETER NotSeverity
  Post search criteria. Finds updates that not match part of severity.
 
 .PARAMETER MaxSize
  Post search criteria. Finds updates that have MaxDownloadSize less or equal. Size is in Bytes.
 
 .PARAMETER MinSize
  Post search criteria. Finds updates that have MaxDownloadSize greater or equal. Size is in Bytes.
   
 .PARAMETER IgnoreUserInput
  Post search criteria. Finds updates that the installation or uninstallation of an update can't prompt for user input.
  
 .PARAMETER IgnoreRebootRequired
  Post search criteria. Finds updates that specifies the restart behavior that not occurs when you install or uninstall the update.
  
 .PARAMETER ServiceID
  Set ServiceIS to change the default source of Windows Updates. It overwrite ServerSelection parameter value.
 
 .PARAMETER WindowsUpdate
  Set Windows Update Server as source. Default update config are taken from computer policy.
   
 .PARAMETER MicrosoftUpdate
  Set Microsoft Update Server as source. Default update config are taken from computer policy.
   
 .PARAMETER ComputerName    
     Specify the name of the computer to the remote connection.
  
 .PARAMETER AutoSelectOnly
  Install only the updates that have status AutoSelectOnWebsites on true.        
 
 .PARAMETER Debuger    
     Debug mode.
 
 .EXAMPLE
  Get list of available updates from Microsoft Update Server.
  
  PS C:\> Get-WUList -MicrosoftUpdate
 
  ComputerName Status KB Size Title
  ------------ ------ -- ---- -----
  KOMPUTER ------ KB976002 102 KB Aktualizacja firmy Microsoft z ekranem wybierania przeglądarki dla użytkowników...
  KOMPUTER ------ KB971033 1 MB Aktualizacja dla systemu Windows 7 dla systemów opartych na procesorach x64 (KB...
  KOMPUTER ------ KB2533552 9 MB Aktualizacja systemu Windows 7 dla komputerów z procesorami x64 (KB2533552)
  KOMPUTER ------ KB982861 37 MB Windows Internet Explorer 9 dla systemu Windows 7 - wersja dla systemów opartyc...
  KOMPUTER D----- KB982670 48 MB Program Microsoft .NET Framework 4 Client Profile w systemie Windows 7 dla syst...
  KOMPUTER ---H-- KB890830 1 MB Narzędzie Windows do usuwania złośliwego oprogramowania dla komputerów z proces...
 
 .EXAMPLE
  Get list of critical or security updates.
  
  PS C:\> Get-WUList -RootCategories 'Critical Updates','Security Updates'
 
  ComputerName Status KB Size Title
  ------------ ------ -- ---- -----
  KOMPUTER ------ KB3156059 287 KB Security Update for Windows Server 2012 R2 (KB3156059)
  KOMPUTER ------ KB3156059 1 MB Security Update for Windows Server 2012 R2 (KB3156059)
 
 .EXAMPLE
  Get information about updates from Microsoft Update Server that are installed on remote machine G1. Updates type are software, from specific category, have specific UUID and Revision Name.
   
  PS C:\> $UpdateIDs = "40336e0a-7b9b-45a0-89e9-9bd3ce0c3137","61bfe3ec-a1dc-4eab-9481-0d8fd7319ae8","0c737c40-b687-45bc-8
  deb-83db8209b258"
  PS C:\> Get-WUList -MicrosoftUpdate -IsInstalled -Type "Software" -CategoryIDs "E6CF1350-C01B-414D-A61F-263D14D133B4" -U
  pdateID $UpdateIDs -RevisionNumber 101 -ComputerName G1 -Verbose
  VERBOSE: Connecting to Microsoft Update server. Please wait...
  VERBOSE: Found [2] Updates in pre search criteria
  VERBOSE: Found [2] Updates in post search criteria
 
  ComputerName Status KB Size Title
  ------------ ------ -- ---- -----
  G1 DI--U- KB2345886 605 KB Aktualizacja dla systemu Windows 7 dla systemów opartych na procesorach x64 (KB...
  G1 DI--U- KB2641690 67 KB Aktualizacja systemu Windows 7 dla komputerów z procesorami x64 (KB2641690)
 
 .EXAMPLE
  Hide updates contains "Internet Explorer 9" in title and are in "Update Rollups" category.
   
  PS C:\> $UpdatesList = Get-WUList -ServiceID "9482f4b4-e343-43b6-b170-9a65bc822c77" -Title "Internet Explorer 9" -Catego
  ry "Update Rollups"
  PS C:\> $UpdatesList.IsHidden = $true
  PS C:\> Get-WUList -ServiceID "9482f4b4-e343-43b6-b170-9a65bc822c77" -Title "Internet Explorer 9" -Category "Update Roll
  ups" -IsHidden
 
  ComputerName Status KB Size Title
  ------------ ------ -- ---- -----
  KOMPUTER ---H-- KB982861 37 MB Windows Internet Explorer 9 dla systemu Windows 7 - wersja dla systemów opartyc...
 
 .EXAMPLE
  Get list of updates without language packs and updatets that's not hidden.
  
  PS C:\> Get-WUList -NotCategory "Language packs" -IsNotHidden
 
  ComputerName Status KB Size Title
  ------------ ------ -- ---- -----
  G1 ------ KB2640148 8 MB Aktualizacja systemu Windows 7 dla komputerów z procesorami x64 (KB2640148)
  G1 ------ KB2600217 32 MB Aktualizacja dla programu Microsoft .NET Framework 4 w systemach Windows XP, Se...
  G1 ------ KB2679255 6 MB Aktualizacja systemu Windows 7 dla komputerów z procesorami x64 (KB2679255)
  G1 ------ KB915597 3 MB Definition Update for Windows Defender - KB915597 (Definition 1.125.146.0)
   
 .NOTES
  Author: Michal Gajda
  Blog : http://commandlinegeeks.com/
   
 .LINK
  http://gallery.technet.microsoft.com/scriptcenter/2d191bcd-3308-4edd-9de2-88dff796b0bc
  http://msdn.microsoft.com/en-us/library/windows/desktop/aa386526(v=vs.85).aspx
  http://msdn.microsoft.com/en-us/library/windows/desktop/aa386099(v=vs.85).aspx
  http://msdn.microsoft.com/en-us/library/ff357803(VS.85).aspx
 
 .LINK
  Get-WUServiceManager
  Get-WUInstall
 #>

    [OutputType('PSWindowsUpdate.WUList')]
    [CmdletBinding(
        SupportsShouldProcess=$True,
        ConfirmImpact="High"
    )]    
    Param
    (
        #Pre search criteria
        [ValidateSet("Driver", "Software")]
        [String]$UpdateType="",
        [String[]]$UpdateID,
        [Int]$RevisionNumber,
        [String[]]$CategoryIDs,
        [Switch]$IsInstalled,
        [Switch]$IsHidden,
        [Switch]$IsNotHidden,
        [String]$Criteria,
        [Switch]$ShowSearchCriteria,        
        
        #Post search criteria
        [ValidateSet("Critical Updates", "Definition Updates", "Drivers", "Feature Packs", "Security Updates", "Service Packs", "Tools", "Update Rollups", "Updates", "Upgrades", "Microsoft")]
        [String[]]$RootCategories,
        [String[]]$Category="",
        [String[]]$KBArticleID,
        [String]$Title,
        [ValidateSet("Critical", "Important", "Moderate", "Low", "Unspecified", "")]
        [String[]]$Severity,

        [String[]]$NotCategory="",
        [String[]]$NotKBArticleID,
        [String]$NotTitle,
        [ValidateSet("Critical", "Important", "Moderate", "Low", "Unspecified")]
        [String[]]$NotSeverity,
        [Int]$MaxSize,
        [Int]$MinSize,

        [Alias("Silent")]
        [Switch]$IgnoreUserInput,
        [Switch]$IgnoreRebootRequired,
        [Switch]$AutoSelectOnly,        
        
        #Connection options
        [String]$ServiceID,
        [Switch]$WindowsUpdate,
        [Switch]$MicrosoftUpdate,
        
        #Mode options
        [Switch]$Debuger,
        [parameter(ValueFromPipeline=$true,
            ValueFromPipelineByPropertyName=$true)]
        [String[]]$ComputerName
    )

    Begin
    {
        If($PSBoundParameters['Debuger'])
        {
            $DebugPreference = "Continue"
        } #End If $PSBoundParameters['Debuger']
        
        $User = [Security.Principal.WindowsIdentity]::GetCurrent()
        $Role = (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)

        if(!$Role)
        {
            Write-Warning "To perform some operations you must run an elevated Windows PowerShell console."    
        } #End If !$Role        
    }

    Process
    {
        Write-Debug "STAGE 0: Prepare environment"
        ######################################
        # Start STAGE 0: Prepare environment #
        ######################################
        
        Write-Debug "Check if ComputerName in set"
        If($ComputerName -eq $null)
        {
            Write-Debug "Set ComputerName to localhost"
            [String[]]$ComputerName = $env:COMPUTERNAME
        } #End If $ComputerName -eq $null
        
        ####################################            
        # End STAGE 0: Prepare environment #
        ####################################
        
        $UpdateCollection = @()
        Foreach($Computer in $ComputerName)
        {
            If(Test-Connection -ComputerName $Computer -Quiet)
            {
                Write-Debug "STAGE 1: Get updates list"
                ###################################
                # Start STAGE 1: Get updates list #
                ###################################            

                If($Computer -eq $env:COMPUTERNAME)
                {
                    Write-Debug "Create Microsoft.Update.ServiceManager object"
                    $objServiceManager = New-Object -ComObject "Microsoft.Update.ServiceManager" #Support local instance only
                    Write-Debug "Create Microsoft.Update.Session object for $Computer"
                    $objSession = New-Object -ComObject "Microsoft.Update.Session" #Support local instance only
                } #End If $Computer -eq $env:COMPUTERNAME
                Else
                {
                    Write-Debug "Create Microsoft.Update.Session object for $Computer"
                    $objSession =  [activator]::CreateInstance([type]::GetTypeFromProgID("Microsoft.Update.Session",$Computer))
                } #End Else $Computer -eq $env:COMPUTERNAME
                
                Write-Debug "Create Microsoft.Update.Session.Searcher object for $Computer"
                $objSearcher = $objSession.CreateUpdateSearcher()

                If($WindowsUpdate)
                {
                    Write-Debug "Set source of updates to Windows Update"
                    $objSearcher.ServerSelection = 2
                    $serviceName = "Windows Update"
                } #End If $WindowsUpdate
                ElseIf($MicrosoftUpdate)
                {
                    Write-Debug "Set source of updates to Microsoft Update"
                    $serviceName = $null
                    Foreach ($objService in $objServiceManager.Services) 
                    {
                        If($objService.Name -eq "Microsoft Update")
                        {
                            $objSearcher.ServerSelection = 3
                            $objSearcher.ServiceID = $objService.ServiceID
                            $serviceName = $objService.Name
                            Break
                        }#End If $objService.Name -eq "Microsoft Update"
                    }#End ForEach $objService in $objServiceManager.Services
                    
                    If(-not $serviceName)
                    {
                        Write-Warning "Can't find registered service Microsoft Update. Use Get-WUServiceManager to get registered service."
                        Return
                    }#Enf If -not $serviceName
                } #End Else $WindowsUpdate If $MicrosoftUpdate
                ElseIf($Computer -eq $env:COMPUTERNAME) #Support local instance only
                {
                    Foreach ($objService in $objServiceManager.Services) 
                    {
                        If($ServiceID)
                        {
                            If($objService.ServiceID -eq $ServiceID)
                            {
                                $objSearcher.ServiceID = $ServiceID
                                $objSearcher.ServerSelection = 3
                                $serviceName = $objService.Name
                                Break
                            } #End If $objService.ServiceID -eq $ServiceID
                        } #End If $ServiceID
                        Else
                        {
                            If($objService.IsDefaultAUService -eq $True)
                            {
                                $serviceName = $objService.Name
                                Break
                            } #End If $objService.IsDefaultAUService -eq $True
                        } #End Else $ServiceID
                    } #End Foreach $objService in $objServiceManager.Services
                } #End Else $MicrosoftUpdate If $Computer -eq $env:COMPUTERNAME
                ElseIf($ServiceID)
                {
                    $objSearcher.ServiceID = $ServiceID
                    $objSearcher.ServerSelection = 3
                    $serviceName = $ServiceID
                }
                Else #End Else $Computer -eq $env:COMPUTERNAME If $ServiceID
                {
                    $serviceName = "default (for $Computer) Windows Update"
                } #End Else $ServiceID
                Write-Debug "Set source of updates to $serviceName"
                
                Write-Verbose "Connecting to $serviceName server. Please wait..."
                Try
                {
                    $search = ""
                    If($Criteria)
                    {
                        $search = $Criteria
                    } #End If $Criteria
                    Else
                    {
                        If($IsInstalled) 
                        {
                            $search = "IsInstalled = 1"
                            Write-Debug "Set pre search criteria: IsInstalled = 1"
                        } #End If $IsInstalled
                        Else
                        {
                            $search = "IsInstalled = 0"    
                            Write-Debug "Set pre search criteria: IsInstalled = 0"
                        } #End Else $IsInstalled
                        
                        If($UpdateType -ne "")
                        {
                            Write-Debug "Set pre search criteria: Type = $UpdateType"
                            $search += " and Type = '$UpdateType'"
                        } #End If $UpdateType -ne ""                    
                        
                        If($UpdateID)
                        {
                            Write-Debug "Set pre search criteria: UpdateID = '$([string]::join(", ", $UpdateID))'"
                            $tmp = $search
                            $search = ""
                            $LoopCount = 0
                            Foreach($ID in $UpdateID)
                            {
                                If($LoopCount -gt 0)
                                {
                                    $search += " or "
                                } #End If $LoopCount -gt 0
                                If($RevisionNumber)
                                {
                                    Write-Debug "Set pre search criteria: RevisionNumber = '$RevisionNumber'"    
                                    $search += "($tmp and UpdateID = '$ID' and RevisionNumber = $RevisionNumber)"
                                } #End If $RevisionNumber
                                Else
                                {
                                    $search += "($tmp and UpdateID = '$ID')"
                                } #End Else $RevisionNumber
                                $LoopCount++
                            } #End Foreach $ID in $UpdateID
                        } #End If $UpdateID

                        If($CategoryIDs)
                        {
                            Write-Debug "Set pre search criteria: CategoryIDs = '$([string]::join(", ", $CategoryIDs))'"
                            $tmp = $search
                            $search = ""
                            $LoopCount =0
                            Foreach($ID in $CategoryIDs)
                            {
                                If($LoopCount -gt 0)
                                {
                                    $search += " or "
                                } #End If $LoopCount -gt 0
                                $search += "($tmp and CategoryIDs contains '$ID')"
                                $LoopCount++
                            } #End Foreach $ID in $CategoryIDs
                        } #End If $CategoryIDs
                        
                        If($IsNotHidden) 
                        {
                            Write-Debug "Set pre search criteria: IsHidden = 0"
                            $search += " and IsHidden = 0"    
                        } #End If $IsNotHidden
                        ElseIf($IsHidden) 
                        {
                            Write-Debug "Set pre search criteria: IsHidden = 1"
                            $search += " and IsHidden = 1"    
                        } #End ElseIf $IsHidden

                        #Don't know why every update have RebootRequired=false which is not always true
                        If($IgnoreRebootRequired) 
                        {
                            Write-Debug "Set pre search criteria: RebootRequired = 0"
                            $search += " and RebootRequired = 0"    
                        } #End If $IgnoreRebootRequired
                    } #End Else $Criteria
                    
                    Write-Debug "Search criteria is: $search"
                    
                    If($ShowSearchCriteria)
                    {
                        Write-Output $search
                    } #End If $ShowSearchCriteria
            
                    $objResults = $objSearcher.Search($search)
                } #End Try
                Catch
                {
                    If($_ -match "HRESULT: 0x80072EE2")
                    {
                        Write-Warning "Probably you don't have connection to Windows Update server"
                    } #End If $_ -match "HRESULT: 0x80072EE2"
                    Return
                } #End Catch

                $NumberOfUpdate = 1
                $PreFoundUpdatesToDownload = $objResults.Updates.count
                Write-Verbose "Found [$PreFoundUpdatesToDownload] Updates in pre search criteria"                
                
                If($PreFoundUpdatesToDownload -eq 0)
                {
                    Continue
                } #End If $PreFoundUpdatesToDownload -eq 0
                
                if($RootCategories)
                {
                    $RootCategoriesCollection = @()
                    foreach($RootCategory in $RootCategories)
                    {
                        switch ($RootCategory) 
                        { 
                            "Critical Updates" {$CatID = 0} 
                            "Definition Updates"{$CatID = 1} 
                            "Drivers"{$CatID = 2} 
                            "Feature Packs"{$CatID = 3} 
                            "Security Updates"{$CatID = 4} 
                            "Service Packs"{$CatID = 5} 
                            "Tools"{$CatID = 6} 
                            "Update Rollups"{$CatID = 7} 
                            "Updates"{$CatID = 8} 
                            "Upgrades"{$CatID = 9} 
                            "Microsoft"{$CatID = 10} 
                        } #End switch $RootCategory
                        $RootCategoriesCollection += $objResults.RootCategories.item($CatID).Updates
                    } #End foreach $RootCategory in $RootCategories
                    $objResults = New-Object -TypeName psobject -Property @{Updates = $RootCategoriesCollection}
                } #End if $RootCategories

                Foreach($Update in $objResults.Updates)
                {    
                    $UpdateAccess = $true
                    Write-Progress -Activity "Post search updates for $Computer" -Status "[$NumberOfUpdate/$PreFoundUpdatesToDownload] $($Update.Title) $size" -PercentComplete ([int]($NumberOfUpdate/$PreFoundUpdatesToDownload * 100))
                    Write-Debug "Set post search criteria: $($Update.Title)"
                    
                    If($Category -ne "")
                    {
                        $UpdateCategories = $Update.Categories | Select-Object Name
                        Write-Debug "Set post search criteria: Categories = '$([string]::join(", ", $Category))'"    
                        Foreach($Cat in $Category)
                        {
                            If(!($UpdateCategories -match $Cat))
                            {
                                Write-Debug "UpdateAccess: false"
                                $UpdateAccess = $false
                            } #End If !($UpdateCategories -match $Cat)
                            Else
                            {
                                $UpdateAccess = $true
                                Break
                            } #End Else !($UpdateCategories -match $Cat)
                        } #End Foreach $Cat in $Category    
                    } #End If $Category -ne ""

                    If($NotCategory -ne "" -and $UpdateAccess -eq $true)
                    {
                        $UpdateCategories = $Update.Categories | Select-Object Name
                        Write-Debug "Set post search criteria: NotCategories = '$([string]::join(", ", $NotCategory))'"    
                        Foreach($Cat in $NotCategory)
                        {
                            If($UpdateCategories -match $Cat)
                            {
                                Write-Debug "UpdateAccess: false"
                                $UpdateAccess = $false
                                Break
                            } #End If $UpdateCategories -match $Cat
                        } #End Foreach $Cat in $NotCategory    
                    } #End If $NotCategory -ne "" -and $UpdateAccess -eq $true                    
                    
                    If($KBArticleID -ne $null -and $UpdateAccess -eq $true)
                    {
                        Write-Debug "Set post search criteria: KBArticleIDs = '$([string]::join(", ", $KBArticleID))'"
                        If(!($KBArticleID -match $Update.KBArticleIDs -and "" -ne $Update.KBArticleIDs))
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If !($KBArticleID -match $Update.KBArticleIDs)                                
                    } #End If $KBArticleID -ne $null -and $UpdateAccess -eq $true

                    If($NotKBArticleID -ne $null -and $UpdateAccess -eq $true)
                    {
                        Write-Debug "Set post search criteria: NotKBArticleIDs = '$([string]::join(", ", $NotKBArticleID))'"
                        If($NotKBArticleID -match $Update.KBArticleIDs -and "" -ne $Update.KBArticleIDs)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If$NotKBArticleID -match $Update.KBArticleIDs -and "" -ne $Update.KBArticleIDs                    
                    } #End If $NotKBArticleID -ne $null -and $UpdateAccess -eq $true
                    
                    If($Title -and $UpdateAccess -eq $true)
                    {
                        Write-Debug "Set post search criteria: Title = '$Title'"
                        If($Update.Title -notmatch $Title)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If $Update.Title -notmatch $Title
                    } #End If $Title -and $UpdateAccess -eq $true

                    If($NotTitle -and $UpdateAccess -eq $true)
                    {
                        Write-Debug "Set post search criteria: NotTitle = '$NotTitle'"
                        If($Update.Title -match $NotTitle)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If $Update.Title -notmatch $NotTitle
                    } #End If $NotTitle -and $UpdateAccess -eq $true

                    If($Severity -and $UpdateAccess -eq $true)
                    {
                        if($Severity -contains "Unspecified") { $Severity += "" } 
                        Write-Debug "Set post search criteria: Severity = '$Severity'"
                        If($Severity -notcontains [String]$Update.MsrcSeverity)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If $Severity -notcontains $Update.MsrcSeverity
                    } #End If $Severity -and $UpdateAccess -eq $true

                    If($NotSeverity -and $UpdateAccess -eq $true)
                    {
                        if($NotSeverity -contains "Unspecified") { $NotSeverity += "" } 
                        Write-Debug "Set post search criteria: NotSeverity = '$NotSeverity'"
                        If($NotSeverity -contains [String]$Update.MsrcSeverity)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If $NotSeverity -contains $Update.MsrcSeverity
                    } #End If $NotSeverity -and $UpdateAccess -eq $true

                    If($MaxSize -and $UpdateAccess -eq $true)
                    {
                        Write-Debug "Set post search criteria: MaxDownloadSize <= '$MaxSize'"
                        If($MaxSize -le $Update.MaxDownloadSize)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If $MaxSize -le $Update.MaxDownloadSize
                    } #End If $MaxSize -and $UpdateAccess -eq $true

                    If($MinSize -and $UpdateAccess -eq $true)
                    {
                        Write-Debug "Set post search criteria: MaxDownloadSize >= '$MinSize'"
                        If($MinSize -ge $Update.MaxDownloadSize)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If $MinSize -ge $Update.MaxDownloadSize
                    } #End If $MinSize -and $UpdateAccess -eq $true
                    
                    If($IgnoreUserInput -and $UpdateAccess -eq $true)
                    {
                        Write-Debug "Set post search criteria: CanRequestUserInput"
                        If($Update.InstallationBehavior.CanRequestUserInput -eq $true)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If $Update.InstallationBehavior.CanRequestUserInput -eq $true
                    } #End If $IgnoreUserInput -and $UpdateAccess -eq $true

                    If($IgnoreRebootRequired -and $UpdateAccess -eq $true) 
                    {
                        Write-Debug "Set post search criteria: RebootBehavior"
                        If($Update.InstallationBehavior.RebootBehavior -ne 0)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End If $Update.InstallationBehavior.RebootBehavior -ne 0    
                    } #End If $IgnoreRebootRequired -and $UpdateAccess -eq $true

                    If($AutoSelectOnly -and $UpdateAccess -eq $true) 
                    {
                        Write-Debug "Set post search criteria: AutoSelectOnWebsites"
                        If($Update.AutoSelectOnWebsites -ne $true)
                        {
                            Write-Debug "UpdateAccess: false"
                            $UpdateAccess = $false
                        } #End $Update.AutoSelectOnWebsites -ne $true
                    } #End $AutoSelectOnly -and $UpdateAccess -eq $true

                    If($UpdateAccess -eq $true)
                    {
                        Write-Debug "Convert size"
                        Switch($Update.MaxDownloadSize)
                        {
                            {[System.Math]::Round($_/1KB,0) -lt 1024} { $size = [String]([System.Math]::Round($_/1KB,0))+" KB"; break }
                            {[System.Math]::Round($_/1MB,0) -lt 1024} { $size = [String]([System.Math]::Round($_/1MB,0))+" MB"; break }  
                            {[System.Math]::Round($_/1GB,0) -lt 1024} { $size = [String]([System.Math]::Round($_/1GB,0))+" GB"; break }    
                            {[System.Math]::Round($_/1TB,0) -lt 1024} { $size = [String]([System.Math]::Round($_/1TB,0))+" TB"; break }
                            default { $size = $_+"B" }
                        } #End Switch
                    
                        Write-Debug "Convert KBArticleIDs"
                        If($Update.KBArticleIDs -ne "")    
                        {
                            $KB = "KB"+$Update.KBArticleIDs
                        } #End If $Update.KBArticleIDs -ne ""
                        Else 
                        {
                            $KB = ""
                        } #End Else $Update.KBArticleIDs -ne ""
                        
                        $Status = ""
                        If($Update.IsDownloaded)    {$Status += "D"} else {$status += "-"}
                        If($Update.IsInstalled)     {$Status += "I"} else {$status += "-"}
                        If($Update.IsMandatory)     {$Status += "M"} else {$status += "-"}
                        If($Update.IsHidden)        {$Status += "H"} else {$status += "-"}
                        If($Update.IsUninstallable) {$Status += "U"} else {$status += "-"}
                        If($Update.IsBeta)          {$Status += "B"} else {$status += "-"} 
        
                        Add-Member -InputObject $Update -MemberType NoteProperty -Name ComputerName -Value $Computer -Force
                        Add-Member -InputObject $Update -MemberType NoteProperty -Name KB -Value $KB -Force
                        Add-Member -InputObject $Update -MemberType NoteProperty -Name Size -Value $size -Force
                        Add-Member -InputObject $Update -MemberType NoteProperty -Name Status -Value $Status -Force
                    
                        $Update.PSTypeNames.Clear()
                        $Update.PSTypeNames.Add('PSWindowsUpdate.WUList')
                        $UpdateCollection += $Update
                    } #End If $UpdateAccess -eq $true
                    
                    $NumberOfUpdate++
                } #End Foreach $Update in $objResults.Updates                
                Write-Progress -Activity "Post search updates for $Computer" -Status "Completed" -Completed
                
                $FoundUpdatesToDownload = $UpdateCollection.count
                Write-Verbose "Found [$FoundUpdatesToDownload] Updates in post search criteria"
                
                #################################
                # End STAGE 1: Get updates list #
                #################################
                
            } #End If Test-Connection -ComputerName $Computer -Quiet
        } #End Foreach $Computer in $ComputerName

        Return $UpdateCollection
        
    } #End Process
    
    End{}        
} #In The End :)