//
//  DetailsViewModel.swift
//  TestAssignment
//
//  Created by Дмитрий Куприенко on 28.01.2022.
//

import Foundation
import UIKit
import SDWebImage
import MapKit

class DetailsViewModel {
    
    var dataToDisplay: [Results] = []
    var indexPath: Int = 0
    
    private let transformer = SDImageResizingTransformer(size: CGSize(width: 250, height: 250),
                                                         scaleMode: .fill)
    
    func loadImage(forImageView: UIImageView) {
        
        forImageView.sd_setImage(with: URL(string: dataToDisplay[indexPath].picture?.large ?? ""),
                                          placeholderImage: UIImage(named: "empty"), context: [.imageTransformer: transformer])
    }
    
    func convertDate(completionBlock: @escaping((String) -> ())) {
        
        let wrongFormatDate = dataToDisplay[indexPath].dob?.date ?? ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = stingToDateFormatString
        let date = dateFormatter.date(from: wrongFormatDate)
        dateFormatter.dateFormat = correctDateFormatString
        dateFormatter.locale = NSLocale(localeIdentifier: localeIdentifyerString) as Locale?
        let correctFormatDate = dateFormatter.string(from: (date ?? Date()) as Date)
        completionBlock(correctFormatDate)
    }
    
    func showLocation(mapView: MKMapView) {
        
        let stringLatitude = dataToDisplay[indexPath].location?.coordinates?.latitude ?? ""
        let stringLongtitude = dataToDisplay[indexPath].location?.coordinates?.longitude ?? ""
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = NumberFormatter.Style.decimal
        let latitude = numberFormatter.number(from: stringLatitude)
        let longtitude = numberFormatter.number(from: stringLongtitude)
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: latitude as! CLLocationDegrees,
                                                           longitude: longtitude as! CLLocationDegrees)
        let coordinates = CLLocation(latitude: latitude as! CLLocationDegrees, longitude: longtitude as! CLLocationDegrees)
        mapView.mapType = .hybrid
        mapView.centerTolocation(coordinates, regionRadius: 1000)
        mapView.addAnnotation(annotation)
    }
    
    func makeAPhoneCall(with: String) {
        
        if with == callMethodCellString {
            let cellphoneNumber = dataToDisplay[indexPath].cell ?? ""
            let cellphoneUrl = URL(string: "tel://\(cellphoneNumber)")
                  if #available(iOS 10, *) {
                    UIApplication.shared.open(cellphoneUrl!, options: [:], completionHandler:nil)
                   } else {
                       UIApplication.shared.openURL(cellphoneUrl!)
                   }
        } else {
            let phoneNumber = dataToDisplay[indexPath].phone ?? ""
            let phoneUrl = URL(string: "tel://\(phoneNumber)")
                  if #available(iOS 10, *) {
                      UIApplication.shared.open(phoneUrl!, options: [:], completionHandler:nil)
                   } else {
                       UIApplication.shared.openURL(phoneUrl!)
                   }
        }
    }
}

private extension MKMapView {
    
    func centerTolocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius,
                                                  longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}
