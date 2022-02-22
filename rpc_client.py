
import paho.mqtt.client as mqtt
import random
import time


def on_connect(client, userdata, flags, rc):
    client.subscribe('v1/devices/me/rpc/request/+')
    print("Connected with result code "+str(rc))
    
def on_message(client, userdata, msg):
    #print(msg.topic+'\n'+'\n'+'\n')
    requestId = msg.topic[26:]
    client.publish(f'v1/devices/me/rpc/response/{requestId}',payload='{"name":"fan","value":"off"}',qos=2,retain=False)
    print("message"+msg.topic+" "+str(msg.payload))

def mqttys(un):
    dev_client = mqtt.Client()
    dev_client.username_pw_set(un,password=None)
    dev_client.on_connect = on_connect
    dev_client.on_message = on_message

    dev_client.connect("localhost", 1883, 60)
    dev_client.loop_start()
    return dev_client




while True:

    mqttys('hhf9x5hWi5yDnGMAyCTx')
    time.sleep(1)
    mqttys('0pPmsEwx0yq9DLFkr8Es')
    time.sleep(2)
    mqttys('VvRYDgvzHshO72vcpp19')
    time.sleep(2)
    mqttys('zwpp5zbg0Ye7JO6yjX9K')
    time.sleep(5)









'''

dht11_client = mqtt.Client()
dht11_client.username_pw_set('hhf9x5hWi5yDnGMAyCTx',password=None)
dht11_client.connect("localhost", 1883, 60)
dht11_client.loop_start()


def on_connect(client, userdata, flags, rc):
    dht11_client.subscribe('v1/devices/me/rpc/request/+')
    print("Connected with result code "+str(rc))
    
def on_message(client, userdata, msg):
    #print(msg.topic+'\n'+'\n'+'\n')
    requestId = msg.topic[26:]
    dht11_client.publish(f'v1/devices/me/rpc/response/{requestId}',payload='{"value":"changed"}',qos=2,retain=False)
    print("message"+msg.topic+" "+str(msg.payload))

dht11_client.on_connect = on_connect
dht11_client.on_message = on_message







def mqttys(un):
    dev_client = mqtt.Client()
    dev_client.username_pw_set(un,password=None)
    dev_client.on_connect = on_connect
    #dev_client.on_message = on_message

    dev_client.connect("localhost", 1883, 60)
    dev_client.loop_start()
    return dev_client




#time.sleep(2)
'''
