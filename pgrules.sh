export API_KEY=21cb77cdedae9c7c58ca58dacac0d9e00e043
export ACC_EMAIL=vasu3797@gmail.com
export DOMAIN_ZONE=xyz # fill in in Domain of the endpoint domain

curl -X GET "https://api.cloudflare.com/client/v4/user" -H "X-Auth-Email: $ACC_EMAIL" -H "X-Auth-Key: $API_KEY" \
    -H "Content-Type: application/json" >> output.json



