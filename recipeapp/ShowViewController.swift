//
//  ShowViewController.swift
//  recipeapp
//
//  Created by yuki hiruma on 2022/08/08.
//

import UIKit
import RealmSwift

class ShowViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var processTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    let realm = try! Realm()
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappeaar(_ animated: Bool){
        try! realm.write{
            self.recipe.title = self.titleTextField.text!
            self.recipe.memo = self.memoTextView.text!
            self.recipe.process = self.processTextView.text!
            self.recipe.image = self.imageView.image!  //実装中断＠08111535
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
