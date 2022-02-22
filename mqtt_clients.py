import paho.mqtt.client as mqtt
import random
import time

def on_connect(client, userdata, flags, rc):
    print("Connected with result code "+str(rc))

    client.subscribe("$SYS/#")

def on_message(client, userdata, msg):
    print(msg.topic+" "+str(msg.payload))





def mqttys(un):
    dev_client = mqtt.Client()
    dev_client.username_pw_set(un,password=None)
    dev_client.on_connect = on_connect
    dev_client.on_message = on_message

    dev_client.connect("localhost", 1883, 60)
    dev_client.loop_start()
    return dev_client


while True:

    mqttys('hhf9x5hWi5yDnGMAyCTx').publish('v1/devices/me/telemetry', payload=f'{{"temperature":{random.randint(10,70)},"humidity":{random.randint(25,50)}}}', qos=2, retain=False)
    time.sleep(1)
    mqttys('0pPmsEwx0yq9DLFkr8Es').publish('v1/devices/me/telemetry', payload=f'{{"moisture":{random.randint(50,100)}}}', qos=2, retain=False)
    time.sleep(2)
    mqttys('VvRYDgvzHshO72vcpp19').publish('v1/devices/me/telemetry', payload=f'{{"water":{random.randint(60,100)}}}', qos=2, retain=False)
    time.sleep(2)
    mqttys('zwpp5zbg0Ye7JO6yjX9K').publish('v1/devices/me/telemetry', payload=f'{{"light":{random.randint(450,650)}}}', qos=2, retain=False)
    time.sleep(5)





# dht11_client = mqtt.Client()
# dht11_client.username_pw_set('P2Ox8oZOzucLvFKRcZUr',password=None)
# dht11_client.on_connect = on_connect
# dht11_client.on_message = on_message

# dht11_client.connect("localhost", 1883, 60)
# dht11_client.loop_start()
# while True:

#     dht11_client.publish('v1/devices/me/telemetry', payload=f'{{"temperature":{random.randint(3,70)},"humidity":{random.randint(3,70)}}}', qos=2, retain=False)

#     time.sleep(5)




# print(f'{{"temperature":{random.randint(3,70)},"humidity":{random.randint(3,70)}}}')
#'{"temperature":'+str(random.randint(3,70))+',"humidity":'+ str(random.randint(3,70))+'}'
