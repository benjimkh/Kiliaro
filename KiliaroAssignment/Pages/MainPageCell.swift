//
//  MainPageCell.swift
//  KiliaroAssignment
//
//  Created by Benyamin Mokhtarpour on 9/28/21.
//

import Foundation
import UIKit
import SDWebImage
protocol MainPageCellTapDelegate {
    func didTapOnCell(image: model._image)
}

class MainPageCell: UICollectionViewCell {


    let lblSize: UILabel = {
        let res = UILabel()
        res.font = UIFont.systemFont(ofSize: 14,weight: .bold)
        res.textColor = UIColor.white
        res.text = "Size : "
        res.textAlignment = .center
        res.layer.cornerRadius = 5
        res.clipsToBounds = true
        res.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        res.translatesAutoresizingMaskIntoConstraints = false
        return res
    }()

    var delegate : MainPageCellTapDelegate!

    let imgHolder: UIImageView = {
        let res = UIImageView()
        res.backgroundColor = UIColor.clear
        res.translatesAutoresizingMaskIntoConstraints = false
        return res
    }()

    var modelDs : model._image! {
        didSet {
            if modelDs != nil {
                configure(image: modelDs)
            }
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)

        addViews()
    }

    private func configure(image: model._image) {
        let qParams = "?w=\(300)&h=\(300)"
        
        SDWebImageManager.shared.loadImage(
            with: URL(string: image.thumbnailUrl + qParams ),
            options: .highPriority,
            progress: nil) { (image, data, error, cacheType, isFinished, imageUrl) in
            if isFinished {
                if image != nil {
                    self.imgHolder.image = image
                }
            }
        }
        
        
        self.lblSize.text = "Size: ~ \(sizeCalculatorInMB(size: image.size)) MB"
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap(_:)))
        addGestureRecognizer(tap)

    }
    @objc func didTap(_ sender: Any) {
        if self.modelDs != nil {
            delegate.didTapOnCell(image: self.modelDs)
        }
    }
    private func sizeCalculatorInMB(size: Int64) ->  Double {
        let MBvalue  = Double(size) / (1_024 * 1_024)
        return MBvalue.rounded(FloatingPointRoundingRule.up)
    }
    private func returnHeight(image: model._image) -> String {
        return "\(Int(((image.res_x / image.res_y))*(Float(UIScreen.main.bounds.width) / 3)))"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imgHolder.sd_cancelCurrentImageLoad()
        self.imgHolder.image = UIImage(named: "") // set to default/placeholder image
    }

    func addViews(){
        backgroundColor = UIColor.white

        addSubview(imgHolder)
        addSubview(lblSize)

        
        NSLayoutConstraint.activate([
            imgHolder.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            imgHolder.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            imgHolder.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            imgHolder.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])

        NSLayoutConstraint.activate([
            lblSize.heightAnchor.constraint(equalToConstant: 25),
            lblSize.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            lblSize.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            lblSize.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])


    }



    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
