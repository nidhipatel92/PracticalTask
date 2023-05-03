//
//  CartVC.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 03/05/23.
//

import UIKit

class CartVC: UIViewController {

    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
    }
    
}

//MARK: - Custom Methods
extension CartVC{
    func commonInit(){
        self.registerCell()
    }
   
    func registerCell(){
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 251
        tblView.register(UINib(nibName: "CartTCell", bundle: nil), forCellReuseIdentifier: "CartTCell")
    }
}

//MARK: - Action Methods
extension CartVC{
    @IBAction func btnBackClicked(_ sender: UIButton) {
    }
}

//MARK: - Tableview Methods
extension CartVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTCell", for: indexPath) as! CartTCell
        cell.selectionStyle = .none
        
        cell.btnPlus.tag = indexPath.row
        cell.btnPlus.addTarget(self, action: #selector(PluseClicked(sender:)), for: .touchUpInside)
        cell.btnMinus.tag = indexPath.row
        cell.btnMinus.addTarget(self, action: #selector(minusClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func PluseClicked(sender: UIButton){
        
    }
    
    @objc func minusClicked(sender: UIButton){
        
    }
}
