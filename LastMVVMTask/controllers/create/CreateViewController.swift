//
//  CreateViewController.swift
//  LastMVVMTask


import UIKit

class CreateViewController: UIViewController {
    @IBOutlet weak var justTitle: UILabel!
    @IBOutlet weak var titleText: UITextField!
    @IBOutlet weak var bodyText: UITextField!
    
    var viewmodel = CreateViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func createTapped(_ sender: Any) {
        viewmodel.apiCreatePost(post: Post(title: titleText.text!, body: bodyText.text!), handler: {isCreated in
            if isCreated{
                self.navigationController?.popToRootViewController(animated: true)
            }
        })
    }
}
