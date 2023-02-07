//
//  TownsTableViewController.swift
//  WeatherApp
//
//  Created by Emil on 01.12.2022.
//

import UIKit
import CoreLocation

private let userDefaults = UserDefaults.standard
var addRefreshControl = UIRefreshControl()

class TownsTableViewController: UITableViewController {
    

    
    private let weather = "weather"
    private var cityArrayName: [String] = userDefaults.stringArray(forKey: "weather") ?? []
    private var citiesArray: [Weather] = []

    private let emptyCity = Weather()

    private let screenH = UIScreen.main.bounds.height
    private let scrennW = UIScreen.main.bounds.size.width

    
    private var buttonFooter: UIView {
        let viewH = UIView(frame: CGRect(x: 0, y: 0, width: scrennW, height: 85))
        let imageCon = UIImage(systemName: "plus")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        let button11 = UIButton()
        
        button11.frame = CGRect(x: 0, y: 0, width: scrennW - 70, height: 60)
        button11.setTitle("add city ", for: .normal)
        button11.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button11.setImage(imageCon, for: .normal)
        button11.addTarget(self,  action: #selector(addCityButtomTarget), for: .touchUpInside)
        button11.semanticContentAttribute = .forceRightToLeft
        button11.setTitleColor(.white, for: .normal)
        button11.backgroundColor = UIColor(red: 0/255, green: 55/255, blue: 105/255, alpha: 1)
        
        button11.layer.borderColor = CGColor(red: 222/255, green: 250/255, blue: 250/255, alpha: 1)
        button11.layer.borderWidth = 5
        button11.layer.cornerRadius = 32
        
        button11.center = CGPoint(x: viewH.center.x, y: viewH.center.y)
        viewH.addSubview(button11)
        return viewH
    }
    
    private lazy var detailStatusBarImage: UIImageView = {
       let imageView1 = UIImageView()
       if UIScreen.main.bounds.height > 811 {
           imageView1.frame = CGRect(x: 0, y: 0,  width: scrennW , height: 33)
       } else {
           imageView1.frame = CGRect(x: 0, y: 0,  width: scrennW , height: 15)
       }
       return imageView1
   }()
    
    //MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        getCities()
        view.backgroundColor = .black
        
        userDefaults.set(cityArrayName, forKey: weather)
        tableView.showsVerticalScrollIndicator = false
        self.tableView.allowsSelection = false
        self.tableView.tableHeaderView = detailStatusBarImage
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(TownTableViewCell.self, forCellReuseIdentifier: "cell")
        self.tableView.contentInsetAdjustmentBehavior = .never
        self.tableView.tableFooterView = buttonFooter
        
        cityArrayName = userDefaults.stringArray(forKey: self.weather) ?? ["Moscow"]
        if citiesArray.isEmpty {
            citiesArray = Array(repeating: emptyCity, count: cityArrayName.count)
        }
        refresh()
    }
    
    //MARK: viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    
    private func refresh() {
        let refreshView = UIView(frame: CGRect(x: 0, y: 22, width: 0, height: 0))
        tableView.addSubview(refreshView)
        addRefreshControl.tintColor = .white
        addRefreshControl.addTarget(self, action: #selector(refreshAction), for: .valueChanged)
        refreshView.addSubview(addRefreshControl)
    }
    

    @objc func refreshAction(_ sender: AnyObject) {
        getCities()
        
        self.tableView.reloadData()
        addRefreshControl.endRefreshing()
    }
    private func getCities() {
        let group = DispatchGroup()
        
        getCityWeather(citiesArray: self.cityArrayName) { index, weather in
            self.citiesArray[index] = weather
            self.citiesArray[index].name = self.cityArrayName[index]

            group.notify(queue: DispatchQueue.main) { 
                self.tableView.reloadData()
                self.tableView.allowsSelection = true
                let index = weather.indexHourlyTime
                //print(type(of: index))
                self.configStatusBarImage(wit: index)
            }
        }
    }
    
    @objc func addCityButtomTarget() {
        alertAddCity(name: "Write city name", placeholder: "City name") { city in
            self.cityArrayName.append(city)
            self.citiesArray.append(self.emptyCity)
            self.getCities()
        }
    }
    
    
    private func configStatusBarImage(wit index: Int ) {
        
        switch (screenH, index) {
            
        case (...812, 0...2): return self.detailStatusBarImage.image = UIImage(named: "statusNightSE");
        case (...812, 2...6): return self.detailStatusBarImage.image = UIImage(named: "statusMorningSE");
        case (...812, 6...18): return self.detailStatusBarImage.image = UIImage(named: "statusDaySE");
        case (...812, 19...23): return self.detailStatusBarImage.image = UIImage(named: "statusNightSE");
            
        case (812..., 0...2): return self.detailStatusBarImage.image = UIImage(named: "statusNightX");
        case (812..., 2...6): return self.detailStatusBarImage.image = UIImage(named: "statusMorningX");
        case (812..., 6...18): return self.detailStatusBarImage.image = UIImage(named: "statusDayX");
        case (812..., 19...23): return self.detailStatusBarImage.image = UIImage(named: "statusNightX");
            
        default:
            return self.detailStatusBarImage.image = UIImage(named: "statusDayX");
        }
    }

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TownTableViewCell 
        cell1.selectionStyle = UITableViewCell.SelectionStyle.none
        
        var weather = Weather()
        weather = citiesArray[indexPath.row]
        
        cell1.backgroundColor = .gray.withAlphaComponent(0.5)
        cell1.backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: cell1.frame.width, height: cell1.frame.height))
        cell1.addSubview(cell1.townCellBackgroundImage)
        cell1.sendSubviewToBack(cell1.townCellBackgroundImage)
 
        cell1.configure(wit: weather)
        return cell1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        guard let indexPathTL = tableView.indexPathForSelectedRow else {return}

        let ddvc  = citiesArray[indexPathTL.row]
        let vc = DetailsWeatherTableViewController()
        vc.weatherModel = ddvc //as? Weather
        show(vc, sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, completion in

            let editingRow = self.cityArrayName[indexPath.row]

            if self.cityArrayName.firstIndex(of: editingRow) != nil {
                self.cityArrayName.remove(at: indexPath.row)
                self.citiesArray.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                userDefaults.set(self.cityArrayName, forKey: self.weather)
            }
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    

    //alert
    func alertAddCity(name: String, placeholder: String, completion: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: name, message: nil, preferredStyle: .alert)
        
        let alertOK = UIAlertAction(title: "Ok", style: .default) { [self] action in
            let texf = alertController.textFields?.first
            guard let text = texf?.text else {return}
            self.cityArrayName.append(text)
            self.citiesArray.append(self.emptyCity)
            userDefaults.set(self.cityArrayName, forKey: self.weather)
            self.getCities()
        }
        
        alertController.addTextField { tf in
            tf.placeholder = placeholder
        }
        
        let alertCancel = UIAlertAction(title: "Cancel", style: .default) { _ in}
        
        alertController.addAction(alertOK)
        alertController.addAction(alertCancel)
        
        present(alertController, animated: true, completion: nil)
    }
}

//extensions
extension String {
    var letters: String {
        return String(unicodeScalars.filter(CharacterSet.letters.contains))
    }
}

//extension TownsTableViewController {
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        if scrollView.contentOffset.y < 0 {
//            topConstraint.constant = -scrollView.contentOffset.y/2
//        } else {
//            topConstraint.constant = 0
//        }
//    }
//}

