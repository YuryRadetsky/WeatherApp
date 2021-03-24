//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
//swiftlint:disable trailing_whitespace
//swiftlint:disable vertical_whitespace

class FavoriteTableViewController: UIViewController {
        
    @IBOutlet var table: UITableView!
    
    var favoriteCity = UserSettings.shared.favoriteCity
    var city = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        table.reloadData()
    }
    
    @IBAction func saveTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New city", message: "Please add new city", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { [weak self] (_) in
            
            guard let textField = alertController.textFields?.first,
                  textField.text != "" else { return }
            
            if let newCity = textField.text {
                UserSettings.shared.favoriteCity.append(newCity)
                UserSettings.shared.saveToDefaults()
                self?.table.reloadData()
            }
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func editTapped(_ sender: Any) {
        if table.isEditing {
            table.isEditing = false
        } else {
            table.isEditing = true
        }
    }
    
    func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let favoriteVC = segue.destination as? FavoriteViewController {
            favoriteVC.city = city
        }
    }
    
}


extension FavoriteTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserSettings.shared.favoriteCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = UserSettings.shared.favoriteCity[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        UserSettings.shared.favoriteCity.swapAt(sourceIndexPath.row, destinationIndexPath.row )
        UserSettings.shared.saveToDefaults()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserSettings.shared.favoriteCity.remove(at: indexPath.row)
            UserSettings.shared.saveToDefaults()
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cities = UserSettings.shared.favoriteCity
        city = cities[indexPath.row]
        performSegue(withIdentifier: "FavoriteCityVC", sender: nil)
    }
    
}
