//
//  PopupViewController.swift
//  AtoCash
//
//  Created by user on 18/04/21.
//

import UIKit


protocol popupDismissDelegate : NSObjectProtocol{
    func didRejectAction(_ text : String)
}

class PopupViewController: UIViewController,UITextViewDelegate {

    @IBOutlet weak var rejectBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    @IBOutlet weak var tRejectReason: UILabel!
    @IBOutlet weak var tRejectTitle: UILabel!
    @IBOutlet weak var txtReason: IQTextView!
    weak var rejectDelegate : popupDismissDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func setupUI(){
        self.tRejectTitle.text = NSLocalizedString("rej", comment: "")
        self.tRejectReason.text = NSLocalizedString("rej_reason", comment: "")
        self.txtReason.textAlignment = .defaultAlignment
        self.cancelBtn.setTitle(NSLocalizedString("cancel", comment: ""), for: .normal)
        self.rejectBtn.setTitle(NSLocalizedString("rej", comment: ""), for: .normal)
    }

    @IBAction func rejectAction(_ sender: Any) {
       
        if self.txtReason.text == "" {
            Loaf(NSLocalizedString("rej_error", comment: ""), state: .error, location: .top, sender: self).show(.short, completionHandler: nil)
        }
        else{
            
            let alert = UIAlertController(title: NSLocalizedString("rej", comment: ""), message: NSLocalizedString("reject_request", comment: ""), preferredStyle: .alert)
            let okAlert = UIAlertAction(title: NSLocalizedString("yes", comment: ""), style: .default) { (action) in
                self.rejectDelegate?.didRejectAction(self.txtReason.text!)
                self.dismiss(animated: true, completion: nil)
            }
            let cancelAlert = UIAlertAction(title: NSLocalizedString("no", comment: ""), style: .cancel, handler: nil)
            alert.addAction(okAlert)
            alert.addAction(cancelAlert)
            self.present(alert, animated: true, completion: nil)
            
           
        
        }
    }
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard let text1 = textView.text else { return true }
        let allowedCharacters = CharacterSet(charactersIn:"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 .")//Here change this characters based on your requirement
        let characterSet = CharacterSet(charactersIn: text)
        
        let newLength = text1.utf16.count + text.utf16.count - range.length
        return newLength <= 100 && allowedCharacters.isSuperset(of: characterSet)
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
