//
//  SecondPageVC.swift
//  KiliaroAssignment
//
//  Created by Benyamin Mokhtarpour on 9/29/21.
//

import Foundation
import UIKit
import SDWebImage

class SecondPageVC : UIViewController {
    var model : model._image!
    lazy var imgHolder : UIImageView = {
        let res = UIImageView()
        res.contentMode = .scaleAspectFit
        res.translatesAutoresizingMaskIntoConstraints = false
        return res
    }()
    lazy var lblCreatedAt : UILabel = {
        let res = UILabel()
        res.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        res.layer.cornerRadius = 5
        res.clipsToBounds = true
        res.backgroundColor = .lightGray.withAlphaComponent(0.5)
        res.translatesAutoresizingMaskIntoConstraints = false
        res.textAlignment = .center
        return res
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupUI()
        configure()
    }
    private func setupUI() {
        addImageHolder()
        addLabel()
    }
    private func configure() {
        if model != nil {
            imgHolder.sd_setImage(with: URL(string: model.downloadUrl), completed: nil)
            lblCreatedAt.text = model.created_at
        }
    }
    private func addLabel() {
        view.addSubview(lblCreatedAt)
        NSLayoutConstraint.activate([
            lblCreatedAt.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 5),
            lblCreatedAt.heightAnchor.constraint(equalToConstant: 30),
            lblCreatedAt.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 5),
            lblCreatedAt.rightAnchor.constraint(equalTo: self.view.rightAnchor,constant: -5)
        ])

    }
    private func addImageHolder() {
        view.addSubview(imgHolder)
        NSLayoutConstraint.activate([
            imgHolder.topAnchor.constraint(equalTo: self.view.topAnchor),
            imgHolder.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            imgHolder.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            imgHolder.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
}
