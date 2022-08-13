//
//  ResultViewController.swift
//  recipeapp
//
//  Created by yuki hiruma on 2022/08/07.
//

import UIKit
import RealmSwift

class ResultViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    //Realmインスタンスを取得する
    let realm = try! Realm()
    
    //DB内のレシピが格納されるリスト
    //あいうえお順でソート
    //以降内容をアップデートするとリストないは自動的に更新される
    var taskArray = try! Realm().objects(Recipe.self).sorted(byKeyPath: "title", ascending: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //データを表示していない部分に罫線を追加
        tableView.fillerRowHeight = UITableView.automaticDimension
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    //データの数（＝セルの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) ->Int{
        return taskArray.count
    }
    
    //各セルの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        //再利用可能なcellを得る
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        //Cellに値を設定する　---ここから
        let recipe = taskArray[indexPath.row]
        cell.textLabel?.text = recipe.title
        //--- ここまで ---  レシピ一覧にはレシピ名だけ出ていればよいので。
        
        return cell
    }
    
    //各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        //ResultViewControllerのセルをタップした時に呼ばれるtableView(_:didSelectRowAt)メソッドへ、segueのIDを指定して遷移させるperformSegue(withIdentifier:sender)メソッドの呼び出しを追加する
        performSegue(withIdentifier: "cellSegue" ,sender: nil)
    }
    
    //セルが削除可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle{
        return .delete
    }
    
    //Deleteボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        //ここから
        if editingStyle == .delete {
            //DBから削除する
            try! realm.write{
                self.realm.delete(self.taskArray[indexPath.row])
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
    }
    //segueで画面遷移するときに呼ばれる
    //レシピを選択するとレシピが表示される->(ShowViewController)
    //＋を押すと空のレシピ追加画面が出る->(InputViewController)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
//        let inputViewController:InputViewController = segue.destination as! InputViewController
        
        //セルをタップした場合、ShowViewControllerに渡して画面表示する
        if segue.identifier == "cellSegue" {
            let indexPath = self.tableView.indexPathForSelectedRow
            let showViewController: ShowViewController = segue.destination as! ShowViewController
            showViewController.recipe = taskArray[indexPath!.row]
        } else{
            
            let recipe = Recipe()
            let inputViewController:InputViewController = segue.destination as! InputViewController
            
            let allRecipes = realm.objects(Recipe.self)
            if allRecipes.count != 0{
                recipe.id = allRecipes.max(ofProperty: "id")! + 1
            }
            
            inputViewController.recipe = recipe
        }
    }
        
    //レシピ追加/編集画面から戻ってきた時にTableViewを更新させる
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        tableView.reloadData()
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
        
