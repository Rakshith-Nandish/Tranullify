
//  ViewController.swift
//  Tranullify

import UIKit
import GoogleMaps
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet weak var mapViewRoadAnalysis: GMSMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMap()
    }
    
    func loadMap() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 12.9260, longitude: 77.6762, zoom: 6.0)
        mapViewRoadAnalysis.camera = camera
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 12.9260, longitude: 77.6762)
        marker.title = "Bellandur"
        marker.snippet = "Bangalore"
        
        marker.map = mapViewRoadAnalysis
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

