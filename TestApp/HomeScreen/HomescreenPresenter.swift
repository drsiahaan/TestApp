//
//  HomescreenPresenter.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import UIKit

class HomescreenPresenter: HomescreenViewToPresenterProtocol {
    var view:HomescreenPresenterToViewProtocol?
    var interactor: HomescreenPresenterToInteractorProtocol?
    var router: HomescreenPresenterToRouterProtocol?
    
    func fetchList() {
        interactor?.fetchList()
    }
    
}

extension HomescreenPresenter: HomescreenInteractorToPresenterProtocol {
    func listFetched(data: [ModelData]) {
        view?.showList(data: data)
    }
    
    func listFetchedFailed(error: String) {
        view?.showErrorList(error: error)
    }
}
