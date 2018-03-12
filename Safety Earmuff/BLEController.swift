//
//  BLEController.swift
//  Safety Earmuff
//
//  Created by Mahmud Ahmad on 3/5/18.
//  Copyright © 2018 Mahmud Ahmad. All rights reserved.
//

import Foundation
//import CoreBluetooth
//
//class BLEController : CBCentralManager {
//    
//    var blePeripheral : CBPeripheral!;
//    var blePeripheralCharacteristic : CBCharacteristic!;
//    let blePeripheralLEDCBUUID : CBUUID = CBUUID(string : "8C08839C-402D-4F4E-B683-5C787EB04E61");
//    var bleCurrentCharacteristicValue : Data!;
//    
//    override func scanForPeripherals(withServices serviceUUIDs: [CBUUID]?, options: [String : Any]? = nil) {
//        self.scanForPeripherals(withServices: nil);
//        
//    }
//    
//    // This is a delegate method of CBCentralManager, it is called when the phones bluetooth state is changed
//    // when it is turned on, it is in state 'powered on'
//    func centralManagerDidUpdateState(_ central: CBCentralManager) {
//        switch central.state {
//        case .unknown:
//            print("Unknown");
//
//        case .unsupported:
//            print("Unsupported");
//
//        case .unauthorized:
//            print("Unauthorized");
//
//        case .resetting:
//            print("Resetting");
//
//        case .poweredOn:
//            print("Powered On");
//            // We tell the CBCentralManager to scan for BLE devices, we do not know the service UUID for our Cyprus chip,
//            // otherwise we could narrow down, and put that as our parameter. Passing nil tells the cetran manager to look
//            // for any bluetooth device
//            self.scanForPeripherals(withServices: nil);
//
//        case .poweredOff:
//            print("Powered Off");
//        }
//    }
//    
//    // This is a delegate method of CBCentralManager, it is called when the phones bluetooth discover a bluetooth device
//    // withServices, from the above call : centralManager.scanForPeripherals iin centralManagerDidUpdateState(...) { ... case .powerOn ... }
//    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
//        // In an ideal world, we would know the UUID of the bluetooth device, and wouldn't need to check the name of the bluetooth device,
//        // this if statement would not be here if that was the case
//        if(peripheral.name == "capled") {
//            // Store the found bluetooth device into our CBPeripheral from the class, and set the delegate to self.
//            // This initializes our CBPeripheral, and allows us to use extentions of our ViewController to call the
//            // delegate methods of CBPeripheral
//            blePeripheral = peripheral;
//            blePeripheral.delegate = self;
//            // Tell CBCentral manager to stop scanning for devices, and conenect to our found peripheral/bluetooth device
//            self.stopScan();
//            self.connect(blePeripheral);
//        }
//    }
//    
//    // This is a delegate method of CBCentralManager, it is called when the phone connects to the CBPeripheral
//    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
//        // Tell the CBPeripheral to discover services, we can tell it to look for specific cerives using a UUID
//        blePeripheral.discoverServices(nil);
//    }
//    
//    override init(delegate: CBCentralManagerDelegate?, queue: DispatchQueue?, options: [String : Any]? = nil) {
//        self.init();
//    }
//    
//    
//}
//
//
//extension BLEController : CBPeripheralDelegate {
//    
//}

