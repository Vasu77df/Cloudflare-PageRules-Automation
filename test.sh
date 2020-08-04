export API_KEY=21cb77cdedae9c7c58ca58dacac0d9e00e043
export ACC_EMAIL=vasu3797@gmail.com
export ACCOUNT_ID=48773ba1335af750ade5f50033b70ed4 
export ZONE_ID=xyz
export DOMAIN_URL=example.com
# Getting User Details 
curl -X GET "https://api.cloudflare.com/client/v4/user" \
    -H "X-Auth-Email: $ACC_EMAIL" \
    -H "X-Auth-Key: $API_KEY" \
    -H "Content-Type: application/json" | python3 -m json.tool

# Getting Zones
curl -X GET "https://api.cloudflare.com/client/v4/zones" \
    -H "X-Auth-Email: $ACC_EMAIL" \
    -H "X-Auth-Key: $API_KEY" \
    -H "Content-Type: application/json" | python3 -m json.tool

# Listing All Page Rules 
curl -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/pagerules" \
    -H "X-Auth-Email: $ACC_EMAIL" \
    -H "X-Auth-Key: $API_KEY" \
    -H "Content-Type: application/json" | python3 -m json.tool

# Creating a Page Rule
curl -X POST "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/pagerules" \
    -H "X-Auth-Email: $ACC_EMAIL" \
    -H "X-Auth-Key: $API_KEY" \
    -H "Content-Type: application/json" \
    --data '{"targets":[{"target":"url","constraint":{"operator":"matches","value":"*example.com/*.jpg*"}}],"actions":[{"id":"always_online","value":"on"}],"priority":1,"status":"active"}'








