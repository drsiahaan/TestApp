//
//  DetailViewController.swift
//  TestApp
//
//  Created by Dicka Reynaldi on 06/04/23.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var userId: UILabel!
    @IBOutlet weak var id: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    var detailData : ModelData?

    override func viewDidLoad() {
        super.viewDidLoad()
        userId?.text = "User Id: \(detailData?.userId ?? 0)"
        id?.text = "ID: \(detailData?.id ?? 0)"
        titleLabel?.text = "Title: \(detailData?.title ?? "")"
        bodyLabel.text = "Body: \(detailData?.body ?? "")"
    }

}
