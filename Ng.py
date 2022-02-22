import sys
import requests
import json

def getToken():
    url = 'http://127.0.0.1:8080/api/auth/login'
    headers = {'Content-Type': 'application/json', 'Accept': 'application/json'}
    loginJSON = {'username': 'tenant@thingsboard.org', 'password': 'tenant'}
    tokenAuthResp = requests.post(url, headers=headers, json=loginJSON).json()
    token = tokenAuthResp['token']
    return token

print(getToken())


