//
//  ViewController.swift
//  TestAssignment
//
//  Created by Дмитрий Куприенко on 27.01.2022.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var usersTableView: UITableView!
    
    private var mainViewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        doStartupSetup()
    }
    
    //MARK: - Private
    
    private func doStartupSetup() {
        
        self.title = titleString
        mainViewModel.getUserDataForPage(completionBlock: {
            self.usersTableView.reloadData()
        })
        self.usersTableView.register(UINib(nibName: cellName, bundle: nil), forCellReuseIdentifier: cellName)
    }
}

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return mainViewModel.usersData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let usersTableViewCell = usersTableView.dequeueReusableCell(withIdentifier: cellName, for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        
        let dataToDisplay = mainViewModel.usersData[indexPath.row]
        usersTableViewCell.setupCell(dataToDisplay: dataToDisplay)
        
        return usersTableViewCell
    }
}
extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == (mainViewModel.usersData.count - 1) {
            mainViewModel.page += 1
            mainViewModel.getUserDataForPage(completionBlock: {
                self.usersTableView.reloadData()
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        let main = UIStoryboard(name: storyboardNameString, bundle: nil)
        if let detailsViewController = main.instantiateViewController(withIdentifier:
                                                                        detailsViewControllerName)
            as? DetailsViewController {
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
    }
}
