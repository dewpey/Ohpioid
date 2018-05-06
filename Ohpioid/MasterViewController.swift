//
//  MasterViewController.swift
//  Ohpioid
//
//  Created by Drew Patel on 5/5/18.
//  Copyright © 2018 Drew Patel. All rights reserved.
//

import UIKit

public class Patient{
    var name: String!
    var address: String!
    var seedName: String!
    var sex: String!
    var DOB: String!
    var ID: String!
    init (_name: String, _address: String, _seedName: String, _sex: String, _DOB: String, _ID: String) {
        name = _name
        address = _address
        seedName = _seedName
        sex = _sex
        DOB = _DOB
        ID = _ID
    }
    
    
}

class MasterViewController: UITableViewController {

    
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]();

    
    
    let _alicia = Patient(_name: "Alicia Keys",_address: "123 Somewhere Ave", _seedName: "alicia", _sex: "Female", _DOB: "12 December, 2017", _ID: "ABC123");
    let _baron = Patient(_name: "Baron Rivendale",_address: "123 Somewhere Ave", _seedName: "bar0n", _sex: "Male", _DOB: "12 December, 2017", _ID: "ABC123");
    let _charles = Patient(_name: "Charles Inglum",_address: "123 Somewhere Ave", _seedName: "charles", _sex: "Male", _DOB: "12 December, 2017", _ID: "ABC123");
    let _danica = Patient(_name: "Danica Patrick",_address: "123 Somewhere Ave", _seedName: "danica", _sex: "Female", _DOB: "12 December, 2017", _ID: "ABC123");
    
    var patients = [Patient]();

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        patients.append(_alicia)
        patients.append(_baron)
        patients.append(_charles)
        patients.append(_danica)
        
        print(patients[0].name)
        tableView.reloadData()
        
        // Do any additional setup after loading the view, typically from a nib.
        navigationItem.leftBarButtonItem = editButtonItem

        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(insertNewObject(_:)))
        navigationItem.rightBarButtonItem = addButton
        if let split = splitViewController {
            let controllers = split.viewControllers
            detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        clearsSelectionOnViewWillAppear = splitViewController!.isCollapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc
    func insertNewObject(_ sender: Any) {
        objects.insert(NSDate(), at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }

    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let object = patients[indexPath.row].name as! String
                let patientObject = patients[indexPath.row] as! Patient
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.patientName = patients[indexPath.row].name as! String
                controller.patientAddress = patients[indexPath.row].address as! String
                controller.patientDOB = patients[indexPath.row].DOB as! String
                controller.patientID = patients[indexPath.row].ID as! String
                controller.patientSeedName = patients[indexPath.row].seedName as! String
                controller.patientSex = patients[indexPath.row].sex as! String
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return patients.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        //let object = patien[indexPath.row] as! NSDate
        cell.textLabel!.text = patients[indexPath.row].name
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

