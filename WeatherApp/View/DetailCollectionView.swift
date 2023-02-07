//
//  DetailTableViewController.swift
//  WeatherApp
//
//  Created by Emil on 14.12.2022.

import Foundation
import UIKit

extension DetailsWeatherTableViewController {
    
    var collectionWithTableHeader: UIView {
        let viewH = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 480))
        viewH.contentMode = .scaleToFill

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 50, height: 99)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 19)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: viewH.bounds.width, height: 120), collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.center = viewH.center
        collectionView.register(HourlyCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .white.withAlphaComponent(0)
        
        viewH.addSubview(detailHeaderImage)
        viewH.addSubview(collectionView)
        viewH.addSubview(viewForHeader)
       
        return viewH
    }
    
    
    private var viewForHeader: UIView {
        let viewH = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 180))
        viewH.contentMode = .scaleAspectFill
        
        let image = UIImage(named: "day")
        var imageView = UIImageView()
        
        imageView = UIImageView(frame: viewH.bounds)
        imageView.contentMode = .top
        imageView.image = image
        imageView.clipsToBounds = true
 
        let labelsHorizont = UIStackView(arrangedSubviews: [temperatureLabel, celciusLabel])
        labelsHorizont.translatesAutoresizingMaskIntoConstraints = false
        labelsHorizont.axis = .horizontal
        labelsHorizont.distribution = .fill
        labelsHorizont.spacing = 0
        
        let stackViewVertical = UIStackView(arrangedSubviews: [cityNameLabel, labelsHorizont])
        stackViewVertical.translatesAutoresizingMaskIntoConstraints = false
        stackViewVertical.axis = .vertical
        stackViewVertical.distribution = .fill
        stackViewVertical.spacing = 10
        stackViewVertical.alignment = .center

        viewH.addSubview(stackViewVertical)
        
        NSLayoutConstraint.activate([
            stackViewVertical.centerXAnchor.constraint(equalTo: viewH.centerXAnchor),
            stackViewVertical.centerYAnchor.constraint(equalTo: viewH.centerYAnchor)
        ])
        return viewH
    }
    
    
    func configureHeaderImage(wit weather: Weather?) {
        
        let index = weather?.indexHourlyTime
        let weatherCode = weather?.weathercodeCurrentString
        
        guard let index = index else {return}
        guard let weatherCode = weatherCode else {return}
        
        switch (index, weatherCode) {
        //night
        case (0...2, "Clear sky"): return self.detailHeaderImage.image = UIImage(named: "nightHeadClear");
        case (0...2, "Mainly clear"): return self.detailHeaderImage.image = UIImage(named: "nightHeadClear");
        case (0...2, "Partly cloudy"): return self.detailHeaderImage.image = UIImage(named: "nightHeadCloud");
        case (0...2, "Overcast"): return self.detailHeaderImage.image = UIImage(named: "nightHeadCloud");
        case (0...2, "Fog"): return self.detailHeaderImage.image = UIImage(named: "nightHeadCloud");
        case (0...2, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "nightHeadRain");
        case (0...2, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "nightHeadRain");
        case (0...2, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "nightHeadRain");
        case (0...2, "Snowly"): return self.detailHeaderImage.image = UIImage(named: "nightHeadSnow");
        //morning
        case (2...6, "Clear sky"): return self.detailHeaderImage.image = UIImage(named: "morningHeadClear");
        case (2...6, "Mainly clear"): return self.detailHeaderImage.image = UIImage(named: "morningHeadClear");
        case (2...6, "Partly cloudy"): return self.detailHeaderImage.image = UIImage(named: "morningHeadCloud");
        case (2...6, "Overcast"): return self.detailHeaderImage.image = UIImage(named: "morningHeadCloud");
        case (2...6, "Fog"): return self.detailHeaderImage.image = UIImage(named: "morningHeadCloud");
        case (2...6, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "morningHeadRain");
        case (2...6, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "morningHeadRain");
        case (2...6, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "morningHeadRain");
        case (2...6, "Snowly"): return self.detailHeaderImage.image = UIImage(named: "morningHeadSnow");
        //day
        case (6...18, "Clear sky"): return self.detailHeaderImage.image = UIImage(named: "dayHeadClear");
        case (6...18, "Mainly clear"): return self.detailHeaderImage.image = UIImage(named: "dayHeadClear");
        case (6...18, "Partly cloudy"): return self.detailHeaderImage.image = UIImage(named: "dayHeadCloud");
        case (6...18, "Overcast"): return self.detailHeaderImage.image = UIImage(named: "dayHeadCloud");
        case (6...18, "Fog"): return self.detailHeaderImage.image = UIImage(named: "dayHeadCloud");
        case (6...18, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "dayHeadRain");
        case (6...18, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "dayHeadRain");
        case (6...18, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "dayHeadRain");
        case (6...18, "Snowly"): return self.detailHeaderImage.image = UIImage(named: "dayHeadSnow");
        //night
        case (19...23, "Clear sky"): return self.detailHeaderImage.image = UIImage(named: "nightHeadClear");
        case (19...23, "Mainly clear"): return self.detailHeaderImage.image = UIImage(named: "nightHeadClear");
        case (19...23, "Partly cloudy"): return self.detailHeaderImage.image = UIImage(named: "nightHeadCloud");
        case (19...23, "Overcast"): return self.detailHeaderImage.image = UIImage(named: "nightHeadCloud");
        case (19...23, "Fog"): return self.detailHeaderImage.image = UIImage(named: "nightHeadCloud");
        case (19...23, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "nightHeadRain");
        case (19...23, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "nightHeadRain");
        case (19...23, "Rainly"): return self.detailHeaderImage.image = UIImage(named: "nightHeadRain");
        case (19...23, "Snowly"): return self.detailHeaderImage.image = UIImage(named: "nightHeadSnow");
        
        default:
            return self.detailHeaderImage.image = UIImage(named: "dayHeadCloud");
        }
    }
    
    
    func configureHeaderLabels() {
        cityNameLabel.text = weatherModel?.name
        temperatureLabel.text = weatherModel?.temperatureCurrentString
    }


    
    // MARK: - Collection view data source
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HourlyCollectionViewCell

        guard let time = weatherModel?.timeHourly[indexPath.row] else {return cell}
        guard let temperature = weatherModel?.temperature2MHourlyString[indexPath.row] else {return cell}
        guard let weatherCode = weatherModel?.weathercodeHourlyString[indexPath.row] else {return cell}
        print(time)
        
        cell.configure(with: time, temperature: temperature, weather: weatherCode)
        
        return cell
    }
}







