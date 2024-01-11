//
//  ViewController.swift
//  PullToRefreshDemo
//
//  Created by Jason Pinlac on 1/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel: ViewModel
    
    var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Pull To Refresh Demo"
        view.backgroundColor = .systemBackground
        
        setupTableView()
        setupRefreshControl()
    
        viewModel.handler = { [weak self] event in
            switch event {
            case .refreshNamesCompleted:
                 DispatchQueue.main.async {
                     self?.refreshControl.endRefreshing()
                     self?.tableView.reloadData()
                 }
            }
        }
    }
    
    func setupRefreshControl() {
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        
        refreshControl.addTarget(self, action: #selector(refreshNames), for: .valueChanged)
        refreshControl.tintColor = UIColor.systemTeal
        
        let attributes = [
            NSAttributedString.Key.foregroundColor: UIColor.systemTeal
        ]
        
        refreshControl.attributedTitle = NSAttributedString(string: "Refreshing Names...", attributes: attributes)
    }
    
    func setupTableView() {
        tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
    
    @objc private func refreshNames() {
        viewModel.refreshNames()
    }

}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.model.names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        cell.textLabel?.text = viewModel.model.names[indexPath.row]
        return cell
    }
     
}

