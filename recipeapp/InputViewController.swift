//
//  InputViewController.swift
//  recipeapp
//
//  Created by yuki hiruma on 2022/08/07.
//

//レシピ一覧を押すと内容を保存してレシピ一覧に戻る仕様

import UIKit
import RealmSwift

class InputViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var processTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    
    let realm = try! Realm()
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //背景をタップしたらdismissKeyboardメソッドを呼ぶように設定する
//        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target:self, action:#selector(dismissKeyboard))
//        self.view.addGestureRecognizer(tapGesture)
        
        titleTextField.text = recipe.title
        memoTextView.text = recipe.memo
        processTextView.text = recipe.process
        
    }
    
    @objc func dismissKeyboard(){
        //キーボードを閉じる
        view.endEditing(true)
    }
    
    //imageviewに写真を登録する
    @IBAction func selectimage(_ sender: UITapGestureRecognizer) {
        //UIimageViewがタップされた時の動作を実装
        //画像を選択する時の画面の用意
        let pickerController = UIImagePickerController()
        
        //画像の取得先はフォトライブラリ
        pickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        //画像が選択された時の動作をどこに記述するかを設定する
        pickerController.delegate = self
        
        //画像を選択する画面(pickerController)を表示する
        present(pickerController, animated: true, completion: nil)
        
    }
    
    //先ほどselfに動作を記述すると書いたので、ここから動作を書いていく
    //キャンセルされた場合の動作
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        //画面選択を閉じる
        dismiss(animated: true, completion: nil)
    }
    //画像が選択された場合の動作
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let selectedImage = info[UIImagePickerController] else {fatal
    
        //イメージビューに表示
        imageView.image = selectedImage
        //画像選択画面を閉じる
        dismiss(animated: true, completion: nil)
    
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
