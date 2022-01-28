//
//  DetailsViewController.swift
//  TestAssignment
//
//  Created by Дмитрий Куприенко on 27.01.2022.
//

import UIKit
import MapKit
import SDWebImage

class DetailsViewController: UIViewController {
    
    var detailsViewModel = DetailsViewModel()
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var detailsNameLabel: UILabel!
    @IBOutlet weak var detailsGenderLabel: UILabel!
    @IBOutlet weak var detailsUsernameLabel: UILabel!
    @IBOutlet weak var detailsBirthDateLabel: UILabel!
    @IBOutlet weak var detailsPhoneNumberLabel: UILabel!
    @IBOutlet weak var detailsCellNumuberLabel: UILabel!
    @IBOutlet weak var detailsLocationLabel: UILabel!
    @IBOutlet weak var detailsMapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doStartupSetup()
    }
    @IBAction func callButtonPressed(_ sender: Any) {
        
        detailsViewModel.makeAPhoneCall(with: callMethodPhoneString)
    }
    @IBAction func cellCallButtonPressed(_ sender: Any) {
        
        detailsViewModel.makeAPhoneCall(with: callMethodCellString)
    }
    
    private func doStartupSetup() {
        
        let index = detailsViewModel.indexPath
        let nameTitle = detailsViewModel.dataToDisplay[index].name?.title ?? ""
        let firstName = detailsViewModel.dataToDisplay[index].name?.first ?? ""
        let lastName = detailsViewModel.dataToDisplay[index].name?.last ?? ""
        let gender = detailsViewModel.dataToDisplay[index].gender?.capitalized ?? ""
        let street = detailsViewModel.dataToDisplay[index].location?.street?.name ?? ""
        let city = detailsViewModel.dataToDisplay[index].location?.city ?? ""
        let country = detailsViewModel.dataToDisplay[index].location?.country ?? ""
        detailsViewModel.convertDate(completionBlock: { birthDate in
            self.detailsBirthDateLabel.text = bornString + " " + birthDate
        })
        self.title = detailsTitleString + " " + firstName
        self.detailsViewModel.loadImage(forImageView: detailsImageView)
        self.detailsImageView.layer.cornerRadius = 25
        self.detailsNameLabel.text = nameTitle + ". " + firstName + " " + lastName
        self.detailsGenderLabel.text = gender
        self.detailsUsernameLabel.text = detailsViewModel.dataToDisplay[index].login?.username ?? ""
        self.detailsPhoneNumberLabel.text = "\(phoneString) \(detailsViewModel.dataToDisplay[index].phone ?? "")"
        self.detailsCellNumuberLabel.text = "\(cellString) \(detailsViewModel.dataToDisplay[index].cell ?? "")"
        self.detailsLocationLabel.text = street.capitalized + ", " + city.capitalized + ", "
        + country.capitalized
        detailsViewModel.showLocation(mapView: detailsMapView)
    }
}
