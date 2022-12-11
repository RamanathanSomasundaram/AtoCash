//
//  CreateProjectManagmentViewController.swift
//  AtoCash
//
//  Created by user on 08/04/21.
//

import UIKit

class CreateProjectManagmentViewController: UIViewController {

    @IBOutlet weak var txtEmployee: UITextField!
    @IBOutlet weak var txtProject: UITextField!

    var selectedStatusType1 : EmployeeVM?
    var statusTypeList1 = [EmployeeVM]()
    
    var selectedStatusType : ProjectDTO?
    var statusTypeList = [ProjectVM]()
    
    @IBOutlet weak var createBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtEmployee.setupRightPadview()
        txtProject.setupRightPadview()
        self.createBtn.setTitle("CREATE", for: .normal)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
  

}
extension CreateProjectManagmentViewController : UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
  
        if textField == txtEmployee{
//            var projectTitle = [String]()
//            for dropDown in self.statusTypeList1{
//                projectTitle.append(dropDown.fullName!)
//            }
//
//            let simpleArray: [String] = projectTitle
//            var simpleSelectedArray: [String] = selectedStatusType1 == nil ? [] : [selectedStatusType1!.fullName]
//            let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
//                cell.textLabel?.text = item
//                cell.separatorInset = .zero
//                cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
//                cell.layoutMargins = .zero
//            }
//            if (textField.text != nil) {
//                simpleSelectedArray = [textField.text] as! [String]
//            }
//            selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
//                textField.text = item!
//                for drop in self.statusTypeList1{
//                    if drop.fullName == item!{
//                        self.selectedStatusType1 = EmployeeVM(_id: drop._id, fullName: drop.fullName!)
//                        break
//                    }
//                }
//
//            }
//
//            // show searchbar with placeholder and barTintColor
//            selectionMenu.showSearchBar(withPlaceHolder: "Search Currency", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in
//
//                return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
//            }
//            selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
//
//
//            return false
        }
         
            if textField == txtProject{
//                var projectTitle = [String]()
//                for dropDown in self.statusTypeList{
//                    projectTitle.append(dropDown.projectName!)
//                }
//
//                let simpleArray: [String] = projectTitle
//                var simpleSelectedArray: [String] = selectedStatusType == nil ? [] : [selectedStatusType!.projectName]
//                let selectionMenu = RSSelectionMenu(dataSource: simpleArray) { (cell, item, indexPath) in
//                    cell.textLabel?.text = item
//                    cell.separatorInset = .zero
//                    cell.textLabel?.font = UIFont(name: "SFUIDisplay-Light", size: 15.0)
//                    cell.layoutMargins = .zero
//                }
//                if (textField.text != nil) {
//                    simpleSelectedArray = [textField.text] as! [String]
//                }
//                selectionMenu.setSelectedItems(items: simpleSelectedArray) {(item, index, isSelected, selectedItems) in
//                    textField.text = item!
//                    for drop in self.statusTypeList{
//                        if drop.projectName == item!{
//                            self.selectedStatusType = Project(_id: drop._id, status: drop.projectName!)
//                            break
//                        }
//                    }
//
//                }
//
//                // show searchbar with placeholder and barTintColor
//                selectionMenu.showSearchBar(withPlaceHolder: "Search status type", barTintColor: UIColor.init(named: "NavBar")!.withAlphaComponent(0.2)) { (searchText) -> ([String]) in
//
//                    return simpleArray.filter({ $0.lowercased().contains(searchText.lowercased()) })
//                }
//                selectionMenu.show(style: .popover(sourceView: textField, size: CGSize(width: textField.frame.size.width, height: 230)), from: self)
//
//
//                return false
            }
           
        return true
    }
    
  
}
