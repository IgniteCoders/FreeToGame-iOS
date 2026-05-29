//
//  DetailViewController.swift
//  FreeToGame
//
//  Created by Tardes on 29/5/26.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var browserImageView: UIImageView!
    @IBOutlet weak var desktopImageView: UIImageView!
    
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var developerLabel: UILabel!
    
    @IBOutlet var roundedViews: [UIView]!
    
    
    var game: Game!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        for view in roundedViews {
            view.layer.cornerRadius = 16
        }
        
        
        navigationItem.title = game.title
        
        titleLabel.text = game.title
        genreLabel.text = game.genre
        thumbnailImageView.loadFrom(url: game.thumbnail)
        
        browserImageView.isHidden = !game.platform.contains("Web Browser")
        desktopImageView.isHidden = !game.platform.contains("PC (Windows)")
        
        publisherLabel.text = game.publisher
        developerLabel.text = game.developer
        
        Task {
            game = await GameService.getGameById(game.id)
            
            DispatchQueue.main.async {
                self.loadData()
            }
        }
    }
    
    func loadData() {
        descriptionLabel.text = game.description
    }
    
    @IBAction func showMore(_ sender: UIButton) {
        if descriptionLabel.numberOfLines == 0 {
            descriptionLabel.numberOfLines = 5
            sender.setTitle("Show more", for: .normal)
        } else {
            descriptionLabel.numberOfLines = 0
            sender.setTitle("Show less", for: .normal)
        }
    }
    
    @IBAction func playNow(_ sender: Any) {
        if let url = URL(string: game.gameUrl) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func share(_ sender: Any) {
        // set up activity view controller
        let textToShare = [ game.profileUrl ]
        // let textToShare = [ "Take a look to this free game: \(game.profileUrl)" ]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
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
