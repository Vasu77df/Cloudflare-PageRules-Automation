
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
$pg_ext="zones/$ZONE_ID/pagerules"
$headers=  @{
    'X-Auth-Email' = $ACC_EMAIL
    'X-Auth-Key' = $API_KEY  
    'Content-Type' = 'application/json' 
}

function List-UserDets {
    Invoke-RestMethod -Uri $api_uri -Method Get -Headers $headers
}
function Set-PageRules { 

}

function List-PgRules {
    Invoke-RestMethod -Uri $api_uri+$pg_ext -Method Get -Headers $headers  | ConvertTo-Json
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