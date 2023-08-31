//
//  OrdersViewController.swift
//  AdminAskhanaApp
//
//  Created by Leila Tolegenova on 09.06.2022.
//

import UIKit

class OrdersViewController: UIViewController {

    let service = FoodNetworkingService()
    var order: [ShowOrder] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        service.getOrders(){ [weak self] orderItems in
            DispatchQueue.main.async {
                self?.order = orderItems
                
                self?.tableView.reloadData()
                
            }
            
        }

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        service.getOrders(){ [weak self] orderItems in
            DispatchQueue.main.async {
                self?.order = orderItems
                
                self?.tableView.reloadData()
                
            }
            
        }
        
    }
    


}
extension OrdersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        order.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell",
                                                 for: indexPath) as! OrdersTableViewCell
        let orderItem = order[order.count - indexPath.row-1]
        let orderMeals = orderItem.order_details
        var body = ""
        for index in 0 ... orderMeals.count-1{
            if index == orderMeals.count-1{
                body = body + orderMeals[index].product_order_details.name + " x" + String(orderMeals[index].quantity) + "."
            }else{
                body = body + orderMeals[index].product_order_details.name + " x" + String(orderMeals[index].quantity) + ", "
            }
            
            
        }
        
        let dateValue = orderItem.order_date
        let index = dateValue.firstIndex(of: "T") ?? dateValue.endIndex
        let date = dateValue[..<index]
        let dateString = String(date)
        let viewmodel = OrdersTableViewCellViewModel(date: dateString, body: body, price: orderItem.order_amount)
       
        cell.configure(viewmodel: viewmodel)
        return cell
    }

}
