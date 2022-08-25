//
//  EditViewController.swift
//  LastMVVMTask

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var justLabel: UILabel!
    @IBOutlet weak var newTitletext: UITextField!
    @IBOutlet weak var newBodyText: UITextField!
    
    var viewmodel = EditViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
    }
    
    func initView(){
        newTitletext.text = viewmodel.editPost?.title
        newBodyText.text = viewmodel.editPost?.body
    }


    
    @IBAction func editTapped(_ sender: Any) {
        viewmodel.apiEditPost(post: Post(id: (viewmodel.editPost?.id)!, title: newTitletext.text!, body: newBodyText.text!), handler: {isEdited in
            if isEdited{
                self.navigationController?.dismiss(animated: true)
            }
        })
    }
    
}
