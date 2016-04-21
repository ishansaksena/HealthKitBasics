//
//  FirstViewController.swift
//  HealthBasics
//
//  Created by studentuser on 4/20/16.
//  Copyright © 2016 ishansaksena. All rights reserved.
//

import UIKit
import HealthKit

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Requesting permission to use HealthKit details
        
        let healthStore: HKHealthStore? = {
            if HKHealthStore.isHealthDataAvailable() {
                return HKHealthStore()
            } else {
                return nil
            }
        }()
        
        let dateOfBirthCharacteristic = HKCharacteristicType.characteristicTypeForIdentifier(
            HKCharacteristicTypeIdentifierDateOfBirth)
        
        let biologicalSexCharacteristic = HKCharacteristicType.characteristicTypeForIdentifier(
            HKCharacteristicTypeIdentifierBiologicalSex)
        
        let bloodTypeCharacteristic = HKCharacteristicType.characteristicTypeForIdentifier(
            HKCharacteristicTypeIdentifierBloodType)
        
        let dataTypesToRead = NSSet(objects:dateOfBirthCharacteristic!, biologicalSexCharacteristic!, bloodTypeCharacteristic!)
        
        let dataTypesToShare = NSSet(objects:dateOfBirthCharacteristic!, biologicalSexCharacteristic!, bloodTypeCharacteristic!)
        
        // Closure for healthStore?.requestAuthorizationToShareTypes
        func authorizeHealthKit()
        {
            healthStore?.requestAuthorizationToShareTypes(dataTypesToShare as? Set<HKSampleType>,
             readTypes: dataTypesToRead as? Set<HKObjectType>,
             completion: { (success, error) -> Void in
                if success {
                    print("success")
                } else {
                    print(error!.description)
                }
            })
        }
        authorizeHealthKit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

