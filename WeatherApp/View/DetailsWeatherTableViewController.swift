//
//  DetailsWeatherTableViewController.swift
//  WeatherApp
//
//  Created by Emil on 03.12.2022.
//

import UIKit


class DetailsWeatherTableViewController: UITableViewController , UICollectionViewDataSource, UICollectionViewDelegate{
    
    var weatherModel: Weather?
    
    var collectionView: UICollectionView!
    
    let reuseIdentifier = "cell"
    
    private let currentDate = Date()
    private var dateComponent = DateComponents()
    private let formatter = DateFormatter()
    private var futureSevenDays: [String] = []
    
    private let screenW = UIScreen.main.bounds.width
    private let screenH = UIScreen.main.bounds.height
    
    
    //properties for DetailCollectionView.swift
    lazy var temperatureLabel: UILabel = {
         let label: UILabel = UILabel()
         label.textColor = .white
         label.textAlignment = .center
         label.text = "23"
         label.font = UIFont.systemFont(ofSize: 63, weight: .regular)
         return label
     }()
    
    lazy var detailHeaderImage: UIImageView = {
        let imageView1 = UIImageView()
        imageView1.frame = CGRect(x: 0, y: 0,  width: screenW, height: 300)
        imageView1.image = UIImage(named: "morningHead")
        imageView1.contentMode = .scaleAspectFill
        return imageView1
    }()
    
    var celciusLabel: UILabel {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.textAlignment = .natural
        label.text = "°"
        label.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        return label
    }
    
    lazy var cityNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Nefteyugansk"
        label.font = UIFont.systemFont(ofSize: 45, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        getFutureSevenDays(inDay: 1)
        tableView.showsVerticalScrollIndicator = false
        tableView.register(DaysTableViewCell.self, forCellReuseIdentifier: "cell1")
        tableView.contentInsetAdjustmentBehavior = .never
        
        configureHeaderLabels()
        configBGImageInTableView(wit: weatherModel) //vot
        configureHeaderImage(wit: weatherModel)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .default
    }
    
    
    private func configBGImageInTableView(wit weather: Weather?) {
        let index = weather?.indexHourlyTime
        
        guard let index = index else {return}
        switch (index) {
        case (0...2): return self.tableView.backgroundView = UIImageView(image: UIImage(named: "night"));
        case (2...6): return self.tableView.backgroundView = UIImageView(image: UIImage(named: "morning"));
        case (6...18): return self.tableView.backgroundView = UIImageView(image: UIImage(named: "day"));
        case (19...23): return self.tableView.backgroundView = UIImageView(image: UIImage(named: "night"));
        default:
            return self.tableView.backgroundView = UIImageView(image: UIImage(named: "day"));
        }
    }
    
    private func getFutureSevenDays(inDay: Int) {
        formatter.dateFormat = "EEEE"
        formatter.locale = Locale(identifier: "en_US_POSIX")
        dateComponent.day = 0
        for _ in 1...7 {
            guard let futureDate = Calendar.current.date(byAdding: dateComponent, to: currentDate) else {return}
            let ee = formatter.string(from: futureDate)
            futureSevenDays.append(ee)
            dateComponent.day? += inDay
        }
    }
 
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return collectionWithTableHeader
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //remove spacing between header and cells
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return 300
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let temperMaxDailyCount = weatherModel?.temperature2MMaxDaily.count else {return 0}
        return temperMaxDailyCount
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell1 = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! DaysTableViewCell
        cell1.selectionStyle = .none
        
        guard let temperatureMax = weatherModel?.temperature2MMaxDailyString[indexPath.row] else {return cell1}
        guard let temperatureMin = weatherModel?.temperature2MMinDailyString[indexPath.row] else {return cell1}
        guard let weatherCodeImage = weatherModel?.weathercodeDailyString[indexPath.row] else {return cell1}
        
        let days = futureSevenDays[indexPath.row]
        cell1.dayLabel.text = days
        
        cell1.configure(tempMax: temperatureMax, tempMin: temperatureMin, weatherImage: weatherCodeImage)
        cell1.backgroundColor = .white.withAlphaComponent(0)
        return cell1
    }
}
