//
//  ViewController.swift
//  Project 7: Whitehouse Petitions(JSON)
//
//  Created by Amr Hesham on 1/8/20.
//  Copyright © 2020 Amr Hesham. All rights reserved.
//

import UIKit
//testing git
class ViewController: UITableViewController {
    var petitions = [Petition]()
    var filteredArray = [Petition]()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showAlertWithTextField))
        // Do any additional setup after loading the view.
        let urlString:String
        if navigationController?.tabBarItem.tag == 0{
            urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
            
        }else{
            urlString = "https://www.hackingwithswift.com/samples/petitions-2.json"
        }
        DispatchQueue.global(qos: .userInitiated).async {
            [weak self] in
        if let url = URL(string: urlString){
            if let data = try? Data(contentsOf: url){
                self?.parse(data: data)
                
            }else{
                self?.showError()
            }
            
        }else{
            self?.showError()
                }
                
            }
    }
    
    func parse(data:Data){
        let decoder = JSONDecoder()
        
        if let jsonPetitions =  try? decoder.decode(Petitions.self, from: data){
           petitions = jsonPetitions.results
            filteredArray = petitions
            DispatchQueue.main.async {
                [weak self] in
                self?.tableView.reloadData()

            }
        }
    }
    
    func showError(){
        DispatchQueue.main.async {
            [weak self] in
        let ac = UIAlertController(title: "Error", message: "there was a problem loading the data please check your connection", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(ac,animated: true)
            
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  filteredArray.count

    }
    
    @objc func showAlertWithTextField(){
        let ac = UIAlertController(title: "Search", message: "enter the name of the petition you want to look for", preferredStyle: .alert)
        ac.addTextField()
        
        ac.addAction(UIAlertAction(title: "Search", style: .default, handler: {
            action in
            guard let searchWord = ac.textFields?[0].text else{return}
            self.search(word: searchWord)
        }))
        present(ac,animated: true)
    }
    
    func search(word:String){
        filteredArray.removeAll()
        for petition in petitions{
            if petition.title.contains(word){
                filteredArray.append(petition)
            }
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = filteredArray[indexPath.row].title
        cell.detailTextLabel?.text = filteredArray[indexPath.row].body
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailedViewController()
        vc.detailedItem = filteredArray[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filteredArray = petitions
        tableView.reloadData()
    }
}

