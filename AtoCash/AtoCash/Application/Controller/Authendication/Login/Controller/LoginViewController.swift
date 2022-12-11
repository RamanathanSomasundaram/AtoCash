//
//  LoginViewController.swift
//  AtoCash
//
//  Created by user on 04/02/21.
//

import UIKit
import Localize_Swift

extension NSTextAlignment {
    static var defaultAlignment: NSTextAlignment {
        if CSLanguage.currentAppleLanguage() == "ar"{
            UIView.appearance().semanticContentAttribute = .forceRightToLeft
        }
        else{
            UIView.appearance().semanticContentAttribute = .forceLeftToRight
        }
        return CSLanguage.currentAppleLanguage() == "ar" ? .right : .left
    }
}

class LoginViewController: UIViewController {
    @IBOutlet weak var forgetLbl: UILabel!
    @IBOutlet weak var sendBtn: UIButton!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtUserName: UITextField!
    //@IBOutlet weak var txtErrorUsername: UILabel!
   // @IBOutlet weak var txtErrorPass: UILabel!
    var isShow = false
    
    @IBOutlet weak var segementLanguage: UISegmentedControl!
    //Localization String
    
    @IBOutlet weak var usrNameLbl: UILabel!
    @IBOutlet weak var passLbl: UILabel!
    @IBOutlet weak var signinlabel: UILabel!
    @IBOutlet weak var signinBtn: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.islangauge(self.currentLanguage()) { return}
        
        self.segementLanguage.selectedSegmentIndex = CSLanguage.currentAppleLanguage() == "ar" ? 1 : 0
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.forgetAction(_:)))
            
        forgetLbl.isUserInteractionEnabled = true
        forgetLbl.addGestureRecognizer(tap)
        
        let rightView1 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        txtUserName.leftViewMode = UITextField.ViewMode.always
        let imageView = UIImageView(frame: CGRect(x: 8, y: 10, width: 40, height: 20))
        let image = UIImage(named: "icons8-user-male-52")
        imageView.contentMode = UIView.ContentMode.center
        imageView.image = image
        rightView1.addSubview(imageView)
        txtUserName.leftView = rightView1
        
        txtUserName.textAlignment = .defaultAlignment
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        txtPassword.leftViewMode = UITextField.ViewMode.always
        let imageView1 = UIImageView(frame: CGRect(x: 8, y: 10, width: 40, height: 20))
        let image1 = UIImage(named: "icons8-forgot-password-52")
        imageView1.contentMode = UIView.ContentMode.center
        imageView1.image = image1
        rightView.addSubview(imageView1)
        txtPassword.leftView = rightView
        
        txtPassword.isSecureTextEntry = true
        let rightView2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))
        txtPassword.rightViewMode = UITextField.ViewMode.always
        let imageView2 = UIImageView(frame: CGRect(x: 8, y: 10, width: 20, height: 20))
        let image2 = UIImage(named: "visibility")
        imageView2.tintColor = UIColor.black
        imageView2.image = image2
        rightView2.addSubview(imageView2)

        txtPassword.rightView = rightView2
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        imageView2.isUserInteractionEnabled = true
        imageView2.addGestureRecognizer(tapGestureRecognizer)
        
        
        sendBtn.layer.cornerRadius = sendBtn.layer.frame.size.height / 2
        sendBtn.layer.masksToBounds = true
       
        // Do any additional setup after loading the view.
        self.setupUI()
    }
    
    private func setupUI(){
        self.signinlabel.text = NSLocalizedString("signin_title", comment: "")
        self.signinBtn.setTitle(NSLocalizedString("signin", comment: ""), for: .normal)
        self.usrNameLbl.text = NSLocalizedString("username", comment: "")
        self.passLbl.text = NSLocalizedString("password", comment: "")
        self.forgetLbl.text = NSLocalizedString("forget", comment: "")
        self.txtUserName.textAlignment = .defaultAlignment
        self.txtPassword.textAlignment = .defaultAlignment
        
    }
    override var prefersStatusBarHidden: Bool{
        return false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.segementLanguage.selectedSegmentIndex = CSLanguage.currentAppleLanguage() == "ar" ? 1 : 0
    }
    
    @IBAction func languageSelectionAction(_ sender: Any) {
        if segementLanguage.selectedSegmentIndex == 0{
            CSLanguage.setAppleLAnguageTo(lang: "en")
        }
        else{
            CSLanguage.setAppleLAnguageTo(lang: "ar")
        }
        AppDelegate.shared.setupRootViewController()
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        if isShow{
            isShow = false
            txtPassword.isSecureTextEntry = false

            let rightView2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))

            txtPassword.rightViewMode = UITextField.ViewMode.always
            let imageView2 = UIImageView(frame: CGRect(x: 8, y: 10, width: 20, height: 20))
            let image2 = UIImage(named: "visibility-2")
            imageView2.image = image2
            rightView2.addSubview(imageView2)

            txtPassword.rightView = rightView2
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView2.isUserInteractionEnabled = true
            imageView2.addGestureRecognizer(tapGestureRecognizer)

        }else{
            isShow = true
            txtPassword.isSecureTextEntry = true

            let rightView2 = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 40))

            txtPassword.rightViewMode = UITextField.ViewMode.always
            let imageView2 = UIImageView(frame: CGRect(x: 8, y: 10, width: 20, height: 20))
            let image2 = UIImage(named: "visibility")
            imageView2.image = image2
            rightView2.addSubview(imageView2)

            txtPassword.rightView = rightView2
            
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            imageView2.isUserInteractionEnabled = true
            imageView2.addGestureRecognizer(tapGestureRecognizer)

        }
    }
        
    @IBAction func forgetAction(_ sender: Any) {
        let vc = mainStoryboard.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as! ForgetPasswordViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if txtUserName.text == "" && txtPassword.text == "" {
            //self.txtErrorPass.isHidden = false
            //self.txtErrorUsername.isHidden = false
            self.txtUserName.shake()
            self.txtPassword.shake()
        }
        else if(txtUserName.text == ""){
            //self.txtErrorUsername.isHidden = false
            self.txtUserName.shake()
            Loaf(NSLocalizedString("email_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(!UtilsManager.isValidEmail(self.txtUserName!.text!)){
            self.txtUserName.shake()
            Loaf(NSLocalizedString("email_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(txtPassword.text == ""){
            //self.txtErrorUsername.isHidden = true
            self.txtPassword.shake()
           // self.txtErrorPass.isHidden = false
            Loaf(NSLocalizedString("pass_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else if(!isValidPassword(self.txtPassword.text!)){
            self.txtPassword.shake()
            Loaf(NSLocalizedString("pass_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            //self.txtErrorUsername.isHidden = true
            //self.txtErrorPass.isHidden = true
            let concat = self.txtUserName.text?.components(separatedBy: "@")[1].components(separatedBy: ".")
            //fwserver
            let serverAddress = "foodunitco" == (concat?.first ?? "") ? "fwserver" : (concat?.first ?? "")
            DefaultsManager.shared.baseLink = serverAddress
            BASEURL = "https://" + (serverAddress) + concatBaseURL
            loginAPI()
        }
    }
    
    private func loginAPI(){
        showLoader()

        let parameterDictionary = ["email": self.txtUserName.text!,
                                   "password": self.txtPassword.text!]
        let Url = String(format: BASEURL + "/api/Account/Login")
        guard let serviceUrl = URL(string: Url) else { return }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            return
        }
        request.httpBody = httpBody
        request.timeoutInterval = 60
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                hideLoader()
            }
            if let response = response {
                print(response)
            }
            
            if error != nil {
                DispatchQueue.main.async {
                DefaultsManager.shared.baseLink = ""
                self.txtPassword.text = ""
                self.txtUserName.text = ""
                self.txtUserName.shake()
                self.txtPassword.shake()
                self.txtUserName.becomeFirstResponder()
                //invalid
                    Loaf(NSLocalizedString("invalid", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            if httpResponse.statusCode == 200 {
            if let data = data {
                do {
                    let jsonDecoder = JSONDecoder()
                    let responseModel = try jsonDecoder.decode(LoginModel1.self, from: data)
                    print("responseModel \(responseModel)")
                    DefaultsManager.shared.accesstoken = responseModel.token
                    if let userList = (responseModel.role){
                        DefaultsManager.shared.userRolesList = userList
                        
                        if(userList.contains("Admin") || userList.contains("AtominosAdmin")){
                            DefaultsManager.shared.userRole = "Admin"
                        }
                        else if(userList.contains("Finmgr")){
                            DefaultsManager.shared.userRole = "FinManager"
                        }
                        else if( userList.contains("Manager")){
                            DefaultsManager.shared.userRole = "Manager"
                        }
                        else{
                            DefaultsManager.shared.userRole = "User"
                        }
                    }
                    DefaultsManager.shared.fName = responseModel.firstName
                    DefaultsManager.shared.lName = responseModel.lastName
                    DefaultsManager.shared.userEmail = responseModel.email
                    DefaultsManager.shared.userID = responseModel.empId
                    DefaultsManager.shared.currencyType = responseModel.currencyType
                    DefaultsManager.shared.currencyId = "\(responseModel.currencyCode!)"
                    DefaultsManager.shared.fullName = DefaultsManager.shared.fName! + " " + DefaultsManager.shared.lName!
                    if DefaultsManager.shared.expenseRequest != nil {
                    if let userID = DefaultsManager.shared.expenseRequest?.keys.first{
                        if userID != DefaultsManager.shared.userID{
                            DefaultsManager.shared.expenseRequest = [(DefaultsManager.shared.userID ?? "") : []]
                        }
                    }
                    else{
                        DefaultsManager.shared.expenseRequest = [(DefaultsManager.shared.userID ?? "") : []]
                    }
                    }
                    else{
                        DefaultsManager.shared.expenseRequest = [(DefaultsManager.shared.userID ?? "") : []]
                    }
                    DispatchQueue.main.async {
                        AppDelegate.shared.setupRootViewController()
                    }
                    
                } catch {
                    print(error)
                    DefaultsManager.shared.baseLink = ""
                    Loaf(error.localizedDescription, state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                    }
                }
            }
            else{
                DispatchQueue.main.async {
                    DefaultsManager.shared.baseLink = ""
                    self.txtPassword.text = ""
                    self.txtUserName.text = ""
                    self.txtUserName.shake()
                    self.txtPassword.shake()
                    self.txtUserName.becomeFirstResponder()
                    //invalid
                    Loaf(NSLocalizedString("invalid", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
                }
                
            }
        }.resume()
    }

}

extension LoginViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if(textField == txtUserName){
            return true
        }
        else if (textField == txtPassword){
            
            guard let text = textField.text else { return true }
            textField.rightViewMode = textField.text == "" ? .never : .always
            let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789$@$!%*?&#")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            
            let newLength = text.utf16.count + string.utf16.count - range.length
           // txtPassword.errorMessage = newLength <= 15 && allowedCharacters.isSuperset(of: characterSet) ? "" : "Enter the valid password."
            return newLength <= 15 && allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

