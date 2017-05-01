//
//  ViewObservationViewController.swift
//  LuminousID
//
//  Created by Brian Larson on 4/30/17.
//  Copyright © 2017 Garden Club. All rights reserved.
//

import UIKit

class ViewObservationViewController: UIViewController {

    @IBOutlet weak var SpeciesImageView: UIImageView!
    
    @IBOutlet weak var SpeciesNameLabel: UILabel!
    
    @IBOutlet weak var DateLabel: UILabel!
    
    @IBOutlet weak var LatLabel: UILabel!
    
    @IBOutlet weak var LongLabel: UILabel!
    
    var speciesImageName = ""
    var obsDate = ""
    var obsLat = 0.0
    var obsLong = 0.0
    var speciesName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        var fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent(speciesImageName)
        SpeciesImageView.image = UIImage(contentsOfFile: fileUrl.path)!
        print (speciesImageName)
        print (obsDate)
        print (obsLat)
        print (obsLong)
        SpeciesNameLabel.text =  "Species Name: " + speciesName
        DateLabel.text = "Date: " + obsDate
        LatLabel.text = "Latitude: " + "\(obsLat)"
        LongLabel.text = "Longitude" + "\(obsLong)"
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
