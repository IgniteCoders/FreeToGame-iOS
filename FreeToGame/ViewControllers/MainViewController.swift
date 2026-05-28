//
//  ViewController.swift
//  FreeToGame
//
//  Created by Tardes on 28/5/26.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var gameList: [Game] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        
        Task {
            gameList = await GameService.getGamesList()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let game = gameList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Game Cell", for: indexPath) as! GameViewCell
        cell.render(with: game)
        return cell
    }

}

