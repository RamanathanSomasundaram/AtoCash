//
//  CashFIlterViewController.swift
//  AtoCash
//
//  Created by user on 08/05/21.
//

import UIKit

protocol filtersViewDelegate : NSObjectProtocol{
    func filtersPass()
}

class CashFIlterViewController: UIViewController {
    //Show & hide view
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var costCenterView: UIView!
    @IBOutlet weak var deptView: UIView!
    @IBOutlet weak var projectsView: UIView!
    @IBOutlet weak var travelPurposeView: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var travelEndDate: UIView!
    @IBOutlet weak var travelStartDate: UIView!
    @IBOutlet weak var reqEndDate: UIView!
    @IBOutlet weak var reqStartDate: UIView!
    @IBOutlet weak var employeeView: UIView!
    
    //TextField
    @IBOutlet weak var txtCostCenter: UITextField!
    @IBOutlet weak var txtDept: UITextField!
    @IBOutlet weak var txtProjects: UITextField!
    @IBOutlet weak var txtEmployee: UITextField!
    @IBOutlet weak var txtReqStart: UITextField!
    @IBOutlet weak var txtReqEnd: UITextField!
    @IBOutlet weak var txtTravelStart: UITextField!
    @IBOutlet weak var txtTravelEnd: UITextField!
    @IBOutlet weak var txtTravelDesc: UITextField!
    @IBOutlet weak var txtStatus: UITextField!
    
    //Delegate
    weak var filterDelegate : filtersViewDelegate?
    
    //Api Response Model
    var employeeList = [EmployeeVM]()
    var selectEmp : EmployeeVM?
    
    var selectedStatusType : StatusType?
    var statusTypeList = [StatusTypeVM]()
    
    var costCenterList = [CostCenterVM]()
    var selectCostCenter : CostCenterVM?
    
    var projectsList = [ProjectVM]()
    var selectProjectList : ProjectVM?
    
    var depList = [DepartmentVM]()
    var selectDept : DepartmentVM?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        getAllEmployees()
    }
    
    private func getAllEmployees(){
        showLoader()
        EmployeesAPI.apiEmployeesEmployeesForDropdownGet { (result, error) in
            if error == nil {
                self.employeeList = result ?? []
                self.getStatusTypeList()
            }
            else{
                hideLoader()
                switch error as! ErrorResponse {
                case .error(let code, let result, let message):
                    print(code,result,message)
                    if code == 401 {
                        DefaultsManager.shared.accesstoken = ""
                        DefaultsManager.shared.userRole = ""
                        DefaultsManager.shared.isRemoved = false
                        AppDelegate.shared.setupRootViewController()
                    }
                    else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
                            Loaf((json["message"] as! String), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            Loaf("Something want wrong", state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    
    private func getStatusTypeList(){
        StatusTypesAPI.apiStatusTypesStatusTypesForDropdownGet { (statusList, error) in
            if error == nil {
                self.statusTypeList = statusList ?? []
                self.getCostCenters()
            }
            else{
                hideLoader()
                switch error as! ErrorResponse {
                case .error(let code, let result, let message):
                    print(code,result,message)
                    if code == 401 {
                        DefaultsManager.shared.accesstoken = ""
                        DefaultsManager.shared.userRole = ""
                        DefaultsManager.shared.isRemoved = false
                        AppDelegate.shared.setupRootViewController()
                    }
                    else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
                            Loaf((json["message"] as! String), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    
    private func getCostCenters(){
        CostCentersAPI.apiCostCentersCostCentersForDropdownGet { (result, error) in
            if error == nil {
                self.costCenterList = result ?? []
                self.getProjects()
            }
            else{
                hideLoader()
                switch error as! ErrorResponse {
                case .error(let code, let result, let message):
                    print(code,result,message)
                    if code == 401 {
                        DefaultsManager.shared.accesstoken = ""
                        DefaultsManager.shared.userRole = ""
                        DefaultsManager.shared.isRemoved = false
                        AppDelegate.shared.setupRootViewController()
                    }
                    else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
                            Loaf((json["message"] as! String), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    
    private func getProjects(){
        ProjectsAPI.apiProjectsProjectsForDropdownGet { (result, error) in
            if error == nil {
                self.projectsList = result ?? []
                self.getDepartments()
            }
            else{
                hideLoader()
                switch error as! ErrorResponse {
                case .error(let code, let result, let message):
                    print(code,result,message)
                    if code == 401 {
                        DefaultsManager.shared.accesstoken = ""
                        DefaultsManager.shared.userRole = ""
                        DefaultsManager.shared.isRemoved = false
                        AppDelegate.shared.setupRootViewController()
                    }
                    else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
                            Loaf((json["message"] as! String), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    private func getDepartments(){
        DepartmentsAPI.apiDepartmentsDepartmentsForDropdownGet { (result, error) in
            hideLoader()
            if error == nil {
                self.depList = result ?? []
            }
            else{
                hideLoader()
                switch error as! ErrorResponse {
                case .error(let code, let result, let message):
                    print(code,result,message)
                    if code == 401 {
                        DefaultsManager.shared.accesstoken = ""
                        DefaultsManager.shared.userRole = ""
                        DefaultsManager.shared.isRemoved = false
                        AppDelegate.shared.setupRootViewController()
                    }
                    else{
                        do{
                            let json = try JSONSerialization.jsonObject(with: result!, options: .allowFragments) as! [String: AnyObject]
                            Loaf((json["message"] as! String), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                        }
                        catch{
                            print("json error \(error.localizedDescription)")
                        }
                    }
                    
                }
            }
        }
    }
    
    @IBAction func clearAction(_ sender: Any) {
    }
    @IBAction func closeAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyAction(_ sender: Any) {
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
extension CashFIlterViewController : UITextFieldDelegate{
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        //Employee
        if textField == txtEmployee{
            var projectTitle = [String]()
            for dropDown in self.employeeList{
                projectTitle.append(dropDown.fullName ?? "")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectEmp == nil ? [] : [selectEmp!.fullName ?? ""]
            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
                cell.textLabel?.text = item
                cell.separatorInset = .zero
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
                cell.layoutMargins = .zero
            }
            if (textField.text != nil) {
                simpleSelectedArray = [textField.text] as! [String]
            }
            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
                textField.text = item!
                for drop in self.employeeList{
                    if drop.fullName == item!{
                        self.selectEmp = EmployeeVM(_id: drop._id, fullName: drop.fullName)
                        break
                    }
                }
                
            }
            if #available(iOS 13.0, *) {
                selectionMenu.searchBar?.searchTextField.textColor = .white
            } else {
                // Fallback on earlier versions
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search employee name", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        
        //Status
        if textField == txtStatus{
            var projectTitle = [String]()
            for dropDown in self.statusTypeList{
                projectTitle.append(dropDown.status!)
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectedStatusType == nil ? [] : [selectedStatusType!.status]
            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
                cell.textLabel?.text = item
                cell.separatorInset = .zero
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
                cell.layoutMargins = .zero
            }
            if (textField.text != nil) {
                simpleSelectedArray = [textField.text] as! [String]
            }
            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
                textField.text = item!
                for drop in self.statusTypeList{
                    if drop.status == item!{
                        self.selectedStatusType = StatusType(_id: drop._id, status: drop.status!)
                        break
                    }
                }
                
            }
            if #available(iOS 13.0, *) {
                selectionMenu.searchBar?.searchTextField.textColor = .white
            } else {
                // Fallback on earlier versions
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search status type", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        
        //Projects
        if textField == txtProjects{
            var projectTitle = [String]()
            for dropDown in self.projectsList{
                projectTitle.append(dropDown.projectName ?? "")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectProjectList == nil ? [] : [selectProjectList!.projectName ?? ""]
            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
                cell.textLabel?.text = item
                cell.separatorInset = .zero
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
                cell.layoutMargins = .zero
            }
            if (textField.text != nil) {
                simpleSelectedArray = [textField.text] as! [String]
            }
            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
                textField.text = item!
                for drop in self.projectsList{
                    if drop.projectName == item!{
                        self.selectProjectList = ProjectVM(_id: drop._id, projectName: drop.projectName)
                        break
                    }
                }
                
            }
            if #available(iOS 13.0, *) {
                selectionMenu.searchBar?.searchTextField.textColor = .white
            } else {
                // Fallback on earlier versions
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search projects", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        //Department
        if textField == txtDept{
            var projectTitle = [String]()
            for dropDown in self.depList{
                projectTitle.append(dropDown.deptName ?? "")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectDept == nil ? [] : [selectDept!.deptName ?? ""]
            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
                cell.textLabel?.text = item
                cell.separatorInset = .zero
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
                cell.layoutMargins = .zero
            }
            if (textField.text != nil) {
                simpleSelectedArray = [textField.text] as! [String]
            }
            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
                textField.text = item!
                for drop in self.depList{
                    if drop.deptName == item!{
                        self.selectDept = DepartmentVM(_id: drop._id, deptName: drop.deptName, deptDesc: drop.deptDesc)
                        break
                    }
                }
                
            }
            if #available(iOS 13.0, *) {
                selectionMenu.searchBar?.searchTextField.textColor = .white
            } else {
                // Fallback on earlier versions
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search Department", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        //Cost Center
        if textField == txtCostCenter{
            var projectTitle = [String]()
            for dropDown in self.costCenterList{
                projectTitle.append(dropDown.costCenterCode ?? "")
            }
            
            let simpleArray: [String] = projectTitle
            var simpleSelectedArray: [String] = selectCostCenter == nil ? [] : [selectCostCenter!.costCenterCode ?? ""]
            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
                cell.textLabel?.text = item
                cell.separatorInset = .zero
                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
                cell.layoutMargins = .zero
            }
            if (textField.text != nil) {
                simpleSelectedArray = [textField.text] as! [String]
            }
            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
                textField.text = item!
                for drop in self.costCenterList{
                    if drop.costCenterCode == item!{
                        self.selectCostCenter = CostCenterVM(_id: drop._id, costCenterCode: drop.costCenterCode)
                        break
                    }
                }
                
            }
            if #available(iOS 13.0, *) {
                selectionMenu.searchBar?.searchTextField.textColor = .white
            } else {
                // Fallback on earlier versions
            }
            // show searchbar with placeholder and barTintColor
            selectionMenu.showSearchBar(withPlaceHolder: "Search Cost center", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in

                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
            }
            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
            
            
            return false
        }
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtTravelDesc{
            guard let text = textField.text else { return true }
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
            //txtCostDesc.errorMessage = newLength <= 100 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter Maximum 100 character"
            return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}
