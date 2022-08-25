//
//  HomeViewController.swift
//  LastMVVMTask

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var viewmodel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        viewmodel.apiPostList()
    }

    // MARK: - Methods
    
    func initView(){
        initNavs()
        bindViewModel()
        tableView.dataSource = self
        tableView.delegate = self
        
        
    }

    func bindViewModel(){
        viewmodel.items.bind(to: self) {strongSelf, _ in
            strongSelf.tableView.reloadData()
        }
    }

    // MARK: - Navigation
    
    func initNavs() {
        let refresh = UIImage(systemName: "arrow.clockwise")
        let add = UIImage(systemName: "plus")
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: refresh, style: .plain, target: self, action: #selector(leftTapped))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
        title = "Posts"
    }
    
    func callCreateViewcontroller(){
        let vc = CreateViewController(nibName: "CreateViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func callEditViewController(post: Post){
        let vc = EditViewController(nibName: "EditViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true, completion: nil)
        vc.viewmodel.editPost = post
    }
    
    
    // MARK: -- Actions
    
    @objc func leftTapped() {
        viewmodel.apiPostList()
    }
    
    @objc func rightTapped() {
        callCreateViewcontroller()
    }
    
    // MARK: -- Table View
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)-> Int{
        return viewmodel.items.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)-> UITableViewCell{
        let item = viewmodel.items.value[indexPath.row]
        
        let cell = Bundle.main.loadNibNamed("PostTableViewCell", owner: self, options: nil)?.first as! PostTableViewCell
        
        cell.titleLabel.text = item.title
        cell.bodyLabel.text = item.body
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeCompleteContextualAction(forRowAt: indexPath, post: viewmodel.items.value[indexPath.row])
        ])
    }
    
    
    
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [
            makeDeleteContextualAction(forRowAt: indexPath, post: viewmodel.items.value[indexPath.row])
        ])
    }
    
    
    // MARK: Contextual ACtions
    
    private func makeDeleteContextualAction(forRowAt indexPath: IndexPath, post: Post)-> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Delete") { (action, swipeButtonView, completion) in
            print("Delete Here")
            
            completion(true)
            self.viewmodel.apiPostDelete(post: post, handler: {isDeleted in
                if isDeleted{
                    self.viewmodel.apiPostList()
                }
            })
        }
    }
    
    
    private func makeCompleteContextualAction(forRowAt indexPath: IndexPath, post: Post)-> UIContextualAction{
        return UIContextualAction(style: .normal, title: "Edit") { (action, swipeButtonView, completion) in
            print("Complete Here")
            
            completion(true)
            self.callEditViewController(post: post)
        }
    }

}

