//
//  TownTableViewCell.swift
//  WeatherApp
//
//  Created by Emil on 01.12.2022.
//

import UIKit


class TownTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        stackViewForTownCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //properties
    private lazy var currentWeatherCodeLabel: UILabel = {
     let label: UILabel = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.text = "loading..."
     label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var cityNameLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.text = "Loading City"
        label.font = UIFont.systemFont(ofSize: 34, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var temperatureLabel: UILabel = {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.textAlignment = .right
        label.text = "23"
        label.font = UIFont.systemFont(ofSize: 62, weight: .regular)
       
        return label
    }()
    
    private var celciusLabel: UILabel {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.textAlignment = .natural
        label.text = "°"
        label.font = UIFont.systemFont(ofSize: 60, weight: .thin)
        return label
    }

    
    lazy var townCellBackgroundImage: UIImageView = {
        let imageView1 = UIImageView()
        imageView1.frame = CGRect(x: 0, y: 0, width: self.frame.width , height: self.frame.height)
        imageView1.image = UIImage(named: "dayClear")
        imageView1.contentMode = .redraw
        return imageView1
    }()
    
    //configure cell
    func configure(wit weather: Weather) {
        self.cityNameLabel.text = weather.name
        self.temperatureLabel.text = weather.temperatureCurrentString
        self.currentWeatherCodeLabel.text = weather.weathercodeCurrentString
        
        let index = weather.indexHourlyTime
        let weatherCode = weather.weathercodeCurrentString
        
        switch (index, weatherCode) {
        //night
        case (0...2, "Clear sky"): return self.townCellBackgroundImage.image = UIImage(named: "nightClear");
        case (0...2, "Mainly clear"): return self.townCellBackgroundImage.image = UIImage(named: "nightClear");
        case (0...2, "Partly cloudy"): return self.townCellBackgroundImage.image = UIImage(named: "nightCloud");
        case (0...2, "Overcast"): return self.townCellBackgroundImage.image = UIImage(named: "nightCloud");
        case (0...2, "Fog"): return self.townCellBackgroundImage.image = UIImage(named: "nightCloud");
        case (0...2, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "nightRain");
        case (0...2, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "nightRain");
        case (0...2, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "nightRain");
        case (0...2, "Snowly"): return self.townCellBackgroundImage.image = UIImage(named: "nightSnow");
        //morning
        case (2...6, "Clear sky"): return self.townCellBackgroundImage.image = UIImage(named: "morningClear");
        case (2...6, "Mainly clear"): return self.townCellBackgroundImage.image = UIImage(named: "morningClear");
        case (2...6, "Partly cloudy"): return self.townCellBackgroundImage.image = UIImage(named: "morningCloud");
        case (2...6, "Overcast"): return self.townCellBackgroundImage.image = UIImage(named: "morningCloud");
        case (2...6, "Fog"): return self.townCellBackgroundImage.image = UIImage(named: "morningCloud");
        case (2...6, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "morningRain");
        case (2...6, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "morningRain");
        case (2...6, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "morningRain");
        case (2...6, "Snowly"): return self.townCellBackgroundImage.image = UIImage(named: "morningSnow");
        //day
        case (6...18, "Clear sky"): return self.townCellBackgroundImage.image = UIImage(named: "dayClear");
        case (6...18, "Mainly clear"): return self.townCellBackgroundImage.image = UIImage(named: "dayClear");
        case (6...18, "Partly cloudy"): return self.townCellBackgroundImage.image = UIImage(named: "dayCloud");
        case (6...18, "Overcast"): return self.townCellBackgroundImage.image = UIImage(named: "dayCloud");
        case (6...18, "Fog"): return self.townCellBackgroundImage.image = UIImage(named: "dayCloud");
        case (6...18, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "dayRain");
        case (6...18, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "dayRain");
        case (6...18, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "dayRain");
        case (6...18, "Snowly"): return self.townCellBackgroundImage.image = UIImage(named: "daySnow");
        //night
        case (19...23, "Clear sky"): return self.townCellBackgroundImage.image = UIImage(named: "nightClear");
        case (19...23, "Mainly clear"): return self.townCellBackgroundImage.image = UIImage(named: "nightClear");
        case (19...23, "Partly cloudy"): return self.townCellBackgroundImage.image = UIImage(named: "nightCloud");
        case (19...23, "Overcast"): return self.townCellBackgroundImage.image = UIImage(named: "nightCloud");
        case (19...23, "Fog"): return self.townCellBackgroundImage.image = UIImage(named: "nightCloud");
        case (19...23, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "nightRain");
        case (19...23, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "nightRain");
        case (19...23, "Rainly"): return self.townCellBackgroundImage.image = UIImage(named: "nightRain");
        case (19...23, "Snowly"): return self.townCellBackgroundImage.image = UIImage(named: "nightSnow");
            
        default:
            return self.townCellBackgroundImage.image = UIImage(named: "dayCloud");
        }
    }
    
    private func stackViewForTownCell() {
        
        let weatherAndCityStackV = UIStackView(arrangedSubviews: [currentWeatherCodeLabel, cityNameLabel])
        weatherAndCityStackV.translatesAutoresizingMaskIntoConstraints = false
        weatherAndCityStackV.axis = .vertical
        weatherAndCityStackV.alignment = .leading
        weatherAndCityStackV.distribution = .fillEqually
        weatherAndCityStackV.spacing = 0
        
        let temperatureStackH = UIStackView(arrangedSubviews: [temperatureLabel, celciusLabel])
        temperatureStackH.translatesAutoresizingMaskIntoConstraints = false
        temperatureStackH.axis = .horizontal
        temperatureStackH.distribution = .fill
        temperatureStackH.spacing = 0
        
        let fullTownCellStackH = UIStackView(arrangedSubviews: [weatherAndCityStackV, temperatureStackH])
        fullTownCellStackH.frame = CGRect(x: 0, y: 0, width: 100, height: 50)
        fullTownCellStackH.translatesAutoresizingMaskIntoConstraints = false
        fullTownCellStackH.axis = .horizontal
        fullTownCellStackH.distribution = .equalSpacing
        fullTownCellStackH.spacing = 0
        addSubview(fullTownCellStackH)
        
        NSLayoutConstraint.activate([
            fullTownCellStackH.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            fullTownCellStackH.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            fullTownCellStackH.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            fullTownCellStackH.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
        ])
    }
}


