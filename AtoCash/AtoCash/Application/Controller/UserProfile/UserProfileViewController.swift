//
//  UserProfileViewController.swift
//  AtoCash
//
//  Created by user on 28/04/21.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var btnLogout: UIButton!
    @IBOutlet weak var tCurrency: UILabel!
    @IBOutlet weak var tEmail: UILabel!
    @IBOutlet weak var tlastname: UILabel!
    @IBOutlet weak var tfirstname: UILabel!
    @IBOutlet weak var userProfileIcon: UIImageView!
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var emailAddress: UILabel!
    @IBOutlet weak var lName: UILabel!
    @IBOutlet weak var fName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let backBtn = UIBarButtonItem(image: UIImage.init(named: "back"), style: .plain, target: self, action: #selector(BackButtonTapped))
        backBtn.tintColor = .white
        self.navigationItem.leftBarButtonItem = backBtn
        
        fName.text = DefaultsManager.shared.fName ?? ""
        lName.text = DefaultsManager.shared.lName ?? ""
        emailAddress.text = DefaultsManager.shared.userEmail ?? ""
        currency.text = DefaultsManager.shared.currencyType ?? ""
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.userProfileIcon.layer.cornerRadius = self.userProfileIcon.frame.size.height / 2
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if self.islangauge(self.currentLanguage()) { return}
        self.viewUpdates()
        self.setupUI()
    }
    private func setupUI(){
        self.title = NSLocalizedString("profile", comment: "")
        btnLogout.setTitle(NSLocalizedString("logout", comment: ""), for: .normal)
        tCurrency.text = NSLocalizedString("currency_lbl", comment: "")
        tEmail.text = NSLocalizedString("email_add", comment: "")
        tlastname.text = NSLocalizedString("lastname", comment: "")
        tfirstname.text = NSLocalizedString("firstname", comment: "")
        currency.textAlignment = .defaultAlignment
        emailAddress.textAlignment = .defaultAlignment
        lName.textAlignment = .defaultAlignment
        fName.textAlignment = .defaultAlignment
        
    }
    //BAckbutton Action
    @objc func BackButtonTapped(){
        //Pop to home view controller
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func logoutAction(_ sender: Any) {
        
        let alert = UIAlertController(title: NSLocalizedString("logout", comment: ""), message: NSLocalizedString("logout_message", comment: ""), preferredStyle: .alert)
        let okAlert = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default) { (action) in
            UtilsManager.shared.logoutUser()
        }
        let cancelAlert = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .destructive, handler: nil)
        alert.addAction(okAlert)
        alert.addAction(cancelAlert)
        self.present(alert, animated: true, completion: nil)
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
