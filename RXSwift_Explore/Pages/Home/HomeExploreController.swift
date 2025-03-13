//  HomePageController.swift
//  RXSwift_Explore
//
//  Created by zhang dekai on 2025/2/27.
//  Copyright © 2025 mr dk. All rights reserved.
//

import Foundation
import UIKit

class HomeExploreController : UIViewController {
    
    let tableview = UITableView()
    
    let list = ["User Page","Show SwiftMessages","Show Loading"]
    
    override func viewDidLoad() {
        title = "Explore"
        view.backgroundColor = .white;
        
        addTableview()
        
    }
    
    func addTableview(){
        view.addSubview(tableview)
        tableview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(ExploreListTableViewCell.self, forCellReuseIdentifier: "explore_list")
        tableview.reloadData()
    }
    
    
}

extension HomeExploreController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "explore_list", for: indexPath) as! ExploreListTableViewCell
        
        cell.titleLabel.text = list[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleTap(indexPath.row)
    
    }
    
    func handleTap(_ index: Int){
        
        switch (index){
        case 0:
            let vc = UserViewController()
            navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            MessagesShowUntil.show("Hi, you made it!!!")
            break
            
        case 2:
            LoadingUntil.show()
            break
        
            
            
        default:
            break
        }
    
    }
}


class ExploreListTableViewCell : UITableViewCell {
    
    let titleLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        titleLabel.font = .systemFont(ofSize: 15)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.left.top.equalTo(12)
            make.height.equalTo(20)
        }
    }
    
    //    func setData(T data){
    //        titleLabel.text = T
    //    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
