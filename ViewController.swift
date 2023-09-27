//
//  ViewController.swift
//  UIKitProject
//
//  Created by Obde Willy on 13/07/23.
//

//
/// Desafio:
/// Crie um aplicativo de lista de tarefas onde
/// o usuário possa adicionar
/// e excluir itens da lista.
/// Cada item da lista deve ser exibido em uma célula de tabela contendo um texto descritivo
/// e um botão de exclusão.
/// Ao tocar no botão de exclusão, o item correspondente deve ser removido da lista.

//Dicas:
//
//Use um UITableView para exibir a lista de tarefas.
//Implemente um UITextField e um UIButton para permitir que o usuário adicione novos itens à lista.
//Crie uma estrutura de dados, como um array, para armazenar os itens da lista.
//Utilize o padrão de delegado (delegate pattern) para lidar com a ação de exclusão de itens.
//Boa sorte e divirta-se desenvolvendo seu aplicativo de lista de tarefas em UIKit!

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var initialTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var taskTextField: UITextField!
    var taskArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        addButton.setTitle("Adicionar", for: .normal)
        initialTableView.delegate = self
        initialTableView.dataSource = self
        taskTextField.delegate = self
        taskTextField.placeholder = "Type a new task"
        taskTextField.returnKeyType = .done
        taskTextField.autocapitalizationType = .sentences
        
    }
    
    @IBAction func addButtonClicked(_ sender: Any) {
        addTask()
    }
    
    func addTask() {
        if let value = taskTextField.text {
            taskArray.append(value)
            initialTableView.reloadData()
            taskTextField.text = nil
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //        let label = UILabel()
        //
        //        label.text = taskArray[indexPath.row]
        //        label.translatesAutoresizingMaskIntoConstraints = false
        //
        //        cell.addSubview(label)
        //        label.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 20).isActive = true
        //        label.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
        //        label.frame = cell.bounds
        
        cell.textLabel?.text = taskArray[indexPath.row]
        
        return cell
    }
    
    // this method handles row deletion
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            taskArray.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Hide the keyboard
        textField.resignFirstResponder()
        
        addTask()
        
        return true
    }
}
