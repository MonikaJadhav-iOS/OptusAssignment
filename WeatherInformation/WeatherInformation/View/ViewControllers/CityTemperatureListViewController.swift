//
//  CityTemperatureListViewController.swift
//  WeatherInformation
//
//  Created by Monika Jadhav on 16/12/20.
//  Copyright © 2020 Monika Jadhav. All rights reserved.
//

import UIKit

class CityTemperatureListViewController: BaseViewController {
    
    //MARK: - Outlets and Variables
    @IBOutlet weak var cityTemperatureTable: UITableView!
    
    let cityTempViewModel = CityTemperatureListViewModel()
    var timer: Timer?
    var isCelciusSelected : Bool?
    
    //MARK: - View Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        isCelciusSelected = true
        if cityTempViewModel.fetchAllCityTemperatureRecordsFromDB() {
            self.cityTemperatureTable.reloadData()
        }else {
            getCityTemperatureListFromURL()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
   
    
    //MARK: - Method for UI setup
    func setUpUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.cityTemperatureTable.register(UINib.init(nibName: Constants.cityTempCellIdentifier, bundle: nil), forCellReuseIdentifier: Constants.cityTempCellIdentifier)
        self.setUpLodingView()
        self.cityTemperatureTable.isAccessibilityElement = true
        self.cityTemperatureTable.accessibilityIdentifier = Constants.temperatureListTableIdentifire
    }
    
    
    //MARK: - Call to get all data server
    @objc func getCityTemperatureListFromURL() {
        cityTempViewModel.fetchCityTemperatureData { result in
            switch(result) {
            case .success:
                if self.cityTempViewModel.fetchAllCityTemperatureRecordsFromDB() {
                    self.cityTemperatureTable.reloadData()
                }
            case .failure(let error):
                self.showAlert(message: error.localizedDescription, title: Constants.errorTitle, action: UIAlertAction(title: Constants.ok, style: .default, handler: nil))
            }
        }
    }
}


//MARK: - UITableview delegate and datasource methods
extension CityTemperatureListViewController : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityTempViewModel.getNumberOfTotalCities(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cityTempCellIdentifier, for: indexPath) as! CityTemperatureTableViewCell
        cell.accessibilityIdentifier = "cityCell_\(indexPath.row)"
        cell.cityNameLabel.text = cityTempViewModel.getCityName(indexPath : indexPath)
        cell.cityTimeLabel.text = cityTempViewModel.getCityCurrentTime(indexPath: indexPath)
        if isCelciusSelected! {
            cell.cityTempLabel.text = cityTempViewModel.getCityTemperature(indexPath : indexPath)
        }else {
            cell.cityTempLabel.text = cityTempViewModel.getCityTemperatureInFaranite(indexPath : indexPath)
        }
        cell.backgroundImageView.image = cityTempViewModel.getCityCurrentBAckgroundImage(indexPath: indexPath)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           
           let footerView =  Bundle.main.loadNibNamed(Constants.cityTempFooterViewCell, owner: self, options: nil)?.first as! CityTempFooterViewCell
           footerView.delegate = self
           
           if isCelciusSelected! {
               footerView.celciusButton.setTitleColor(.white, for: .normal)
               footerView.faraniteButton.setTitleColor(.lightGray, for: .normal)
           }else {
               footerView.celciusButton.setTitleColor(.lightGray, for: .normal)
               footerView.faraniteButton.setTitleColor(.white, for: .normal)
           }
           return footerView
       }
    
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if cityTempViewModel.cityTempList.count == 1 {
            return false
        }
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            cityTempViewModel.deletePerticularCityRecordFromDatabase(cityID: cityTempViewModel.getCityId(indexPath : indexPath))
        }
        if self.cityTempViewModel.fetchAllCityTemperatureRecordsFromDB() {
        }
        self.cityTemperatureTable.reloadData()
        
    }
    
   
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}

//MARK: - UITableView Footer delegate methods
extension CityTemperatureListViewController : CityTempFooterViewDelegate {
    
    func degreeCelciusButtonTapped(sender: UIButton) {
        isCelciusSelected = true
        cityTemperatureTable.reloadData()
    }
    
    func degreeFareniteButtonTapped(sender: UIButton) {
        isCelciusSelected = false
        cityTemperatureTable.reloadData()
    }
    
    func addButtonTapped() {
        
    }
    
}
