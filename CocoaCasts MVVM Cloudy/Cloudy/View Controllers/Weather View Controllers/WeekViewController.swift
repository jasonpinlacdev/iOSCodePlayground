//
//  WeekViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 01/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol WeekViewControllerDelegate: AnyObject {
    func controllerDidRefresh(controller: WeekViewController)
}

class WeekViewController: WeatherViewController {

    @IBOutlet var tableView: UITableView!

    weak var delegate: WeekViewControllerDelegate?
    
    var week: [WeatherDayData]? {
        didSet {
            updateView()
        }
    }

    private lazy var dayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter
    }()

    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup View
        setupView()
    }
    
    private func setupView() {
        setupTableView()
        setupRefreshControl()
    }

    private func setupTableView() {
        tableView.separatorInset = UIEdgeInsets.zero
    }

    private func setupRefreshControl() {
        // Initialize Refresh Control
        let refreshControl = UIRefreshControl()
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(WeekViewController.didRefresh(sender:)), for: .valueChanged)
        // Update Table View)
        tableView.refreshControl = refreshControl
    }
    
    private func updateWeatherDataContainerView(with weatherData: [WeatherDayData]) {
        // Show Weather Data Container View
        weatherDataContainerView.isHidden = false
        // Update Table View
        tableView.reloadData()
    }
    
    override func reloadData() {
        updateView()
    }
    
    private func updateView() {
        activityIndicatorView.stopAnimating()
        tableView.refreshControl?.endRefreshing()
        if let week = week {
            updateWeatherDataContainerView(with: week)
        } else {
            messageLabel.isHidden = false
            messageLabel.text = "Cloudy was unable to fetch weather data."
        }
    }

    // MARK: - Actions
    @objc func didRefresh(sender: UIRefreshControl) {
        delegate?.controllerDidRefresh(controller: self)
    }
    
}

extension WeekViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        week == nil ? 0 : 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let week = week else {
            return 0
        }
        return week.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherDayTableViewCell.reuseIdentifier, for: indexPath) as? WeatherDayTableViewCell else {
            fatalError("Unable to Dequeue Weather Day Table View Cell")
        }

        if let week = week {
            // Fetch Weather Data
            let weatherData = week[indexPath.row]

            var windSpeed = weatherData.windSpeed
            var temperatureMin = weatherData.temperatureMin
            var temperatureMax = weatherData.temperatureMax

            if UserDefaults.temperatureNotation != .fahrenheit {
                temperatureMin = temperatureMin.toCelcius
                temperatureMax = temperatureMax.toCelcius
            }

            // Configure Cell
            cell.dayLabel.text = dayFormatter.string(from: weatherData.time)
            cell.dateLabel.text = dateFormatter.string(from: weatherData.time)

            let min = String(format: "%.0f°", temperatureMin)
            let max = String(format: "%.0f°", temperatureMax)

            cell.temperatureLabel.text = "\(min) - \(max)"

            if UserDefaults.unitsNotation != .imperial {
                windSpeed = windSpeed.toKPH
                cell.windSpeedLabel.text = String(format: "%.f KPH", windSpeed)
            } else {
                cell.windSpeedLabel.text = String(format: "%.f MPH", windSpeed)
            }

            cell.iconImageView.image = imageForIcon(withName: weatherData.icon)
        }
        return cell
    }

}
