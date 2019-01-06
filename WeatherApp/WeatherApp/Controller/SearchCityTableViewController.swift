//
//  SearchCityTableViewController.swift
//  WeatherApp
//
//  Created by Niklas Persson on 2019-01-03.
//  Copyright © 2019 Niklas Persson. All rights reserved.
//

import UIKit

class SearchCityTableViewController: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var searchBar: UISearchBar!
    var cityArray:[City] = []
    let userDefault = UserDefault()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Setup tableview
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
        cell.textLabel?.text = cityArray[indexPath.row].title
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: SEGUE_TO_VIEWCONTROLLER, sender: indexPath)
        
    }
    
    
    // MARK: - Search for city and get cities from API
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        if let unWrappedSearchString = searchBar.text {
            getCitiesFrom(unWrappedSearchString)
        }
    }
    
    func getCitiesFrom(_ searchText:String){
        guard let url = URL(string: "\(GET_CITY)\(String(describing: searchText))") else {return}
        URLSession.shared.dataTask(with:url) { (data, response, err)in
            guard let data = data else { return }
            
            do{
                let decoder = JSONDecoder()
                let city = try decoder.decode(Array<City>.self, from: data)
                
                self.cityArray = city
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            } catch let jsonErr {
                print("Error serilise stuff", jsonErr)
            }
            }.resume()
    }

      // MARK: - GO TO NEXT VIEW WITH SELECTED CITY
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEGUE_TO_VIEWCONTROLLER {
                let indexPath = sender as! IndexPath
            if(userDefault.userAlreadyExist()){
                print("DELETE USER")
                userDefault.removeValues()
            }
           // print("BEFORE \(userDefault.getValues().0)")
           // print("BEFORE \(userDefault.getValues().1)")
                userDefault.setValues(title:cityArray[indexPath.row].title , woeid: cityArray[indexPath.row].woeid)
            print("AFTER \(userDefault.getValues().0)")
            print("AFTER \(userDefault.getValues().1)")
            }
        }
}
