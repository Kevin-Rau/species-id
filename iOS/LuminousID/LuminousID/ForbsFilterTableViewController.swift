//
//  ForbsFilterTableViewController.swift
//  LuminousID
//
//  Created by Brian Larson on 4/20/17.
//  Copyright © 2017 Garden Club. All rights reserved.
//

import UIKit

class ForbsFilterTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var filterDict = [[String:AnyObject]]()
    var row = 0
    var filterList = ["Inflorescence", "Petal Number", "Habitat", "Flower Color", "Flower Shape", "Leaf Shape", "Leaf Arrangement"]
    var selectionList = ["All", "All", "All", "All", "All", "All", "All"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return filterList.count
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "forbsFilterCell", for: indexPath) as! FilterTableViewCell

        cell.FilterLabel.text = self.filterList[indexPath.row]
        cell.SelectionLabel.text = self.selectionList[indexPath.row]

        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "toForbsSpecificFilters", sender: filterList[indexPath.row])
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let specificFiltersVC = segue.destination as! ForbsSpecificFiltersViewController
        specificFiltersVC.attribute = self.filterList[row]
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
