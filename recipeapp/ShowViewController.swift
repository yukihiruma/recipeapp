//
//  ShowViewController.swift
//  recipeapp
//
//  Created by yuki hiruma on 2022/08/08.
//

import UIKit
import RealmSwift

class ShowViewController: UIViewController {
    var image: UIImage!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var processTextView: UITextView!
    @IBOutlet weak var titleTextField: UITextField!
    
    let realm = try! Realm()
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(recipe) //recipeに何が入っているかの確認
        //受け取った画像をImageViewに表示する
        if recipe.image != nil {
            imageView.image = UIImage(data: recipe.image!)
        }
        
        titleTextField.text = recipe.title
        memoTextView.text = recipe.memo
        processTextView.text = recipe.process

    }
    
    //画像をJPEGに変換する
//    let imageData = image.jpegData(compressionQuality: 0.75)
    
    override func viewWillDisappear(_ animated: Bool){
        try! realm.write{
            self.recipe.title = self.titleTextField.text!
            self.recipe.memo = self.memoTextView.text!
            self.recipe.process = self.processTextView.text!
//            self.recipe.image = self.imageView. //ここに何を書いていいかわからない
            let image = imageView.image
            let imageData = image?.jpegData(compressionQuality: 0.75)
            self.recipe.image = imageData
        }
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

