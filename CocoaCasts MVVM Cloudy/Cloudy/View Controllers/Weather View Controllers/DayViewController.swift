//
//  DayViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol DayViewControllerDelegate: AnyObject {
    func controllerDidTapSettingsButton(controller: DayViewController)
    func controllerDidTapLocationButton(controller: DayViewController)
}

class DayViewController: WeatherViewController {

    // MARK: - Properties

    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var windSpeedLabel: UILabel!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var iconImageView: UIImageView!

    // MARK: -

    weak var delegate: DayViewControllerDelegate?

    // MARK: -

    var now: WeatherData? {
        didSet {
            updateView()
        }
    }

    // MARK: - Public Interface

    override func reloadData() {
        updateView()
    }

    // MARK: - View Methods

    private func updateView() {
        activityIndicatorView.stopAnimating()

        if let now = now {
            updateWeatherDataContainerView(with: now)

        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Cloudy was unable to fetch weather data."
        }
    }

    // MARK: -

    private func updateWeatherDataContainerView(with weatherData: WeatherData) {
        weatherDataContainerView.isHidden = false
        
        var windSpeed = weatherData.windSpeed
        var temperature = weatherData.temperature
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM d"
        dateLabel.text = dateFormatter.string(from: weatherData.time)
        
        let timeFormatter = DateFormatter()
        
        if UserDefaults.timeNotation == .twelveHour {
            timeFormatter.dateFormat = "hh:mm a"
        } else {
            timeFormatter.dateFormat = "HH:mm"
        }
        
        timeLabel.text = timeFormatter.string(from: weatherData.time)
        
        descriptionLabel.text = weatherData.summary
        
        if UserDefaults.temperatureNotation != .fahrenheit {
            temperature = temperature.toCelcius
            temperatureLabel.text = String(format: "%.1f °C", temperature)
        } else {
            temperatureLabel.text = String(format: "%.1f °F", temperature)
        }
        
        if UserDefaults.unitsNotation != .imperial {
            windSpeed = windSpeed.toKPH
            windSpeedLabel.text = String(format: "%.f KPH", windSpeed)
        } else {
            windSpeedLabel.text = String(format: "%.f MPH", windSpeed)
        }
        
        iconImageView.image = imageForIcon(withName: weatherData.icon)
    }

    // MARK: - Actions

    @IBAction func didTapSettingsButton(sender: UIButton) {
        delegate?.controllerDidTapSettingsButton(controller: self)
    }

    @IBAction func didTapLocationButton(sender: UIButton) {
        delegate?.controllerDidTapLocationButton(controller: self)
    }

}
