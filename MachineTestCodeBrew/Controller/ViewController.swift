//
//  ViewController.swift
//  MachineTestCodeBrew
//
//  Created by Varender Singh on 30/05/19.
//  Copyright © 2019 Varender Singh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    lazy var activityIndicator:UIActivityIndicatorView? = {
        let indicator = UIActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: 60, height: 60));
        indicator.style = .whiteLarge;
        indicator.color = UIColor.green;
        indicator.layer.borderColor = UIColor.green.cgColor;
        indicator.layer.borderWidth = 1.0;
        indicator.hidesWhenStopped = true;
        indicator.backgroundColor = UIColor.white;
        return indicator;
    }()
    
    var objData:HomeModel?
    
    //MARK:- *********** METHOD ************
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hitApi();
      
    }
    
    func hitApi() {
        self.view.addSubview(self.activityIndicator!);
        self.activityIndicator?.center = self.view.center;
        self.activityIndicator?.startAnimating()
        ApiHandler.shared.hitApiAndGetResponse { (response, error) -> (Void) in
            DispatchQueue.main.async {
                self.activityIndicator?.stopAnimating();
                if error != nil {
                    self.showAlertInController(stringError: error!)
                }
                else {
                    self.objData = HomeModel.init(response: response!)
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    func showAlertInController(stringError:String) {
        let alertController = UIAlertController.init(title: "Alert", message: stringError, preferredStyle: .alert)
        let alertAction = UIAlertAction.init(title: "Ok", style: .default, handler: nil);
        alertController.addAction(alertAction);
        self.present(alertController, animated: true, completion: nil);
    }
}


extension ViewController:UITableViewDelegate,UITableViewDataSource {
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.objData != nil {
          return 4;
        }
        return 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell-Identifier", for: indexPath) as! CellWithCollectionView;
        if indexPath.row == 0 {
            cell.arrayRecommended = self.objData!.recommended;
           cell.typeOfView = .recommended
        }
        else if indexPath.row == 1 {
            cell.arrayFeatured = self.objData!.featured_localities;
           cell.typeOfView = .featured_localities
        }
        else if indexPath.row == 2 {
            cell.arrayBlogs = self.objData!.blogs;
            cell.typeOfView = .blogsAndArticles
        }
        else {
            cell.arrayPopularProjects = self.objData!.popularProjects;
            cell.typeOfView = .popularProjects
        }
        cell.setUpView()
        return cell;
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 244.0;
    }
}

