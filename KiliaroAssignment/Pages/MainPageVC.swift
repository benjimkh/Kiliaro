//
//  ViewController.swift
//  KiliaroAssignment
//
//  Created by Benyamin Mokhtarpour on 9/27/21.
//

import Foundation
import UIKit

class MainPageVC : UIViewController {
    private var _vm : MainPageVM!
    private var dataSource : [model._image] = []
    private let refreshControl = UIRefreshControl()

    lazy var collectionView: UICollectionView = {
       let res = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: makeLayout())
        res.register(MainPageCell.self, forCellWithReuseIdentifier: "MainPageCell")
        res.translatesAutoresizingMaskIntoConstraints = false
        res.delegate = self
        res.dataSource = self

        res.showsVerticalScrollIndicator = false
        res.alwaysBounceVertical = true
        return res
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        callViewModel()
        createUI()
    }
    private func createUI() {
        createCollectionView()
    }
    private func createCollectionView() {
        self.view.addSubview(self.collectionView)
        NSLayoutConstraint.activate([
            self.collectionView.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
        refreshControl.addTarget(self, action: #selector(didPullToRefresh(_:)), for: .valueChanged)
        collectionView.refreshControl = refreshControl // iOS 10+

    }
    @objc private func didPullToRefresh(_ sender: Any) {
        _vm.manageCache()
        _vm.callSharedAlbumImagesAPI()
        refreshControl.endRefreshing()
    }

    func makeLayout() -> UICollectionViewLayout {
        let layout = CustomCollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.display = .grid
        return layout
    }
    private func callViewModel() {
        _vm = MainPageVM()
        _vm.bindDatasourceViewModelToController = {
            self.updateDataSource()
        }

    }
    private func updateDataSource(){
        
        self.dataSource = self._vm.imageData
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    override func didReceiveMemoryWarning() {
        _vm.manageCache()
    }

    
    
}
extension MainPageVC : UICollectionViewDelegate , UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainPageCell", for: indexPath) as? MainPageCell else { return UICollectionViewCell() }
        cell.imgHolder.image = nil
        cell.modelDs = dataSource[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    
}
extension MainPageVC : MainPageCellTapDelegate {
    func didTapOnCell(image: model._image) {
        let vc = SecondPageVC()
        vc.model = image
        vc.modalPresentationStyle = .automatic
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
