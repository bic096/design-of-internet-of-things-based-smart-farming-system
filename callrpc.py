import sys
import requests
import json
jwt = 'Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJ0ZW5hbnRAdGhpbmdzYm9hcmQub3JnIiwic2NvcGVzIjpbIlRFTkFOVF9BRE1JTiJdLCJ1c2VySWQiOiI0OGY4MjQ0MC1iMGQwLTExZWItODBkNi1lNzlmZGIwMTNmNTAiLCJlbmFibGVkIjp0cnVlLCJpc1B1YmxpYyI6ZmFsc2UsInRlbmFudElkIjoiNDgzZjBkNzAtYjBkMC0xMWViLTgwZDYtZTc5ZmRiMDEzZjUwIiwiY3VzdG9tZXJJZCI6IjEzODE0MDAwLTFkZDItMTFiMi04MDgwLTgwODA4MDgwODA4MCIsImlzcyI6InRoaW5nc2JvYXJkLmlvIiwiaWF0IjoxNjMzOTkxNTk2LCJleHAiOjE2MzQwMDA1OTZ9.BkRi12r2TvzWfAzDG5VVXtUp1D1oWKXrJinyFdPASJxtiykNQEhwdPBWriWNXH2Y-oWw1pqZ78rP3oJ9xWt4wQ'
DEVICE_ID='484b9420-264e-11ec-a257-5564d1017c12'
body={"method":"setGpio","params":
      {"pin":"23"},"timeout":20000}
def rpccall():
    url = 'http://localhost:8080/api/plugins/rpc/twoway/205d9f80-b187-11eb-8337-d185831eb35d'
    headers = {'Content-Type':'application/json', 'Accept':'application/json','X-Authorization':f"{jwt}"}
    tokenAuthResp = requests.post(url, headers=headers,json=body)
    print(tokenAuthResp)

rpccall()
#body2={"mode":"aut"}
#def attriChang():
#    url = 'http://localhost:8080/api/plugins/telemetry/ASSET/b89c12f0-20ad-11ec-9161-932316a31a3e/SERVER_SCOPE'
#    headers = {'Content-Type':'application/json', 'Accept':'application/json','X-Authorization':f"{jwt}"}
#    tokenAuthResp = requests.post(url, headers=headers,json=body2)
#    print(tokenAuthResp)
#attriChang()
