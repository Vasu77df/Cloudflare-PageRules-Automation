
$API_KEY= "21cb77cdedae9c7c58ca58dacac0d9e00e043" 
$ACC_EMAIL= "vasu3797@gmail.com"
$ZONE_ID="xyz"
$DOMAIN_URL="example.com"

function List-Usr{
    Invoke-RestMethod -Uri ""
}
function Set-PageRules { 
    Invoke-RestMethod -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/pagerules"  -H "X-Auth-Email: $ACC_EMAIL" \
    -H "X-Auth-Key: $API_KEY" \
    -H "Content-Type: application/json" \
    --data '{"targets":[{"target":"url","constraint":{"operator":"matches","value":"*example.com/*.jpg*"}}],"actions":[{"id":"always_online","value":"on"}],"priority":1,"status":"active"}'

}

function List-PgRules {
    Invoke-RestMethod -Uri "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/pagerules" -Method Post -Headers @{"X-Auth-Email" = $ACC_EMAIL ; "X-Auth-Key" = $API_KEY ; "Content-Type" = "application/json" }    
}
$RESTART = $true
Do {
    Write-Host "-----------Welcome to Page Rules Builder----------------"
    List-PageRules  
    
    
    
    $EXIT_CONFIRMATION = Read-Host -Prompt "Would you like to exit the program?[y/n]"
    if ($EXIT_CONFIRMATION -match 'y') {
        Write-Host "----------------------------Exiting----------------------------"
        $RESTART=$false
        Start-Sleep -Seconds 5
    }else {
        $RESTART=$true
    }
    } While ($RESTART) 