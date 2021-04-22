//
//  ViewController.swift
//  WeatherApp
//
//  Created by Yury Radetsky on 24.05.2020.
//  Copyright © 2020 YuryRadetsky. All rights reserved.
//

import UIKit
import CoreData
//swiftlint:disable all

final class FavoriteTableViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private var table: UITableView!
    
    // MARK: - Properties
    
    private var cities: [City] = []
    private var segueIdentifier = "FavoriteCityVC"
    private var cellIdentifier = "Cell"
    private let context = (UIApplication.shared.delegate as! AppDelegate).coreDataStack.persistentContainer.viewContext
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let fetchRequest: NSFetchRequest<City> = City.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "index", ascending: true)]
        do {
            cities = try context.fetch(fetchRequest)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - Public Methods
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let favoriteVC = segue.destination as? FavoriteViewController {
            if let indexPath = self.table.indexPathForSelectedRow {
                guard let city = cities[indexPath.row].title else { return }
                favoriteVC.cityName = city
            }
        }
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        table.tableFooterView = UIView()
    }
    
    private func saveNewCity(withTitle title: String) {
        guard let entity = NSEntityDescription.entity(forEntityName: "City", in: context) else {
            return
        }
        let cityObject = City(entity: entity, insertInto: context)
        cityObject.title = title
        do {
            try context.save()
            cities.append(cityObject)
            cityObject.index = Int64(cities.endIndex - 1)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction private func saveTapped(_ sender: UIBarButtonItem) {
        let alertController = UIAlertController(title: "New city", message: "Please add new city", preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) {  (_) in
            let textField = alertController.textFields?.first
            if let newCityTitle = textField?.text {
                self.saveNewCity(withTitle: newCityTitle)
                self.table.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addTextField(configurationHandler: nil)
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction private func editTapped(_ sender: Any) {
        table.isEditing = !table.isEditing
    }
    
}

// MARK: - UITableViewDataSource

extension FavoriteTableViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let city = cities[indexPath.row]
        cell.textLabel?.text = city.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let itemMove = cities[sourceIndexPath.row]
        cities.remove(at: sourceIndexPath.row)
        cities.insert(itemMove, at: destinationIndexPath.row)
        
        for (index, city) in cities.enumerated() {
            city.index = Int64(index)
        }
        
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard let city = cities[indexPath.row] as? City,
              editingStyle == .delete else { return }
        context.delete(city)
        cities.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        do {
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
}

// MARK: - UITableViewDelegate

extension FavoriteTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let city = cities[indexPath.row] as? City else { return }
        performSegue(withIdentifier: segueIdentifier, sender: nil)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Your favorite list is empty."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cities.count > 0 ? 0 : view.bounds.height / 1.5
    }
    
}
