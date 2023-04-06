//
//  HomescreenViewController.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import UIKit

class HomescreenViewController: UIViewController {
    
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    var presenter: HomescreenViewToPresenterProtocol?
    var listData: [ModelData] = []

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initCollectionView(collectionView: listCollectionView, nibName: "ListCollectionViewCell")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.fetchList()
     
    }
    
    private func setup() {
        let presenter: HomescreenInteractorToPresenterProtocol & HomescreenViewToPresenterProtocol = HomescreenPresenter()
        let interactor: HomescreenPresenterToInteractorProtocol = HomescreenInteractor()
        
        self.presenter = presenter
        presenter.view = self
        presenter.interactor = interactor
        interactor.presenter = presenter
    }
    
    private func initCollectionView(collectionView: UICollectionView, nibName: String) {
        let nib = UINib(nibName: nibName, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: nibName)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
}
extension HomescreenViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == listCollectionView {
            print(listData.count, "++++++")
            return self.listData.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.listCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCollectionViewCell", for: indexPath) as! ListCollectionViewCell
            let data = listData[indexPath.row]
            cell.titleLabel.text = data.title
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.listCollectionView {
            let vc = DetailViewController()
            vc.detailData = listData[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

extension HomescreenViewController: HomescreenPresenterToViewProtocol {
    func showList(data: [ModelData]?) {
        listData = data ?? []
        listCollectionView.reloadData()
    }
    
    func showErrorList(error: String) {
        
    }
}
