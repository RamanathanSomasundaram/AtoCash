//
//  SideMenuViewController.swift
//  AtoCash
//
//  Created by user on 10/03/21.
//

import UIKit

class Item :NSObject{
    
    var header :String!
    var isSelected:Bool!
    var subList:[subMenuList]?
    var righuIcon : Bool
    var leftMenu : String
    
    init(head:String,subList:[subMenuList]?, leftMenu : String, rightMenu : Bool) {
        
        self.header = head
        self.isSelected = false
        self.subList = subList
        self.leftMenu = leftMenu
        self.righuIcon = rightMenu
    }
}

class subMenuList : NSObject{
    var subTitle : String!
    var subImage : String!
    
    init(subTitle : String, subImg : String){
        self.subTitle = subTitle
        self.subImage = subImg
    }
}

class SideMenuViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {

    @IBOutlet weak var tblSideMenu: UITableView!
    private var dataSource = [Item]()
    
    var selectIndexPath : IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.registerNib()
        
        if(DefaultsManager.shared.userRole == "Admin"){
        
        dataSource.append(Item(head: "Home", subList: nil, leftMenu: "Home", rightMenu: false))
        dataSource.append(Item(head: "Cost Center", subList: nil, leftMenu: "Cost Center", rightMenu: false))
        dataSource.append(Item(head: "Department", subList: nil, leftMenu: "Department", rightMenu: false))
        dataSource.append(Item(head: "Roles", subList: nil, leftMenu: "Roles", rightMenu: false))
        dataSource.append(Item(head: "Employement Type", subList: nil, leftMenu: "Expense", rightMenu: false))
        dataSource.append(Item(head: "Expense Types", subList: nil, leftMenu: "Expense", rightMenu: false))
        dataSource.append(Item(head: "Approval Strategy", subList: [subMenuList(subTitle: "Approval Group", subImg: "Approval Level"),subMenuList(subTitle: "Approval Level", subImg: "Approval Level"),subMenuList(subTitle: "Approval Role Map", subImg: "Approval Level"),subMenuList(subTitle: "Approval Status", subImg: "Approval Level")], leftMenu: "Approval Level", rightMenu: false))
        dataSource.append(Item(head: "Employee", subList: nil, leftMenu: "Employee", rightMenu: false))
        dataSource.append(Item(head: "Projects", subList: [subMenuList(subTitle: "Project", subImg: "Project"),subMenuList(subTitle: "Subproject", subImg: "Sub Project"),subMenuList(subTitle: "Task", subImg: "Task")], leftMenu: "Project", rightMenu: false))
        
        dataSource.append(Item(head: "Administrative", subList: [subMenuList(subTitle: "Assign Roles", subImg: "Project"),subMenuList(subTitle: "List of Users", subImg: "Sub Project"),subMenuList(subTitle: "List of Roles", subImg: "Task"),subMenuList(subTitle: "Assign Projects", subImg: "Project")], leftMenu: "Project", rightMenu: false))
        dataSource.append(Item(head: "Register User", subList: nil, leftMenu: "Project", rightMenu: false))
        dataSource.append(Item(head: "Currency", subList: nil, leftMenu: "Project", rightMenu: false))
        dataSource.append(Item(head: "Security - Reset Password", subList: nil, leftMenu: "Reset Password", rightMenu: false))
        }
        else{
            dataSource.append(Item(head: NSLocalizedString("home", comment: ""), subList: nil, leftMenu: "Home", rightMenu: false))
            dataSource.append(Item(head: NSLocalizedString("report", comment: ""), subList: nil, leftMenu: "Report", rightMenu: false))
        }
        
        
        self.tblSideMenu.reloadData()
        
        //self.tblSideMenu.selectRow(at: self.selectIndexPath, animated: true, scrollPosition: .none)
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
        self.tblSideMenu.reloadData()
        print("selected Index \(self.selectIndexPath)")
    }
    
    func registerNib() {
        
        let subcell = UINib(nibName: "SubCell", bundle: nil)
        self.tblSideMenu.register(subcell, forCellReuseIdentifier: "SubCell")
        
        let headcell = UINib(nibName: "HeaderCell", bundle: nil)
        self.tblSideMenu.register(headcell, forCellReuseIdentifier: "HeaderCell")
        self.tblSideMenu.tableFooterView = UIView()
        
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return dataSource.count
    }
    func homeVC()
    {
        self.dismiss(animated: true) {
            AppDelegate.shared.setupRootViewController()
        }
      
    }

    
    @objc func didClickHeader(_ sender:UIButton) {
        
        dataSource[sender.tag].isSelected = !dataSource[sender.tag].isSelected
        if ((dataSource[sender.tag].subList?.count ?? 0) > 0){
        self.tblSideMenu.reloadSections([sender.tag], with: .none)
        }
        else{
            if selectIndexPath == IndexPath(row: 0, section: sender.tag){
                self.dismiss(animated: false, completion: nil)
                return
            }
            self.selectIndexPath = IndexPath(row: 0, section: sender.tag)
            print("Header tap \(sender.tag)")
            switch sender.tag {
            case 0:
                homeVC()
                break
            case 1:
                
                if DefaultsManager.shared.userRole == "Admin"{
                
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "CostCenterViewController") as! CostCenterViewController
                self.navigationController?.pushViewController(vc, animated: true)
                }
                else{
                    if(DefaultsManager.shared.userRole == "Manager" || DefaultsManager.shared.userRole == "FinManager"){
                        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ManagerReportViewController") as! ManagerReportViewController
                        vc.isSideMenu = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                    else{
                        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ReportViewController") as! ReportViewController
                        vc.isSideMenu = true
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                break
            case 2:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "DepartmentViewController") as! DepartmentViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 3:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "RolesViewController") as! RolesViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 4:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "EmployeeTypeViewController") as! EmployeeTypeViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 5:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "ExpenseTypeViewController") as! ExpenseTypeViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 7:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "EmployeeViewController") as! EmployeeViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 10:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "RegisterViewController") as! RegisterViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 11:
                //currency
            break
            case 12:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "ResetPasswordViewController") as! ResetPasswordViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            default:
                break
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell") as? HeaderCell
        cell?.selectionButton.tag = section
        cell?.selectionButton.addTarget(self, action: #selector(didClickHeader(_:)), for: .touchUpInside)
        cell?.header.text = dataSource[section].header
        cell?.leftImg.image = UIImage(named: dataSource[section].leftMenu)?.withRenderingMode(.alwaysTemplate)
        cell?.leftImg.tintColor = UIColor.white
        cell?.rightImg.isHidden = ((dataSource[section].subList?.count ?? 0) > 0) ? false : true
        cell?.backgroundColor = self.selectIndexPath != nil ? self.selectIndexPath.section == section ? UIColor.black : UIColor.clear : UIColor.clear
        cell?.contentView.backgroundColor = self.selectIndexPath != nil ? self.selectIndexPath.section == section ? UIColor.black : UIColor.clear : UIColor.clear
    
        return cell?.contentView
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataSource[section].isSelected{
            
            return dataSource[section].subList?.count ?? 0
        }else{
            
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SubCell", for: indexPath) as? SubCell
        cell?.leftImg.image = UIImage(named: dataSource[indexPath.section].subList![indexPath.row].subImage)?.withRenderingMode(.alwaysTemplate)
        cell?.leftImg.tintColor = UIColor.white
        cell?.subHeader.text = dataSource[indexPath.section].subList![indexPath.row].subTitle
        //cell?.backgroundColor = UIColor.clear
        cell?.contentView.backgroundColor = self.selectIndexPath != nil ? self.selectIndexPath == indexPath ? UIColor.black : UIColor.clear : UIColor.clear
        cell?.backgroundColor = self.selectIndexPath != nil ? self.selectIndexPath == indexPath ? UIColor.black : UIColor.clear : UIColor.clear
        return cell ?? UITableViewCell()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("sec\(indexPath.section)  row\(indexPath.row)")
        tableView.deselectRow(at: indexPath, animated: true)
        if selectIndexPath == indexPath{
            self.dismiss(animated: false, completion: nil)
            return
        }
        self.selectIndexPath = indexPath
        if indexPath.section == 6{
        switch indexPath.row {
        case 0:
            let vc = adminStoryboard.instantiateViewController(withIdentifier: "ApprovalGroupViewController") as! ApprovalGroupViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 1:
            let vc = adminStoryboard.instantiateViewController(withIdentifier: "ApprovelLevelViewController") as! ApprovelLevelViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 2:
            let vc = adminStoryboard.instantiateViewController(withIdentifier: "ApprovalRoleMapViewController") as! ApprovalRoleMapViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            let vc = adminStoryboard.instantiateViewController(withIdentifier: "ApprovalStatusViewController") as! ApprovalStatusViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        default:
            break
        }
        }
        else if indexPath.section == 8{
            switch indexPath.row {
            case 0:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "ProjectViewController") as! ProjectViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 1:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "SubProjectViewController") as! SubProjectViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "TaskViewController") as! TaskViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            default:
                break
            }
        }
        else if indexPath.section == 9{
            switch indexPath.row {
            case 0:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "AdminAssignRoleViewController") as! AdminAssignRoleViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 1:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "ListUserViewController") as! ListUserViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 2:
                let vc = adminStoryboard.instantiateViewController(withIdentifier: "ListRoleViewController") as! ListRoleViewController
                self.navigationController?.pushViewController(vc, animated: true)
                break
            case 3:
                //Assign Projects
                break
            default:
                break
            }
        }
        
        
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
