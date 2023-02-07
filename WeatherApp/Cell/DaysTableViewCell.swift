//
//  DaysTableViewCell.swift
//  WeatherApp
//
//  Created by Emil on 07.12.2022.
//

import UIKit

class DaysTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        stackViewForDaysCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    //properties
    var dayLabel: UILabel = {
        let label: UILabel = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 30, height: 21)
        label.textAlignment = .left
        label.contentMode = .left
        label.textColor = .white
        label.text = "Saturday"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private var imageInDayCell: UIImageView = {
        let imageView1 = UIImageView()
        imageView1.contentMode = .scaleAspectFit
        return imageView1
    }()
    
    private var tempereratureMax: UILabel = {
        let label: UILabel = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 40, height: 21)
        label.textAlignment = .center
        label.textColor = .white
        label.text = "+5"
        label.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private var tempereratureMin: UILabel = {
        let label: UILabel = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 35, height: 21)
        label.textAlignment = .center
        label.textColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1)
        label.text = "+5"
        label.font = UIFont.systemFont(ofSize: 23, weight: .medium)
        
        label.layer.cornerRadius = 3
        label.layer.backgroundColor = .init(gray: 0, alpha: 0.2)
        
        return label
    }()
    
    
    func configure(tempMax: String, tempMin: String, weatherImage: String) {
            
        self.tempereratureMax.text = tempMax
        self.tempereratureMin.text = tempMin

        switch weatherImage {
        case "0" : self.imageInDayCell.image = UIImage(named: "0")
        case "1","2","3" : self.imageInDayCell.image = UIImage(named: "1")
        case "45","48" : self.imageInDayCell.image = UIImage(named: "45")
        case "51","53","55" : self.imageInDayCell.image = UIImage(named: "51")
        case "56","57" : self.imageInDayCell.image = UIImage(named: "56")
        case "61","66" : self.imageInDayCell.image = UIImage(named: "61")
        case "63","65", "67" : self.imageInDayCell.image = UIImage(named: "63")
        case "71","77" : self.imageInDayCell.image = UIImage(named: "71")
        case "73","75" : self.imageInDayCell.image = UIImage(named: "73")
        case "80","81","82" : self.imageInDayCell.image = UIImage(named: "80")
        case "85","86" : self.imageInDayCell.image = UIImage(named: "85")
        case "95","96","99" : self.imageInDayCell.image = UIImage(named: "95")
        default:
            UIImage(named: "0")
        }
}
    
    private func stackViewForDaysCell() {
        
        let stackRightH = UIStackView(arrangedSubviews: [imageInDayCell, tempereratureMax, tempereratureMin])
        stackRightH.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        stackRightH.translatesAutoresizingMaskIntoConstraints = false
        stackRightH.alignment = .center
        stackRightH.axis = .horizontal
        stackRightH.distribution = .fillEqually
        stackRightH.isLayoutMarginsRelativeArrangement = false

        let fullDayStackH = UIStackView(arrangedSubviews: [dayLabel, stackRightH])
        fullDayStackH.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 100)
        fullDayStackH.translatesAutoresizingMaskIntoConstraints = false
        fullDayStackH.alignment = .center
        fullDayStackH.spacing = 20
        fullDayStackH.axis = .horizontal
        fullDayStackH.distribution = .fillEqually
            
        addSubview(fullDayStackH)
        //important
        NSLayoutConstraint.activate([
            fullDayStackH.topAnchor.constraint(equalTo: topAnchor, constant: 13),
            fullDayStackH.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            fullDayStackH.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -11),
            fullDayStackH.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -13),
        ])
    }
}


