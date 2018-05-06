//
//  DetailViewController.swift
//  Ohpioid
//
//  Created by Drew Patel on 5/5/18.
//  Copyright © 2018 Drew Patel. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        //let object = patien[indexPath.row] as! NSDate
        cell.textLabel!.text = "dank"
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
        }
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
        
        
         func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        
         func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            // Return false if you do not want the specified item to be editable.
            return false
        }
        
    
        
    }

}


