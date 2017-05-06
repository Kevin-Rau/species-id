//
//  FieldGuideTableViewController.swift
//  LuminousID
//
//  Created by Brian Larson on 2/27/17.
//  Copyright © 2017 Garden Club. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

/*
    This view displays a list of all of the Forbs species. It gets all of the data from a firebase reference and populates a dictionary which is passed to the subsequent Views.
 */

class ForbsTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ForbsFilterTableProtocol {
    @IBOutlet weak var forbsTable: UITableView!
    
    
    var myDict = [[String:AnyObject]]()
    var originalDict = [[String:AnyObject]]()
    var speciesNames:[String] = []
    
    var originalSpeciesNames:[String] = []
    var handle:FIRDatabaseHandle?
    var ref:FIRDatabaseReference?
    var row = 0
    var photoFileName = ""
    var pressedFilters = false
    var listOfAttributes:[String] = []
    var listOfValues:[String] = []
    
    
    /*
        Creates a reference to the forbs section of the firebase database, iterates through all of the entries, and saves their data in a dictionary. It then refreshes the information in the table.
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference().child("speciesid").child("field_guide").child("forbs")
        ref?.observe(.value, with: { (snapshot) in
            
            if let snapshots = snapshot.children.allObjects as? [FIRDataSnapshot]
            {
                self.myDict = snapshots.flatMap { $0.value as? [String:AnyObject]}
                for item in self.myDict{
                    self.speciesNames.append(item["species_name"] as! String)
                }
            }
            self.originalDict = self.myDict
            self.originalSpeciesNames = self.speciesNames
            self.forbsTable.reloadData()
        })
        // Do any additional setup after loading the view.
    }

    
    /*
        This function gets called when the search button is pressed on the filter screen. It creates lists of attibutes, and their values, then iterates through all of the forbs species, and creates a new list of anything that matches all of the values. It then refreshes the table using this new list. Note that everything is converted to lower case to eliminate any ambiguity.
     */
    
    func filtersWereSelected(filterList: FilterList){
        var filterDict = [[String:AnyObject]]()
        var filteredSpeciesNames:[String] = []
        myDict = originalDict
        speciesNames = originalSpeciesNames
        var satisfiesFilter = true
        listOfAttributes = filterList.attributes
        listOfValues = filterList.values
        print (listOfAttributes)
        print (listOfValues)
        var att = listOfAttributes[0]
        var val = listOfValues[0]
        for item in myDict{
            for var i in 0...(listOfAttributes.count - 1){
                att = listOfAttributes[i]
                val = listOfValues[i]
                if (item[att] as? String)?.lowercased().range(of: val) != nil {
                    satisfiesFilter = true
                }
                else if val == "All"{
                    satisfiesFilter = true
                }
                else{
                    satisfiesFilter = false
                    break
                }
            }
            if satisfiesFilter == true{
                filterDict.append(item)
                filteredSpeciesNames.append(item["species_name"] as! String)
            }
        }
        myDict = filterDict
        speciesNames = filteredSpeciesNames
        forbsTable.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /*
        Specifies that the filters screen is the one to segue to and performs the segue
     */
    
    @IBAction func ForbsFilters(_ sender: Any) {
        pressedFilters = true
        performSegue(withIdentifier: "forbsFiltersPopover", sender: myDict)
        
    }
    
    
    /*
        Make a table row for each item in speciesNames
     */
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return speciesNames.count
    }
    
    
    
    /*
        Specifies the design of each cell. Essentially populate the cell with the species name, common name, and picture. Error handles by reloading the table.
     */
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fieldGuideCell", for: indexPath) as! FieldGuideTableViewCell
        if indexPath.row <= (myDict.count - 1){
            cell.speciesNameCellLabel.text = self.speciesNames[indexPath.row]
            cell.commonNameCellLabel.text = myDict[indexPath.row]["common_name"] as? String
            let plantCodeString = myDict[indexPath.row]["plant_code"] as! String?
            cell.speciesPhoto.image = UIImage(named: "Images/" + plantCodeString! + "_1.jpg")
        }
        else{
            print("Table Reloaded.")
            forbsTable.reloadData()
            
        }
        return (cell)
    }
    
    /*
        Specifies that the Species Info view is the one to go to and performs it.
     */
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        pressedFilters = false
        row = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toSpeciesFromForbs", sender: speciesNames[indexPath.row])
    }
    
    /*
        Sets the kind of segue and passes along the appropriate information for the next View to display.
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if pressedFilters == false{
            let speciesInfoVC = segue.destination as! SpeciesInfoViewController
            speciesInfoVC.speciesDict = [myDict[row]]
        }
        else{
            let filtersVC = segue.destination as! ForbsFilterTableViewController
            filtersVC.delegate = self
            filtersVC.filterDict = myDict
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
