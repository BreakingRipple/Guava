//
//  POIVC.swift
//  Guava
//
//  Created by Savage on 31/8/21.
//

import UIKit

class POIVC: UIViewController {

    let locationManager = AMapLocationManager()
    var pois = [["don't show position", ""]]
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        config()
        requestLocation()

    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension POIVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pois.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: kPOICellID, for: indexPath) as! POICell
        let poi = pois[indexPath.row]
        
        cell.poi = poi
        return cell
    }
}

extension POIVC: UITableViewDelegate{
    
}
