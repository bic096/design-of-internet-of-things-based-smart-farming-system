const uri = 'ws://192.168.43.252:8080/api/ws/plugins/telemetry?token=';

///[the base url of the app ]
// const host = '192.168.43.69'; //note 9
// const host = '192.168.43.252'; //note 5 wifi
// const host = '192.168.43.69'; //yasser phone wifi
const host = '192.168.43.243'; //yasser phone and lap
// const host = '127.0.0.1'; //chrome debuging
// const host = '192.168.154.77'; //ms phone wifi

final dht11Payload = {
  "tsSubCmds": [
    {
      "entityType": "DEVICE",
      "entityId": dhtSensor['ID'],
      "cmdId": 1,
      "keys": "temperature,humidity",
    }
  ],
  "historyCmds": [],
  "attrSubCmds": []
};
final moisturePayload = {
  "tsSubCmds": [
    {
      "entityType": "DEVICE",
      "entityId": moisSensor['ID'],
      "cmdId": 2,
      "keys": "moisture",
    }
  ],
  "historyCmds": [],
  "attrSubCmds": []
};
final ldrPayload = {
  "tsSubCmds": [
    {
      "entityType": "DEVICE",
      "entityId": lightSensor['ID'],
      "cmdId": 3,
      "keys": "light",
    }
  ],
  "historyCmds": [],
  "attrSubCmds": []
};
final waterPayload = {
  "tsSubCmds": [
    {
      "entityType": "DEVICE",
      "entityId": waterSensor['ID'],
      "cmdId": 4,
      "keys": "water",
    }
  ],
  "historyCmds": [],
  "attrSubCmds": []
};

enum Devices {
  TEMPERATURE_SENSOR,
  HUMIDITY_SENSOR,
  MOISTURE_SENSOR,
  WATER_SENSOR,
  FAN,
  PUMP,
  MOTOR,
  LAMP,
}

enum RequestStatus { SUCCESS, FAILED, BENDING, IDEL }

Map startFan = {"method": "startFan", "params": {}, "timeout": 20000};
Map stopFan = {"method": "stopFan", "params": {}, "timeout": 20000};
Map startPump = {"method": "startPump", "params": {}, "timeout": 20000};
Map stopPump = {"method": "stopPump", "params": {}, "timeout": 20000};
Map startLamp = {"method": "startLamp", "params": {}, "timeout": 20000};
Map stopLamp = {"method": "stopLamp", "params": {}, "timeout": 20000};
Map startMotor = {"method": "startMotor", "params": {}, "timeout": 20000};
Map stopMotor = {"method": "stopMotor", "params": {}, "timeout": 20000};

// ///ASSET ID
// ///my laptop
// const assetId = 'b89c12f0-20ad-11ec-9161-932316a31a3e';
// //my laptop
// const fan = {
//   "ID": '484b9420-264e-11ec-a257-5564d1017c12',
//   "token": 'EMacgNpnAQQR0aEgOiXQ'
// };
// const dhtSensor = {
//   "ID": '205d9f80-b187-11eb-8337-d185831eb35d',
//   "token": 'hhf9x5hWi5yDnGMAyCTx'
// };
// const moisSensor = {
//   "ID": '727da3f0-b187-11eb-8337-d185831eb35d',
//   "token": '0pPmsEwx0yq9DLFkr8Es'
// };
// const waterSensor = {
//   "ID": 'f4025660-b186-11eb-8337-d185831eb35d',
//   "token": 'VvRYDgvzHshO72vcpp19'
// };
// const lightSensor = {
//   "ID": '0a39bef0-b187-11eb-8337-d185831eb35d',
//   "token": 'zwpp5zbg0Ye7JO6yjX9K'
// };

// const pump = {
//   "ID": '143342f0-266c-11ec-a257-5564d1017c12',
//   "token": '0WiWPDvqX8xgwSXhQteo'
// };
// const lamp = {
//   "ID": '0ef3e0b0-266c-11ec-a257-5564d1017c12',
//   "token": 'L1VGfoNMmjdJshBRIohN'
// };
// const motor = {
//   "ID": '059d4880-266c-11ec-a257-5564d1017c12',
//   "token": 'bDatZ4NU9noh83vtCMnX'
// };

dynamic profileInfo = [
  {
    "id": 1,
    "name": "Gumbo",
    "data": {
      "tempLow": 21,
      "tempHight": 31,
      "humidityLow": 30,
      "humidityHight": 50,
      "lightTimeLow": 8,
      "lightTimeHight": 14,
      "moistureLow": 4,
      "moistureHight": 5
    }
  },
  {
    "id": 2,
    "name": "Tomato",
    "data": {
      "tempLow": 25,
      "tempHight": 30,
      "humidityLow": 60,
      "humidityHight": 65,
      "lightTimeLow": 7,
      "lightTimeHight": 17,
      "moistureLow": 5,
      "moistureHight": 6
    }
  },
  {
    "id": 3,
    "name": "Eggplant",
    "data": {
      "tempLow": 21,
      "tempHight": 30,
      "humidityLow": 30,
      "humidityHight": 50,
      "lightTimeLow": 8,
      "lightTimeHight": 14,
      "moistureLow": 4,
      "moistureHight": 5
    }
  },
  {
    "id": 4,
    "name": "Watercress",
    "data": {
      "tempLow": 10,
      "tempHight": 22,
      "humidityLow": 50,
      "humidityHight": 70,
      "lightTimeLow": 8,
      "lightTimeHight": 14,
      "moistureLow": 5,
      "moistureHight": 6
    }
  }
];

//yasser
const fan = {
  "ID": 'daad2440-6e4d-11ec-b602-6b11b9ab0d75',
  "token": 'EMacgNpnAQQR0aEgOiXQ'
};
const dhtSensor = {
  "ID": 'f1ace5e0-6e4d-11ec-b602-6b11b9ab0d75',
  "token": 'hhf9x5hWi5yDnGMAyCTx'
};
const moisSensor = {
  "ID": 'e8168590-6e4d-11ec-b602-6b11b9ab0d75',
  "token": '0pPmsEwx0yq9DLFkr8Es'
};
const waterSensor = {
  "ID": '0088ea00-6e4e-11ec-b602-6b11b9ab0d75',
  "token": 'VvRYDgvzHshO72vcpp19'
};
const lightSensor = {
  "ID": 'f93e4e70-6e4d-11ec-b602-6b11b9ab0d75',
  "token": 'zwpp5zbg0Ye7JO6yjX9K'
};

const pump = {
  "ID": 'b16e83e0-927d-11ec-96b1-d9c31cc0d69c',
  "token": '0WiWPDvqX8xgwSXhQteo'
};
const lamp = {
  "ID": 'c9677320-6e4d-11ec-b602-6b11b9ab0d75',
  "token": 'L1VGfoNMmjdJshBRIohN'
};
const motor = {
  "ID": 'd133e8e0-6e4d-11ec-b602-6b11b9ab0d75',
  "token": 'bDatZ4NU9noh83vtCMnX'
};

// yasser lap
const assetId = 'e1123740-6e4c-11ec-b602-6b11b9ab0d75';
