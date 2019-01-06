//
//  ViewController.swift
//  WeatherApp
//
//  Created by Niklas Persson on 2018-12-24.
//  Copyright © 2018 Niklas Persson. All rights reserved.
//

import UIKit
class WeatherViewController: UIViewController {
    
    @IBOutlet weak var test: UIImageView!
    
    var userDefault = UserDefault()
    var consolidated_weather = [Weather.Content_weather]()
    
    var cityLabel:UILabel!
    var degreesLabel: UILabel!
    var actualDegreesLabel: UILabel!
    var windLabel: UILabel!
    var image1: UIImageView!
    var moreInfoButton: UIButton!
    var changeCountry: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getWeatherData()
    }
    
    // MARK: - SETUP VIEW AND CONSTRAINTS
    func setupView(){
        self.view.backgroundColor = UIColor.black
        
        cityLabel = UILabel()
        cityLabel.textAlignment = .center
        cityLabel.font = UIFont(name: cityLabel.font.fontName, size:50)
        cityLabel.textColor = .white
        cityLabel.numberOfLines = 0
        self.view.addSubview(cityLabel)
        
        degreesLabel = UILabel()
        degreesLabel.textAlignment = .center
        degreesLabel.font = UIFont(name: degreesLabel.font.fontName, size:60)
        degreesLabel.textColor = .white
        degreesLabel.numberOfLines = 0
        self.view.addSubview(degreesLabel)
        
        windLabel = UILabel()
        windLabel.textAlignment = .center
        windLabel.font = UIFont(name: windLabel.font.fontName, size:22)
        windLabel.textColor = .white
        windLabel.numberOfLines = 0
        self.view.addSubview(windLabel)
        
        moreInfoButton = UIButton()
        moreInfoButton.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: 50)
        moreInfoButton.backgroundColor = UIColor.black
        moreInfoButton.setTitle("  More info  ", for: .normal)
        moreInfoButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        moreInfoButton.isEnabled = false
        moreInfoButton.layer.cornerRadius = 10
        moreInfoButton.layer.borderWidth = 1
        moreInfoButton.layer.borderColor = UIColor.white.cgColor
        moreInfoButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(moreInfoButton)
        
        changeCountry = UIButton()
        changeCountry.frame = CGRect(x: self.view.frame.size.width - 60, y: 60, width: 50, height: 50)
        changeCountry.backgroundColor = UIColor.black
        changeCountry.setTitle("  Change city  ", for: .normal)
        changeCountry.addTarget(self, action: #selector(changeCity), for: .touchUpInside)
        changeCountry.isEnabled = false
        changeCountry.layer.cornerRadius = 10
        changeCountry.layer.borderWidth = 1
        changeCountry.layer.borderColor = UIColor.white.cgColor
        changeCountry.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.view.addSubview(changeCountry)
        
        image1 = UIImageView()
        let screenSize: CGRect = UIScreen.main.bounds
        image1.frame = CGRect(x: 0, y: 0, width: screenSize.height * 0.1, height: screenSize.height * 0.1)
        image1.clipsToBounds = true
        self.view.addSubview(image1)
        
        setUpAutoLayout()
    }
    
    func setUpAutoLayout(){
        let screenSize: CGRect = UIScreen.main.bounds
        
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        cityLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cityLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        //cityLabel.text = chosenCityTitle
        cityLabel.text = userDefault.getValues().0
        print("\(userDefault.getValues().0)")
        
        degreesLabel.translatesAutoresizingMaskIntoConstraints = false
        degreesLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        degreesLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 5).isActive = true
        degreesLabel.text = "..."
        
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        windLabel.topAnchor.constraint(equalTo: degreesLabel.bottomAnchor, constant: 10).isActive = true
        windLabel.text = "..."
        
        image1.translatesAutoresizingMaskIntoConstraints = false
        image1.topAnchor.constraint(equalTo: windLabel.bottomAnchor,constant:round(screenSize.height/20)).isActive = true
        image1.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-screenSize.width/20).isActive = true
        image1.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant:screenSize.width/20).isActive = true
        image1.bottomAnchor.constraint(equalTo: moreInfoButton.topAnchor,constant:-round(screenSize.height/20)).isActive = true
        image1.contentMode = .scaleAspectFit
        
        changeCountry.translatesAutoresizingMaskIntoConstraints = false
        changeCountry.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:20).isActive = true
        changeCountry.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        
        moreInfoButton.translatesAutoresizingMaskIntoConstraints = false
        moreInfoButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant:-20).isActive = true
        moreInfoButton.leadingAnchor.constraint(equalTo: changeCountry.trailingAnchor, constant:20).isActive = true
        moreInfoButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
    }
    
    // MARK: - BUTTON ACTION
    @objc func changeCity(sender: UIButton!) {
        performSegue(withIdentifier: "GoBack", sender: sender)
    }
  
    @objc func buttonAction(sender: UIButton!) {
        let alert = UIAlertController(title: "More info", message: "Weather state:  \(consolidated_weather[0].weather_state_name)\n Wind direction: \(consolidated_weather[0].wind_direction_compass)\n Min temperature: \(consolidated_weather[0].min_temp) ℃\n Max temperature: \(consolidated_weather[0].max_temp) ℃\n Wind speed: \(round(consolidated_weather[0].wind_speed))-mph \n Wind direction: \(round(consolidated_weather[0].wind_direction)) ℃\n Air Pressure: \(round(consolidated_weather[0].air_pressure))\n Humidity: \(consolidated_weather[0].humidity)% \n Visibility: \(round(consolidated_weather[0].visibility)) miles\n Predictability: \(consolidated_weather[0].predictability)%" , preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
                
            }}))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - GET DATA WEATHER FROM SELECTED CITY
    func getWeatherData (){
        guard let url = URL(string: "\(GET_WEATHER_DATA_WITH)\(userDefault.getValues().1)/") else {return}
        URLSession.shared.dataTask(with:url) { (data, response, err)in
            guard let data = data else { return }
            
            do{
                let decoder = JSONDecoder()
                let weather = try decoder.decode(Weather.self, from: data)
                self.consolidated_weather = weather.consolidated_weather
                self.changeLabels()
            } catch let jsonErr {
                print("Error serilise stuff", jsonErr)
            }
            }.resume()
    }
    
    func changeLabels() {
        DispatchQueue.main.async {
            self.moreInfoButton.isEnabled = true
            self.moreInfoButton.backgroundColor = UIColor.lightGray
            self.changeCountry.isEnabled = true
            self.changeCountry.backgroundColor = UIColor.lightGray
            let temperature = round(self.consolidated_weather[0].the_temp)
            self.degreesLabel.text = "\(temperature)℃"
            self.image1.addImageFromURL(urlString:"\(GET_IMAGE_WITH)\(self.consolidated_weather[0].weather_state_abbr).png")
            self.windLabel.text = howWindy(Int(self.consolidated_weather[0].wind_speed))
        }
    }
}

  // MARK: - GET IMAGE FROM API AND GET STRING FOR WIND SPEED
extension UIImageView {
    func addImageFromURL(urlString: String) {
        guard let imgURL: NSURL = NSURL(string: urlString) else { return }
        let request: NSURLRequest = NSURLRequest(url: imgURL as URL)
        NSURLConnection.sendAsynchronousRequest(
            request as URLRequest, queue: OperationQueue.main,
            completionHandler: {(response: URLResponse? ,data: Data? ,error: Error? ) -> Void in
                if error == nil {
                    self.image = UIImage(data: data!)
                }
        })
    }
}

func howWindy(_ wind:Int)-> (String){
    switch wind {
    case 0:
        return "No wind at all"
    case 1...3:
        return "Light Air"
    case 4...7:
        return "Light Breeze"
    case 8...12:
        return "Gentle Breeze"
    case 13...18:
        return "Moderate Breeze"
    case 19...24:
        return "Fresh Breeze"
    case 25...31:
        return "Strong Breeze"
    case 32...38:
        return "Near Gale / Moderate Gale"
    case 39...46:
        return "Gale / Fresh Gale"
    case 47...54:
        return "Strong Gale"
    case 55...63:
        return "Storm / Whole Gale"
    case 64...75:
        return "Violent Storm / Storm"
    case(75...):
        return "Hurricane"
        
    default:
        return "No Wind"
    }
}







