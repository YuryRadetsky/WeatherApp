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

class FavoriteTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        
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
    
    
    @IBAction func tapEditButton(_ sender: Any) {
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UserSettings.shared.favoriteCity.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = UserSettings.shared.favoriteCity[indexPath.row]
        return cell
    }
    
    ///функция для редактирования рядов
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        UserSettings.shared.favoriteCity.swapAt(sourceIndexPath.row, destinationIndexPath.row )
        UserSettings.shared.saveToDefaults()
        tableView.reloadData()
    }
    
    ///функция для редактирования рядов
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let favoriteVC = segue.destination as? FavoriteViewController {
            favoriteVC.city = city
        }
    }
    
}
