$API_KEY= "21cb77cdedae9c7c58ca58dacac0d9e00e043" 
$ACC_EMAIL= "vasu3797@gmail.com"
$ZONE_ID="xyz"
$DOMAIN_URL="example.com"
$CACHE_JPG="/*.jpg*"
$CACHE_SVG="/*.svg*"
$CACHE_GIF="/*.gif*"
$CACHE_CSS="/*.css*"
$CACHE_JS="/*.js*"
$CACHE_WOFF="/*.woff*"
$CACHE_PNG="/*.png*"
$CACHE_JPEG="/*.jpeg*"

$api_uri= "https://api.cloudflare.com/client/v4/"
$user_ext="user"
$user_uri=$api_uri+$user_ext
$pg_ext="zones/$ZONE_ID/pagerules"
$pg_uri=$api_uri+$pg_ext
$headers=  @{
    'X-Auth-Email' = $ACC_EMAIL
    'X-Auth-Key' = $API_KEY  
    'Content-Type' = 'application/json' 
}

$current_dir=(Get-Location)

$Logfile = "C:\Users\vasudevan.perumal\Documents\Cloudflare-PageRules-Automation\$(gc env:computername)_pagerules.log"

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

Function List-UserDets {
    try {
        Write-Host "-----------------User Details--------------------------"
        Invoke-RestMethod -Uri $user_uri -Method Get -Headers $headers | ConvertTo-Json
        LogWrite "VERBOSE - $(Get-Date) - Listing User Details: Cpatured User Details"    
    }
    catch {
        Write-Host "Error Check log file"
        LogWrite "ERROR - $(Get-Date) - Listing User Details: Remote Server Returned an error"
    }
    
}
Function Set-PageRules { 
    $jpg = $DOMAIN_URL + $CACHE_JPG
    $svg = $DOMAIN_URL + $CACHE_SVG
    $gif = $DOMAIN_URL + $CACHE_GIF
    $css = $DOMAIN_URL + $CACHE_CSS
    $js = $DOMAIN_URL + $CACHE_JS
    $woff = $DOMAIN_URL + $CACHE_WOFF
    $png = $DOMAIN_URL + $CACHE_PNG
    $jpeg = $DOMAIN_URL + $CACHE_JPEG

    try {
        $body
        Invoke-RestMethod -Method Post -Uri $pg_uri -Headers $headers -Body $body
    }
    catch {
        LogWrite "ERROR - $(Get-Date) - Setting Page Rules: Remote Server Returned an error"
    }
}

Function List-PgRules {
    try {
        Invoke-RestMethod -Uri $pg_uri -Method Get -Headers $headers  | ConvertTo-Json    
    }
    catch {
        LogWrite "ERROR - $(Get-Date) - Listing Page Rules: Remote Server Returned an error"
    }
    
}
$RESTART = $true
Do {
    Write-Host "-----------Welcome to Page Rules Builder----------------"
    List-UserDets
    
    $EXIT_CONFIRMATION = Read-Host -Prompt "Would you like to exit the program?[y/n]"
    if ($EXIT_CONFIRMATION -match 'y') {
        Write-Host "----------------------------Exiting----------------------------"
        $RESTART=$false
    }else {
        $RESTART=$true
    }
} While ($RESTART) 