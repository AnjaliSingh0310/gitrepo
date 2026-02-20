# this works

import httpx

def make_post_request_httpx():
    url = "https://10.10.70.142:443/ProductUI/productSummary/gitRepositoryService/gitCommit?cavToken=W3sibmFtZSI6Ik1hc3RlciIsImNhdlRva2VuIjoiVExKUUk0ZmZ5Mmo4TWF0MWZwOFhkbzM2VHRMRnNmb3lyMDdRdFphRkdHRXNHdWhLbjJyVkQ1JTJGY1JLVVdTa2FQdXZUSGlLTEs1b1RRZnZDTG1Md3JIaHozOHFucSUyQlM1eG16YXA3N3RNR3cxR0J2Rzk0VllHOTZRUk9CUHFxb0lsJTJGRUFKRjNranBINDVCaXdEZGklMkJmSXowYVFaM1VCaEpoV1UzYiUyRndxcUc0dyUzRCJ9XQ=="  # Test endpoint

    payload = {"repo":"scripts","comment":"AI_SCRIPT","files":"/home/cavisson/work/workspace/Anjali/GITT/cavisson/default/default/scripts/.amazon_search_blue_jukebox_1_Group_1","productType":"ND","aclUser":"Anjali","passValue":"VnyyPEC1pVRcbR+nzS8MJm7UVblF4qsFgGS3/VhfoRfwTPP1iQCvWHB9sEilG7/Zn7DjpXWWT1LNk9cxZsiLxXO/VubX4K7TxhMtv/76v7ag/RhuVDrcVhEPNBSZMFv9fIAjWT5SucYPQU1kbdnSnrJ44N9nZ987weVQafjUOjI=","passType":"0","activeProfile":"GITT"}

    headers = {
        "Content-Type": "application/json"
    }

    try:
        with httpx.Client(http2=False,verify=False,timeout=30.0) as client:
            response = client.post(url, json=payload, headers=headers)
        print("req headers httpx:", response.request.headers)
        print("Response headers httpx:", response.headers)
        print("Response content httpx:", response.content)
        print("Status Code httpx:", response.status_code)
        print("Response JSON httpx:")
        print(response.text)

    except httpx.HTTPError as e:
        print("Request failed:", str(e))

# this doesn't work and gives read time out error even after 180 sec
import requests

def make_post_request():
    url = "https://10.10.70.142:443/ProductUI/productSummary/gitRepositoryService/gitCommit?cavToken=W3sibmFtZSI6Ik1hc3RlciIsImNhdlRva2VuIjoiVExKUUk0ZmZ5Mmo4TWF0MWZwOFhkbzM2VHRMRnNmb3lyMDdRdFphRkdHRXNHdWhLbjJyVkQ1JTJGY1JLVVdTa2FQdXZUSGlLTEs1b1RRZnZDTG1Md3JIaHozOHFucSUyQlM1eG16YXA3N3RNR3cxR0J2Rzk0VllHOTZRUk9CUHFxb0lsJTJGRUFKRjNranBINDVCaXdEZGklMkJmSXowYVFaM1VCaEpoV1UzYiUyRndxcUc0dyUzRCJ9XQ=="  # Test endpoint

    payload = {"repo":"scripts","comment":"AI_SCRIPT","files":"/home/cavisson/work/workspace/Anjali/GITT/cavisson/default/default/scripts/.amazon_search_blue_jukebox_1_Group_1","productType":"ND","aclUser":"Anjali","passValue":"VnyyPEC1pVRcbR+nzS8MJm7UVblF4qsFgGS3/VhfoRfwTPP1iQCvWHB9sEilG7/Zn7DjpXWWT1LNk9cxZsiLxXO/VubX4K7TxhMtv/76v7ag/RhuVDrcVhEPNBSZMFv9fIAjWT5SucYPQU1kbdnSnrJ44N9nZ987weVQafjUOjI=","passType":"0","activeProfile":"GITT"}

    headers = {
        "Content-Type": "application/json",
         'accept': '*/*', 'accept-encoding': 'gzip, deflate, br, zstd', 'connection': 'keep-alive'

    }

    try:
        response = requests.post(url, json=payload, headers=headers, timeout=(10,120), verify=False, stream=True, proxies={})
        print("req headers:", response.request.headers)
        print("Response headers:", response.headers)
        print("Response content:", response.content)
        print("Status Code req:", response.status_code)
        print("Response JSON req:")
        print(response.text)

    except requests.exceptions.RequestException as e:
        print("Request failed:", str(e))


if __name__ == "__main__":
    #make_post_request_httpx()
    make_post_request()
