//
//  CovidSummaryController.swift
//  CovidLookup
//
//  Created by Neema on 12/3/20.
//  Copyright © 2020 Neema Philippe. All rights reserved.
//
// add search bar

import UIKit

class CovidSummaryController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    private let apiClient = APIClient()
    
    private var countriesSummary = [Summary]() {
        didSet { //property observer listens for changes on this property
            DispatchQueue.main.async { // we have to update UI on the main thread
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCovidData()
        tableView.dataSource = self 

    }
    

    private func fetchCovidData() {
        apiClient.fetchCovidData { [weak self]
            (result) in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let countries):
                self?.countriesSummary = countries
            }
        }
    }
    
}
extension CovidSummaryController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countriesSummary.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath)
        let countrySummary = countriesSummary[indexPath.row]
        cell.textLabel?.text = countrySummary.country
        cell.detailTextLabel?.text = "Confirmed: \(countrySummary.totalConfrimed), Recovered: \(countrySummary.totalRecovered)"
        return cell
    }
    
    
    
    
    
    
}
