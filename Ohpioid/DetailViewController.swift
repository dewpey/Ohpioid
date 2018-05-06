//
//  DetailViewController.swift
//  Ohpioid
//
//  Created by Drew Patel on 5/5/18.
//  Copyright © 2018 Drew Patel. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PrescriptionControllerCell: UITableViewCell {
    
    @IBOutlet weak var titleBox: UILabel!
    @IBOutlet weak var transactionBox: UILabel!
    @IBOutlet weak var directionsBox: UILabel!
    @IBOutlet weak var amountBox: UILabel!
}

class Prescription{
    let directions: String!
    let rxName: String!
    let pharmacy: String!
    let quantity: Int!
    let id: String!
    
    init (_directions: String, _rxName: String, _pharmacy: String, _quantity: Int, _id: String) {
        directions = _directions
        rxName = _rxName
        pharmacy = _pharmacy
        quantity = _quantity
        id = _id
    }
    
}


class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var prescriptions = [Prescription]();
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prescriptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "prescriptionCell", for: indexPath) as! PrescriptionControllerCell
        //let object = patien[indexPath.row] as! NSDate
        if(prescriptions.count>0){
        cell.transactionBox!.text = prescriptions[indexPath.row].id
        }else{
        cell.transactionBox!.text = "placeholder"
        }
        return cell
    }
    
   
    

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var nameBox: UILabel!
    @IBOutlet weak var DOBBox: UILabel!
    @IBOutlet weak var idBOX: UILabel!
    @IBOutlet weak var sexBox: UILabel!
    @IBOutlet weak var addressBox: UILabel!
    

    
    var detailItem: String!
    var patientName: String!
    var patientAddress: String!
    var patientDOB: String!
    var patientID: String!
    var patientSeedName: String!
    var patientSex: String!
    
    //var patientObject: Patient
    func configureView() {
                nameBox.text = patientName
                DOBBox.text = patientDOB
                idBOX.text = patientID
                sexBox.text = patientSex
                addressBox.text = patientAddress
                print(patientSeedName)
        if((patientSeedName) != nil){
                profileImage.image = UIImage(named: patientSeedName)
            Alamofire.request("https://ohpioid-blurjoe.c9users.io:8081/api/query?queryParam=\(patientSeedName!)", method: .get).validate().responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    //print("JSON: \(json)")
                    for (key,subJson):(String, JSON) in json {
                        print(subJson["data"]["assetdata"]["prescription"])
                        let id = subJson["id"].string!
                        //let quantity = subJson["data"]["params"]["quantity"].int!
                        //let directions = subJson["data"]["params"]["directions"].string!
                        //let rxName = subJson["data"]["params"]["rxName"].string!
                        //let pharmacy = subJson["data"]["params"]["pharmacy"].string!
                        //let newPre = Prescription(_directions: directions, _rxName: rxName, _pharmacy: pharmacy, _quantity: quantity, _id: id)
                        let newPre = Prescription(_directions: "directions", _rxName: "rxName", _pharmacy: "pharmacy", _quantity: 100, _id: id)
                        self.prescriptions.append(newPre)
                        
                    }
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
        print(patientSeedName)
        
       
    }

   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        configureView()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toCreatePrescription" {
          let controller = segue.destination as! createPrescriptionVC
            controller.patientSeedName = patientSeedName
    }
        
        

        
         func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return false
        }
        
    
        
    }

}


