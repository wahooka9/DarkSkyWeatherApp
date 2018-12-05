//
//  ViewController.swift
//  WeatherMan
//
//  Created by Andrew Riznyk on 11/30/18.
//  Copyright © 2018 Andrew Riznyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var dailyWeatherTableView: UITableView!
    let wvm = WeatherViewModel()
    
    @IBOutlet weak var currentIconImageView: UIImageView!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var precipLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var tempratureLabel: UILabel!
    @IBOutlet weak var degreeText: UILabel!
    @IBOutlet weak var degreeFText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dailyWeatherTableView.delegate = self
        dailyWeatherTableView.dataSource = self
        wvm.delegate = self
        reloadView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        wvm.restartPollTimer()
    }
    
    func loadData(){
        currentIconImageView.image = wvm.getCurrentIcon()
        windSpeedLabel.text = wvm.getWindSpeed()
        precipLabel.text = wvm.getPrecipitation()
        summaryLabel.text = wvm.getWeatherSummary()
        dateLabel.text = wvm.getDate()
        
        let temp = wvm.getCurrentTemp()
        if temp == "Unknown Temperature" {
            degreeText.isHidden = true
            degreeFText.isHidden = true
        } else {
            degreeText.isHidden = false
            degreeFText.isHidden = false
        }
        tempratureLabel.text = temp
    }
    
    func reloadView() {
        loadData()
        dailyWeatherTableView.reloadData()
    }
}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wvm.count()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DailyWeatherCell", for: indexPath) as! DailyWeatherTableViewCell
        cell.dayWeather = wvm.getDayData(index: indexPath.row)
        return cell
    }

}

extension ViewController : WeatherUpdateDelegate {
    func update() {
        DispatchQueue.main.async {
            self.reloadView()
        }
    }
}
