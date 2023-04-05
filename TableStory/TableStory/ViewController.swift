//
//  ViewController.swift
//  TableStory
//
//  Created by Nguyen, Kriste N on 3/22/23.
//

import UIKit
import MapKit
let data = [
    Item(name: "Pho Tran 88", desc: "Best place for pho in San Marcos. Your Vietnamese grandma would approve.", lat: 29.883670486029928, long: -97.93978417544676, imageName: "rest1"),
    Item(name: "Pho NB", desc: "Fun friendly atmosphere. Delicious pho if you're in New Braunfels.", lat: 29.697829228153857, long: -98.09389385871197, imageName: "rest2"),
    Item(name: "Pho Thaison", desc: "Vietnamese cuisine chain with a large variety of food located in Kyle.", lat: 30.032906842090533, long: -97.87268353948716, imageName: "rest3"),
    Item(name: "Hai Ky", desc: "Small hole-in-wall restaurant with a variety of Asian cuisine.", lat: 30.230893890960814, long: -97.73492248937589, imageName: "rest4"),
    Item(name: "Dong Nai", desc: "Very generous portions of food at a decent price point. ", lat: 30.23394087272938, long: -97.79291154334152, imageName: "rest5")
   
]

struct Item {
    var name: String
    var desc: String
    var lat: Double
    var long: Double
    var imageName: String
}



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource
 {

    
    @IBOutlet weak var theTable: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return data.count
   }

    @IBOutlet weak var mapView: MKMapView!
    
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
       let item = data[indexPath.row]
       cell?.textLabel?.text = item.name
       
       let image = UIImage(named: item.imageName)
                    cell?.imageView?.image = image
                    cell?.imageView?.layer.cornerRadius = 10
                    cell?.imageView?.layer.borderWidth = 5
                    cell?.imageView?.layer.borderColor = UIColor.white.cgColor
       return cell!
   }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = data[indexPath.row]
      performSegue(withIdentifier: "ShowDetailSegue", sender: item)
    
  }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "ShowDetailSegue" {
                 if let selectedItem = sender as? Item, let detailViewController = segue.destination as? DetailViewController {
                     // Pass the selected item to the detail view controller
                     detailViewController.item = selectedItem
                 }
             }
         }
    
   
         
             
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        theTable.delegate = self
        theTable.dataSource = self
        
        //set center, zoom level and region of the map
               let coordinate = CLLocationCoordinate2D(latitude: 30.295190, longitude: -97.7444)
               let region = MKCoordinateRegion(center: coordinate,span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
               mapView.setRegion(region, animated: true)
               
            // loop through the items in the dataset and place them on the map
                for item in data {
                   let annotation = MKPointAnnotation()
                   let eachCoordinate = CLLocationCoordinate2D(latitude: item.lat, longitude: item.long)
                   annotation.coordinate = eachCoordinate
                       annotation.title = item.name
                       mapView.addAnnotation(annotation)
                       }

             
        // Do any additional setup after loading the view.
    }


}

