//
//  OrdersTableViewCell.swift
//  AdminAskhanaApp
//
//  Created by Leila Tolegenova on 09.06.2022.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    var viewModel = OrdersTableViewCellViewModel()
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
 
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBOutlet weak var orderBtnOutlet: UIButton!
    @IBAction func orderStatus(_ sender: Any) {
        orderBtnOutlet.tintColor = UIColor(named: "Green")
        
        //orderBtnOutlet.backgroundColor = UIColor(named: "Green")
        orderBtnOutlet.setTitleColor(UIColor(named: "Gray"), for: .normal)
        orderBtnOutlet.setTitle("Выполнен", for: .normal)
    }
    func configure(viewmodel: OrdersTableViewCellViewModel) {
        self.viewModel = viewmodel
        //priceLabel.text = String(viewmodel.price) + " тенге"
        bodyLabel.text = viewmodel.body
        dateLabel.text = viewmodel.date
    }

}
class OrdersTableViewCellViewModel {
    var date: String
    var body: String
    var price: Int
    
    init(date: String, body: String, price: Int){
        self.date = date
        self.body = body
        self.price = price
        
    }
    init(){
        date = ""
        body = ""
        price = 0
    }
}
