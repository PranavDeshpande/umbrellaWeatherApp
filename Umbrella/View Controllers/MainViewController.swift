//
//  MainViewController.swift
//  umbrella
//
//  Created by Pranav Shashikant Deshpande on 9/17/17.
//  Copyright © 2017 Pranav Shashikant Deshpande. All rights reserved.
//
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var currentConditionsLabel: UILabel?
    @IBOutlet weak var currentCityStateLabel: UILabel?
    @IBOutlet weak var backgroundBox: UIView!
    @IBOutlet weak var collectionView: UICollectionView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var dailyWeather: [DailyWeather] = []
    
    let apiKey = "786d40ffbfbaabb5"
    let warmColor = UIColor(0xFF9800)
    let coolColor = UIColor(0x03A9F4)
    var tempScale = TempScales.f
    var currentZip = ""
    var validateZip = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        
        currentTemperatureLabel?.text = " "
        currentConditionsLabel?.text = " "
        currentCityStateLabel?.text = " "
        backgroundBox.layer.backgroundColor = warmColor.cgColor
        
    }
  
    
    // MARK: - Navigation
    
    @IBAction func returnFromSettingsSegue(_ segue: UIStoryboardSegue) {
        
   
        if let svc = segue.source as? SettingsViewController {
            validateZip = true
            tempScale = svc.tempScale
            currentZip = svc.zipTextField.text!
            retrieveWeatherForecast()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        let svc = segue.destination as? SettingsViewController
        svc?.tempScale = tempScale
        svc?.currentZip = currentZip
    }
    
    // MARK: - Weather Fetching
 
    func toggleRefreshAnimation(_ on: Bool) {
        collectionView?.isHidden = on
        if on {
            activityIndicator?.startAnimating()
        } else {
            activityIndicator?.stopAnimating()
        }
    }
    
    func retrieveWeatherForecast() {
        
        
        toggleRefreshAnimation(true)
        
        var weatherRequest = WeatherRequest(APIKey: apiKey)
        
        // Set the zip code
        weatherRequest.zipCode = currentZip
        
     
        let url = weatherRequest.URL
        
        
        let forecastService = ForecastService()
        
        
        forecastService.getForecast(url!) { (result: ForecastResult) -> Void in
            
            switch (result) {
            case .success(let weatherForecast):
               
                guard let weatherError = weatherForecast.errors, weatherError.errorDescription != nil else {
                    
                   
                    self.dailyWeather = []
                    
             
                    if let currentWeather = weatherForecast.currentWeather {
                        
                        DispatchQueue.main.async {
                            
                            if let temp_f = currentWeather.temp_f,
                                let temp_c = currentWeather.temp_c {
                             
                                if(temp_f >= 60) {
                                    self.backgroundBox.layer.backgroundColor = self.warmColor.cgColor
                                } else {
                                    self.backgroundBox.layer.backgroundColor = self.coolColor.cgColor
                                }
                                
                               
                                if(self.tempScale == TempScales.f) {
                                    self.currentTemperatureLabel?.text = "\(Int(round(temp_f)))º"
                                } else {
                                    self.currentTemperatureLabel?.text = "\(Int(round(temp_c)))º"
                                }
                            }
                            
                          
                            if let cityState = currentWeather.cityState {
                                self.currentCityStateLabel?.text = "\(cityState)"
                            }
                            
                      
                            if let currentConditions = currentWeather.currentConditions {
                                self.currentConditionsLabel?.text = "\(currentConditions)"
                            }
                            
                            
                            let dailyRequest = DailyRequest(weatherForecast.hourly)
                            self.dailyWeather = dailyRequest.Daily!
                            
                            
                            self.collectionView?.reloadData()
                            self.toggleRefreshAnimation(false)
                            
                        }
                    }
                    
                    return
                }
                
                
             
                DispatchQueue.main.async {
                    
              
                    self.toggleRefreshAnimation(false)
                    
                    if(self.validateZip) {
                        var alertMsg: String?
                        
                        if(weatherError.errorType == "invalidquery") {
                       
                            alertMsg = "Please Enter a ZIP Code Location"
                        } else {
                            alertMsg = weatherError.errorDescription?.capitalized
                        }
                        
                        let action = UIAlertAction(title: "OK", style: .default, handler: { (a) in
                            self.performSegue(withIdentifier: "settingsSegue", sender: nil)
                        })
                        
                        let alert = UIAlertController(title: nil, message: alertMsg, preferredStyle: .alert)
                        alert.addAction(action)
                        
                      
                        if(self.presentedViewController is UIAlertController) {
                            self.presentedViewController?.dismiss(animated: true) {
                                self.present(alert, animated: true, completion: nil)
                            }
                        } else {
                            self.present(alert, animated: true, completion: nil)
                        }
                        
                    }
                    
                    self.validateZip = false
                    
                }
                
                break
                
            // Handle invalid http request
            case .error(let e):
                
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: nil, message: e.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    
                    
                    alert.addAction(UIAlertAction(title: "Retry", style: UIAlertActionStyle.default, handler: { (a) in
                        self.retrieveWeatherForecast()
                    }))
                    
                    
                  
                    if((self.presentedViewController) == nil) {
                        self.present(alert, animated: true, completion: nil)
                    } else {
                        self.presentedViewController?.dismiss(animated: true) {
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                
                break
            }
        }
    }
}



// MARK: - UICollectionViewDataSource
extension MainViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dailyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dailyWeather[section].hourlyWeather.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "hourlyCell", for: indexPath) as! HourlyCell

        let hourWeather = dailyWeather[indexPath.section].hourlyWeather[indexPath.row]
        
        if let timeStamp = hourWeather.timeStamp {
            cell.hourlyCellTimeLabel?.text = "\(timeStamp)"
        }
        
        if let icon = hourWeather.icon {
            
            var icon_url = "\(icon)".nrd_weatherIconURL()!
            
          
            cell.hourlyCellIcon?.tintColor = .black
            cell.hourlyCellTimeLabel?.textColor = .black
            cell.hourlyCellTemperatureLabel?.textColor = .black
         
            if(dailyWeather[indexPath.section].highIndex != dailyWeather[indexPath.section].lowIndex) {
                
               
                if(indexPath.row == dailyWeather[indexPath.section].highIndex) {
                    icon_url = "\(icon)".nrd_weatherIconURL(highlighted: true)!
                    cell.hourlyCellIcon?.tintColor = warmColor
                    cell.hourlyCellTimeLabel?.textColor = warmColor
                    cell.hourlyCellTemperatureLabel?.textColor = warmColor
                }
                
            
                if(indexPath.row == dailyWeather[indexPath.section].lowIndex) {
                    icon_url = "\(icon)".nrd_weatherIconURL(highlighted: true)!
                    cell.hourlyCellIcon?.tintColor = coolColor
                    cell.hourlyCellTimeLabel?.textColor = coolColor
                    cell.hourlyCellTemperatureLabel?.textColor = coolColor
                }
            }
            
            cell.hourlyCellIcon?.downloadFromURL("\(icon_url)", contentMode: .scaleAspectFit)
        }
        
        if let temp_english = hourWeather.temp_english,
            let temp_metric = hourWeather.temp_metric {
            
    
            if(self.tempScale == TempScales.f) {
                cell.hourlyCellTemperatureLabel?.text = "\(temp_english)º"
            } else {
                cell.hourlyCellTemperatureLabel?.text = "\(temp_metric)º"
            }
            
        }
        
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
     
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! SectionHeader
        
   
        header.headerTItle?.text = dailyWeather[indexPath.section].headerTitle

        return header
        
    }
}
