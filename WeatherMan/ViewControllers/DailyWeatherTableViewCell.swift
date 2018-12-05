//
//  DailyWeatherTableViewCell.swift
//  WeatherMan
//
//  Created by Andrew Riznyk on 12/3/18.
//  Copyright © 2018 Andrew Riznyk. All rights reserved.
//

import UIKit

class DailyWeatherTableViewCell: UITableViewCell {

    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var lowText: UILabel!
    @IBOutlet weak var highText: UILabel!
    
    @IBOutlet weak var lowLabel: UILabel!
    @IBOutlet weak var highLabel: UILabel!
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    let dateFormatter = DateFormatter()
    
    var dayWeather : DailyDatum? {
        didSet {
            if let summary = dayWeather?.summary {
                summaryLabel.text = summary
            }
            
            if let lowTemp = dayWeather?.temperatureLow {
                lowLabel.isHidden = false
                lowText.isHidden = false
                lowLabel.text = "\(lowTemp)"
            } else {
                lowLabel.isHidden = true
                lowText.isHidden = true
            }
            
            if let highTemp = dayWeather?.temperatureHigh {
                highLabel.isHidden = false
                highText.isHidden = false
                highLabel.text = "\(highTemp)"
            } else {
                highLabel.isHidden = true
                highText.isHidden = true
            }
            
            let epocTime = TimeInterval(dayWeather!.time)
            let date = Date(timeIntervalSince1970:  epocTime)
            dateLabel.text = Formatter.cellDateFormat.string(from: date)

            setWeatherIcon()
        }
    }
    
    func setWeatherIcon(){
        if let weather = dayWeather?.icon {
            iconImageView.image = weather.image()
        }
    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

extension Formatter {
    static let cellDateFormat : DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy"
        return formatter
    }()
}
