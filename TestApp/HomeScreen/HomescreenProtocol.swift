//
//  HomescreenProtocol.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import UIKit

protocol HomescreenPresenterToInteractorProtocol: AnyObject {
    var presenter: HomescreenInteractorToPresenterProtocol? { get set }
    func fetchList()
}

protocol HomescreenInteractorToPresenterProtocol: AnyObject {
    func listFetched(data: [ModelData])
    func listFetchedFailed(error: String)
}

protocol HomescreenPresenterToViewProtocol: AnyObject {
    func showList(data: [ModelData]?)
    func showErrorList(error: String)
}

protocol HomescreenViewToPresenterProtocol: AnyObject {
    var view: HomescreenPresenterToViewProtocol? { get set }
    var interactor: HomescreenPresenterToInteractorProtocol? { get set }
    var router: HomescreenPresenterToRouterProtocol? { get set }
    
    func fetchList()
}

protocol HomescreenPresenterToRouterProtocol: AnyObject {
    static func createModule() -> UIViewController
}

