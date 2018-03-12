//
//  ViewController.swift
//  Safety Earmuff
//
//  Created by Mahmud Ahmad on 2/5/18.
//  Copyright © 2018 Mahmud Ahmad. All rights reserved.
//

/*
 
    ADAFruit BLE wants ASCII
 
 */
 

import UIKit
import CoreBluetooth

class ViewController: UIViewController {
    // LOCAL VARIABLES
    
    // Define a CBCentralManager, which will allow the phone to connect to a BLE Devices
    var centralManager : CBCentralManager!;
    // Define a CBPeripheral, the BLE Device that the phone will connect to
    var ble : CBPeripheral!;
    // Define a CBCharacteristic that controls the LED, used when writing to BLE
    var bleCharacteristic : CBCharacteristic!;
    
    let toggleLEDUUID = CBUUID(string: "6E400002-B5A3-F393-E0A9-E50E24DCCA9E"/*"8C08839C-402D-4F4E-B683-5C787EB04E61"*/);
    
    var currentCharacteristicValue : Data!;
    // IB OUTLETS
    
    // IB FUNCTIONS
    
    @IBAction func toggleLED(_ sender: Any) {
//        let dataZero : Data = Data.init(bytes: [0]);
//        let dataOne : Data = Data.init(bytes: [1]);
//        ble.readValue(for: bleCharacteristic);
//        if(currentCharacteristicValue == dataZero) {
//            ble.writeValue(dataZero, for: bleCharacteristic, type: CBCharacteristicWriteType.withoutResponse);
//        } else {
//            ble.writeValue(dataZero, for: bleCharacteristic, type: CBCharacteristicWriteType.withResponse);
//        }
    }
    
    @IBAction func ledONAdaFruit(_ sender: Any) {
        let dataOneASCII : Data = Data.init(bytes: [49]);
        ble.writeValue(dataOneASCII, for: bleCharacteristic, type: CBCharacteristicWriteType.withoutResponse);
        
    }
    
    @IBAction func ledOFFAdaFruit(_ sender: Any) {
        let dataZeroASCII : Data = Data.init(bytes: [48]);
        ble.writeValue(dataZeroASCII, for: bleCharacteristic, type: CBCharacteristicWriteType.withoutResponse);
    }
    
    @IBAction func emerONAdaFruit(_ sender: Any) {
        let dataEmergencyASCII : Data = Data.init(bytes: [101]);
        ble.writeValue(dataEmergencyASCII, for: bleCharacteristic, type: CBCharacteristicWriteType.withoutResponse);
    }
    
    @IBAction func dangONAdaFruit(_ sender: Any) {
        let dataDangerASCII : Data = Data.init(bytes: [100]);
        ble.writeValue(dataDangerASCII, for: bleCharacteristic, type: CBCharacteristicWriteType.withoutResponse);
    }
    
    @IBAction func fireONAdaFruit(_ sender: Any) {
        let dataFireASCII : Data = Data.init(bytes: [102]);
        ble.writeValue(dataFireASCII, for: bleCharacteristic, type: CBCharacteristicWriteType.withoutResponse);
    }
    
    
    
    
    
    
    
    // SUPERCLASS FUNCTIONS THAT ARE OVERRIDDEN
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Initialise our CBCentralManager
        // Set delegate to self, so we can use extentions to call the delegate methods of CBCentralManager
        centralManager = CBCentralManager(delegate: self, queue: nil);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

// Exntention of our ViewController that allows us to sue CBCentralManager delegate methods
extension ViewController : CBCentralManagerDelegate {
    // This is a delegate method of CBCentralManager, it is called when the phones bluetooth state is changed
    // when it is turned on, it is in state 'powered on'
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .unknown:
            print("Unknown");
            
        case .unsupported:
            print("Unsupported");
            
        case .unauthorized:
            print("Unauthorized");
            
        case .resetting:
            print("Resetting");
            
        case .poweredOn:
            print("Powered On");
            // We tell the CBCentralManager to scan for BLE devices, we do not know the service UUID for our Cyprus chip,
            // otherwise we could narrow down, and put that as our parameter. Passing nil tells the cetran manager to look
            // for any bluetooth device
            centralManager.scanForPeripherals(withServices: nil);
            
        case .poweredOff:
            print("Powered Off");
        }
    }
    
    // This is a delegate method of CBCentralManager, it is called when the phones bluetooth discover a bluetooth device
    // withServices, from the above call : centralManager.scanForPeripherals iin centralManagerDidUpdateState(...) { ... case .powerOn ... }
    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        // In an ideal world, we would know the UUID of the bluetooth device, and wouldn't need to check the name of the bluetooth device,
        // this if statement would not be here if that was the case
        // Chagne the .name == "LIGHT" to "capled" for Cyprus, "LIGHT" is for ADAFruit
        if(peripheral.name == "LIGHT") {
            // Store the found bluetooth device into our CBPeripheral from the class, and set the delegate to self.
            // This initializes our CBPeripheral, and allows us to use extentions of our ViewController to call the
            // delegate methods of CBPeripheral
            ble = peripheral;
            ble.delegate = self;
            // Tell CBCentral manager to stop scanning for devices, and conenect to our found peripheral/bluetooth device
            centralManager.stopScan();
            centralManager.connect(ble);
        }
//        print(peripheral.name);
    }
    
    // This is a delegate method of CBCentralManager, it is called when the phone connects to the CBPeripheral
    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        // Tell the CBPeripheral to discover services, we can tell it to look for specific cerives using a UUID
        ble.discoverServices(nil);
    }
    
}

// Exntention of our ViewController that allows us to sue CBPeripheral delegate methods
extension ViewController : CBPeripheralDelegate {
    // Delegate method called when the CBPeripheral discovers services, uses the options we give it from oru above call
    // in centralManager(... didConnect...)
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
        // TODO : Read up on guards. I think it is a way to unwrap optionals
        // get the services for our peripheral fron our above call
        guard let services = peripheral.services else { return };
        
        // Loop through the available services
        for service in services {
            print(service);
            // Telling CBPeripheral to discover any characteristics of a service. In this case, the service we happen upon
            // from for loop
            peripheral.discoverCharacteristics(nil, for: service);
        }
    }
    
    // Delegate method called when our CBPeripheral discovers characteristics for a specific service, after we tell it to
    // discover servies in peripheral(... didDiscoverServices...);
    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        // TODO : Read up on guards. I think it is a way to unwrap optionals
        // get the characteristics for our service from our above call of discoverCharacteristics
        guard let characteristics = service.characteristics else { return };
        // Loop through available characteristics
        for characteristic in characteristics {
            print(characteristic);
            // This is for Cyprus
//            if(characteristic.properties.contains(.write)) {
//                print("\(characteristic.uuid): contains .write");
//                bleCharacteristic = characteristic;
//                peripheral.readValue(for: characteristic);
//            }
            
            // This is for ADAFruit
            if(characteristic.properties.contains(.writeWithoutResponse)) {
                print("\(characteristic.uuid): contains .writeWithoutResponse");
                bleCharacteristic = characteristic;
                peripheral.readValue(for: characteristic);
            }
        }
        
    }
    
    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        switch characteristic.uuid {
            case toggleLEDUUID:
                currentCharacteristicValue = characteristic.value;
            default:
                print("Invalid UUID")
        }
    }
}

















