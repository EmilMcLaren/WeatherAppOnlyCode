//
//  HourlyCollectionViewCell.swift
//  WeatherApp
//
//  Created by Emil on 04.12.2022.
//

import UIKit

class HourlyCollectionViewCell: UICollectionViewCell {
    
        override init(frame: CGRect) {
            super.init(frame: frame)
            stackViewForHourlyCollectionCell()
        }
    
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    //properties
    private lazy var hourlyTimeLabel: UILabel  = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.text = "10"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private lazy var imageInHourly: UIImageView = {
        let imageView1 = UIImageView()
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        imageView1.image = UIImage(named: "0")
        imageView1.contentMode = .scaleAspectFit
        return imageView1
    }()
    
    private var celciusLabel: UILabel {
        let label: UILabel = UILabel()
        label.textColor = .white
        label.textAlignment = .natural
        label.text = " °"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }
    
    private lazy var hourlyTemperatureLabel: UILabel = {
        let label: UILabel = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.textAlignment = .left
        label.text = "20"
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    func configure(with time: String, temperature: String, weather: String) {
        self.hourlyTimeLabel.text = time
        self.hourlyTemperatureLabel.text = temperature
        
        switch weather {
        case "0" : self.imageInHourly.image = UIImage(named: "0")
        case "1","2","3" : self.imageInHourly.image = UIImage(named: "1")
        case "45","48" : self.imageInHourly.image = UIImage(named: "45")
        case "51","53","55" : self.imageInHourly.image = UIImage(named: "51")
        case "56","57" : self.imageInHourly.image = UIImage(named: "56")
        case "61","66" : self.imageInHourly.image = UIImage(named: "61")
        case "63","65", "67" : self.imageInHourly.image = UIImage(named: "63")
        case "71","77" : self.imageInHourly.image = UIImage(named: "71")
        case "73","75" : self.imageInHourly.image = UIImage(named: "73")
        case "80","81","82" : self.imageInHourly.image = UIImage(named: "80")
        case "85","86" : self.imageInHourly.image = UIImage(named: "85")
        case "95","96","99" : self.imageInHourly.image = UIImage(named: "95")
        default:
            UIImage(named: "0")
        }
}
    
        
    private func stackViewForHourlyCollectionCell() {
        
        let temperatureLabelStachh = UIStackView(arrangedSubviews: [hourlyTemperatureLabel, celciusLabel])
        temperatureLabelStachh.translatesAutoresizingMaskIntoConstraints = false
        temperatureLabelStachh.axis = .horizontal
        temperatureLabelStachh.distribution = .fill
        temperatureLabelStachh.spacing = 0
        
        let fullHourlyCellStackV = UIStackView(arrangedSubviews: [hourlyTimeLabel, imageInHourly, temperatureLabelStachh])
            fullHourlyCellStackV.translatesAutoresizingMaskIntoConstraints = false
            fullHourlyCellStackV.axis = .vertical
            fullHourlyCellStackV.distribution = .fillEqually
            fullHourlyCellStackV.spacing = 15
            fullHourlyCellStackV.alignment = .center
            addSubview(fullHourlyCellStackV)
        
        NSLayoutConstraint.activate([
                    fullHourlyCellStackV.topAnchor.constraint(equalTo: topAnchor, constant: 0),
                    fullHourlyCellStackV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
                    fullHourlyCellStackV.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 7),
                    fullHourlyCellStackV.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
                ])
    }
}
