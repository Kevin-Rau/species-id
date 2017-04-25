//
//  NeedleSpecificFiltersViewController.swift
//  LuminousID
//
//  Created by Brian Larson on 4/24/17.
//  Copyright © 2017 Garden Club. All rights reserved.
//

import UIKit

protocol NeedleSpecificFilterProtocol{
    func filterWasSelected(filter: FilterElement)
}

class NeedleSpecificFiltersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var attributeName = ""
    var attributeFilters = [String]()
    var row = 0
    
    
    @IBOutlet weak var navBar: UINavigationItem!
    
    
    var delegate:NeedleSpecificFilterProtocol?
    
    override func viewDidLoad() {
        
        self.navBar.title = attributeName
        
        if attributeName == "Family"{
            attributeFilters = ["All", "betulaceae", "caprifolaceae", "ericaceae", "fabaceae", "grossulariaceae", "rosaceae", "salicaceae"]
        }
        else if attributeName == "Leaf Arrangement"{
            attributeFilters = ["All", "alternate", "opposite"]
        }
        else if attributeName == "Leaf Margin"{
            attributeFilters = ["All", "entire", "lobed", "toothed", "toothed/lobed", "undulate"]
        }
        else if attributeName == "Leaf Shape"{
            attributeFilters = ["All", "dissected", "oblong", "round"]
        }
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return attributeFilters.count
    }
    
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "needleSpecificFilterCell", for: indexPath) as! ForbsSpecificCellTableViewCell
        cell.AttributeLabel.text = self.attributeFilters[indexPath.row]
        cell.AttributeImage.image = UIImage(named: "forbs_glossary_small_keyed/" + self.attributeFilters[indexPath.row] + ".png")
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        row = indexPath.row
        tableView.deselectRow(at: indexPath, animated: true)
        let filterChoice = FilterElement(attribute: attributeName, value: attributeFilters[indexPath.row])
        self.delegate?.filterWasSelected(filter: filterChoice)
        self.navigationController!.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
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
