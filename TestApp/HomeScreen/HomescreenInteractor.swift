//
//  HomescreenInteractor.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import RxSwift

class HomescreenInteractor: HomescreenPresenterToInteractorProtocol {
    var presenter: HomescreenInteractorToPresenterProtocol?
    let disposeBag = DisposeBag()

    func fetchList() {
        HomescreenApiConnector.instance.getTitle().do(onNext: { data in
            self.presenter?.listFetched(data: data ?? [])
        }, onError: { error in
            self.presenter?.listFetchedFailed(error: "\(error)")
        })
        .subscribe()
        .disposed(by: disposeBag)
    }
}
