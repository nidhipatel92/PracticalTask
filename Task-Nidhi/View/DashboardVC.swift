//
//  DashboardVC.swift
//  Task-Nidhi
//
//  Created by Nidhi patel on 03/05/23.
//

import UIKit

class DashboardVC: UIViewController {
    //MARK: - Outlets & Variables
    var objProduct = [Product]()
    
    @IBOutlet weak var tblView: UITableView!
    //MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.commonInit()
    }
}

//MARK: - Custom Methods
extension DashboardVC{
    func commonInit(){
        self.registerCell()
        self.getData()
    }
    
    func getData(){
        APIClass.sharedInstance.getProductDetails { productData, errorMsg in
//            print(productData)
//            print(errorMsg as Any)
            self.objProduct = productData
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
    func registerCell(){
        tblView.rowHeight = UITableView.automaticDimension
        tblView.estimatedRowHeight = 251
        tblView.register(UINib(nibName: "ProductTCell", bundle: nil), forCellReuseIdentifier: "ProductTCell")
    }
}

//MARK: - Action Methods
extension DashboardVC{
    @IBAction func btnCartClicked(_ sender: UIButton) {
        let objCartVC = UIStoryboard.main.instantiate(type:CartVC.self)
        self.navigationController?.pushViewController(objCartVC, animated:true)
    }
    
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        userdefault.set(nil, forKey: Keys.email)
        let objLoginVC = UIStoryboard.main.instantiate(type:LoginVC.self)
        self.navigationController?.pushViewController(objLoginVC, animated:true)
    }
}

//MARK: - Tableview Methods
extension DashboardVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objProduct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductTCell", for: indexPath) as! ProductTCell
        cell.selectionStyle = .none
        let product = self.objProduct[indexPath.row]
        cell.lblTitle.text = product.title ?? ""
        cell.lblPrice.text = "\(product.price ?? 0)"
        cell.lblDescription.text = product.description ?? ""
        
        let url = URL(string: product.image!)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            cell.imgProduct.image = UIImage(data: imageData)
        }
        cell.btnAddToCart.tag = indexPath.row
        cell.btnAddToCart.addTarget(self, action: #selector(addToCartClicked(sender:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    @objc func addToCartClicked(sender: UIButton){
        let product = self.objProduct[sender.tag]
        
        DatabaseHelper.sharedInstance.saveProductDetails(count: 1, email: userdefault.value(forKey: Keys.email) as! String, productid: "\(product.id!)", productname: product.title!, price: "\(product.price!)"){ message in
            
        }
    }
}
