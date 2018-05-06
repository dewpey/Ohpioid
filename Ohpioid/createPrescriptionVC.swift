//
//  createPrescriptionVC.swift
//  Ohpioid
//
//  Created by Drew Patel on 5/5/18.
//  Copyright © 2018 Drew Patel. All rights reserved.
//

import UIKit
import Eureka
import Alamofire

class createPrescriptionVC: FormViewController {

    var patientSeedName: String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section("Section1")
            <<< TextRow("RXName"){ row in
                row.title = "Prescription Name"
                row.placeholder = "Fentantyl"
            }
            <<< IntRow("Quantity"){
                $0.title = "Quantity"
                $0.placeholder = "100"
            }
        
            <<< TextAreaRow("Directions"){
                $0.title = "Directions"
                $0.placeholder = "Take once daily after breakfast."
            }
        
            <<< TextRow("Pharmacy"){
                $0.title = "Pharmacy"
                $0.placeholder = "Barnes Jewish Pharmacy"
        }
        
        
        }
        
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendPrescription(_ sender: Any) {
        var valuesDictionary : Dictionary! = form.values()
        
        let directions = valuesDictionary["Directions"]!
        let rxName = valuesDictionary["RXName"]!
        let pharmacy = valuesDictionary["Pharmacy"]!
        let quantity = valuesDictionary["Quantity"]!
        
        let sendingData: Parameters = ["directions" : directions!, "rxName": rxName!, "pharmacy": pharmacy!, "quantity": quantity!, "seedName": patientSeedName!]
        
        print(sendingData)
        
        Alamofire.request("https://ohpioid-blurjoe.c9users.io:8081/api/createPrescription", method: .post, parameters: sendingData, encoding: JSONEncoding.default).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                print(value)
                
            case .failure(let error):
                print(error)
            }
            
            
        }
        
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
