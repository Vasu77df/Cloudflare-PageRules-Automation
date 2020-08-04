import json 
import requests
import logging 
import pprint

logging.basicConfig(filename='PGRULES.log', filemode='w', format='%(name)s - %(levelname)s - %(message)s', level=logging.DEBUG)

def user_details(api_key, acc_email):
    response = requests.get("https://api.cloudflare.com/client/v4/user", headers = {'X-Auth-Email': acc_email, 'X-Auth-Key': api_key, 'Content-Type': 'application/json'})
    user_dets = json.loads(response.text)
    return user_dets

def list_zones(api_key, acc_email):
    response = requests.get("https://api.cloudflare.com/client/v4/zones", headers = {'X-Auth-Email': acc_email, 'X-Auth-Key': api_key, 'Content-Type': 'application/json'})
    zones = json.loads(response.text)
    return zones

def list_pgrules(api_key, acc_email, zone_id):
    response = requests.get(f"https://api.cloudflare.com/client/v4/zones/{zone_id}/pagerules", headers = {'X-Auth-Email': acc_email, 'X-Auth-Key': api_key, 'Content-Type': 'application/json'})
    pgrules = json.loads(response.text)
    return pgrules

def set_pgrules(api_key, acc_email, zone_id, domain_url, cache_param):
    for i in cache:
        param = domain_url + i
        data = {"targets":[{"target":"url","constraint":{"operator":"matches","value": param}}],"actions":[{"id":"always_online","value":"on"}],"priority":1,"status":"active"}
        response = requests.get(f"https://api.cloudflare.com/client/v4/zones/{zone_id}/pagerules", data=data, headers = {'X-Auth-Email': acc_email, 'X-Auth-Key': api_key, 'Content-Type': 'application/json'})
    
    return response

def main():
    with open('credentials.json') as json_file:
        pp = pprint.PrettyPrinter(indent=4)
        data = json.load(json_file)
        api_key = data["API_KEY"]
        acc_email = data["ACC_EMAIL"]
        acc_id = data["ACC_ID"]
        zone_id = data["ZONE_ID"]
        domain_url = data["DOMAIN_URL"]
        dets = user_details(api_key, acc_email)
    with open("ouput.json", "w") as out:
        print(json.dumps(dets, indent=4))
        json.dump(dets, out, indent=4)

if __name__ == "__main__":
    main()

