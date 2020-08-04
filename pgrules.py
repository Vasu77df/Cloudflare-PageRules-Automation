import json 
import requests
import logging

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
    param = domain_url + cache_param
    data = {"targets":[{"target":"url","constraint":{"operator":"matches","value": param}}],"actions":[{"id":"always_online","value":"on"}],"priority":1,"status":"active"}
    response = requests.get(f"https://api.cloudflare.com/client/v4/zones/{zone_id}/pagerules", data=data, headers = {'X-Auth-Email': acc_email, 'X-Auth-Key': api_key, 'Content-Type': 'application/json'})
    return response

def cache_selector(api_key, acc_email, zone_id, domain_url, cred_data):
    jpg_cache = cred_data["CACHE_JPG"]
    svg_cache = cred_data["CACHE_SVG"]
    gif_cache = cred_data["CACHE_GIF"]
    html_cache = cred_data["CACHE_HTML"]
    opt = input("Do you wanna cache 'jpg' files?(y/n): ")
    if opt == 'y' or opt == 'Y':
        set_pgrules(api_key, acc_email, zone_id, domain_url, cache_param=jpg_cache)
        logging.info('Jpg Page Rule added')
    else:
        logging.info('Jpg Page Rule Not added')
    
    opt = input("Do you wanna cache 'svg' files?(y/n): ")
    if opt == 'y' or opt == 'Y':
        set_pgrules(api_key, acc_email, zone_id, domain_url, cache_param=svg_cache)
        logging.info('Svg Page Rule added')
    else:
        logging.info('Svg Page Rule Not added')
    
    opt = input("Do you wanna cache 'gif' files?(y/n): ")
    if opt == 'y' or opt == 'Y':
        set_pgrules(api_key, acc_email, zone_id, domain_url, cache_param=gif_cache)
        logging.info('Gif Page Rule added')
    else:
        logging.info('Gif Page Rule Not added')
    
    opt = input("Do you wanna cache 'html' files?(y/n): ")
    if opt == 'y' or opt == 'Y':
        set_pgrules(api_key, acc_email, zone_id, domain_url, cache_param=html_cache)
        logging.info('Html Page Rule added')
    else:
        logging.info('Html Page Rule Not added')

def main():
    with open('credentials.json') as json_file:
        cred_data = json.load(json_file)
        api_key = cred_data["API_KEY"]
        acc_email = cred_data["ACC_EMAIL"]
        acc_id = cred_data["ACC_ID"]
        zone_id = cred_data["ZONE_ID"]
        domain_url = cred_data["DOMAIN_URL"]
        cache_selector(api_key, acc_email, zone_id, domain_url, cred_data)
        dets = user_details(api_key, acc_email)
    with open("ouput.json", "w") as out:
        print(json.dumps(dets, indent=4))
        json.dump(dets, out, indent=4)

if __name__ == "__main__":
    main()

