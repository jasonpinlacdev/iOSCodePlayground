//
//  SettingsViewController.swift
//  Cloudy
//
//  Created by Bart Jacobs on 03/10/16.
//  Copyright © 2016 Cocoacasts. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: AnyObject {
    func controllerDidChangeTimeNotation(controller: SettingsViewController)
    func controllerDidChangeUnitsNotation(controller: SettingsViewController)
    func controllerDidChangeTemperatureNotation(controller: SettingsViewController)
}

class SettingsViewController: UIViewController {

    // MARK: - Properties

    @IBOutlet var tableView: UITableView!

    // MARK: -

    weak var delegate: SettingsViewControllerDelegate?

    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Title
        title = "Settings"

        // Setup View
        setupView()
    }

    // MARK: - View Methods

    private func setupView() {
        // Configure Table View
        tableView.separatorInset = UIEdgeInsets.zero
    }

}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {

    private enum Section: Int, CaseIterable {
        
        // MARK: - Cases
        
        case time
        case units
        case temperature

        // MARK: - Properties
        
        var numberOfRows: Int {
            2
        }

    }

    // MARK: - Table View Data Source Methods

    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected Section")
        }
        
        return section.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
            fatalError("Unable to Dequeue Settings Table View Cell")
        }

        switch section {
        case .time:
            cell.mainLabel.text = (indexPath.row == 0) ? "12 Hour" : "24 Hour"

            let timeNotation = UserDefaults.timeNotation
            if indexPath.row == timeNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .units:
            cell.mainLabel.text = (indexPath.row == 0) ? "Imperial" : "Metric"

            let unitsNotation = UserDefaults.unitsNotation
            if indexPath.row == unitsNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        case .temperature:
            cell.mainLabel.text = (indexPath.row == 0) ? "Fahrenheit" : "Celcius"

            let temperatureNotation = UserDefaults.temperatureNotation
            if indexPath.row == temperatureNotation.rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }

        return cell
    }

    // MARK: - Table View Delegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected Section")
        }

        switch section {
        case .time:
            let timeNotation = UserDefaults.timeNotation
            guard indexPath.row != timeNotation.rawValue else { return }

            if let newTimeNotation = TimeNotation(rawValue: indexPath.row) {
                // Update User Defaults
                UserDefaults.timeNotation = newTimeNotation

                // Notify Delegate
                delegate?.controllerDidChangeTimeNotation(controller: self)
            }
        case .units:
            let unitsNotation = UserDefaults.unitsNotation
            guard indexPath.row != unitsNotation.rawValue else { return }

            if let newUnitsNotation = UnitsNotation(rawValue: indexPath.row) {
                // Update User Defaults
                UserDefaults.unitsNotation = newUnitsNotation

                // Notify Delegate
                delegate?.controllerDidChangeUnitsNotation(controller: self)
            }
        case .temperature:
            let temperatureNotation = UserDefaults.temperatureNotation
            guard indexPath.row != temperatureNotation.rawValue else { return }

            if let newTemperatureNotation = TemperatureNotation(rawValue: indexPath.row) {
                // Update User Defaults
                UserDefaults.temperatureNotation = newTemperatureNotation

                // Notify Delegate
                delegate?.controllerDidChangeTemperatureNotation(controller: self)
            }
        }

        tableView.reloadSections(IndexSet(integer: indexPath.section), with: .none)
    }

}
