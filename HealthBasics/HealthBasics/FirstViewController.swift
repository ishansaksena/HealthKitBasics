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
        
        let dataTypesToShare = NSSet()
        
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
        
        // Getting characteristics
        // Getting date of birth of user
        
        let dateFormatter: NSDateFormatter = {
            let formatter = NSDateFormatter()
            formatter.dateStyle = .LongStyle
            return formatter
        }()
        
        var dateOfBirth: String? {
            /*if let dateOfBirth = healthStore?.dateOfBirth() {
                return dateFormatter.stringFromDate(dateOfBirth)
            }
            return nil*/
            do {
                let birthday = try healthStore?.dateOfBirth()
                return dateFormatter.stringFromDate(birthday!)
            } catch let error as ErrorType {
                print(error)
            }
            return nil
        }
        
        // Asking for gender
        var biologicalSex: String? {
            do {
                let biologicalSex = try healthStore?.biologicalSex()
                switch biologicalSex!.biologicalSex {
                case .Female:
                    return "Female"
                case .Male:
                    return "Male"
                case .Other:
                    return "Other"
                case .NotSet:
                    return nil
                }
            } catch let error as NSError {
                print(error.description)
            } catch let error as ErrorType {
                print(error)
            }
            return nil
        }
        
        // Getting bloodtype
        var bloodType: String? {
            do {
                let bloodType = try healthStore?.bloodType()
                switch bloodType!.bloodType {
                case .APositive:
                    return "A+"
                case .ANegative:
                    return "A-"
                case .BPositive:
                    return "B+"
                case .BNegative:
                    return "B-"
                case .ABPositive:
                    return "AB+"
                case .ABNegative:
                    return "AB-"
                case .OPositive:
                    return "O+"
                case .ONegative:
                    return "O-"
                case .NotSet:
                    return nil
                }
            } catch let error as ErrorType {
                print(error)
            }
            return nil
        }
        
        // Printing results
        NSLog(dateOfBirth!)
        NSLog(biologicalSex!)
        NSLog(bloodType!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

