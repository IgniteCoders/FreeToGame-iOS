//
//  GameViewCell.swift
//  FreeToGame
//
//  Created by Tardes on 28/5/26.
//

import UIKit

class GameViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var browserImageView: UIImageView!
    @IBOutlet weak var desktopImageView: UIImageView!
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var cardShadowView: UIView!
    @IBOutlet weak var selectionView: UIView!
    
    func render(with game: Game) {
        titleLabel.text = game.title
        genreLabel.text = game.genre
        descriptionLabel.text = game.shortDescription
        thumbnailImageView.loadFrom(url: game.thumbnail)
        
        browserImageView.isHidden = !game.platform.contains("Web Browser")
        desktopImageView.isHidden = !game.platform.contains("PC (Windows)")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /*
         NOTA: masksToBounds es una propiedad que decide si el contenido se puede renderizar fuera del padre o no. En el caso de la tarjeta queremos recortar el contenido (true), pero la sobmra se tiene que pintar por fuera (false) y por eso usamos dos vistas
         */
        
        // Redondear los border de la tarjeta
        cardView.layer.cornerRadius = 16
        cardView.layer.masksToBounds = true
        
        // Bordes
        cardView.layer.borderColor = UIColor.separator.cgColor
        cardView.layer.borderWidth = 1
        
        // Dar sombra y redondear los bordes para que la sombra coincida con la tarjeta
        cardShadowView.layer.cornerRadius = 16
        cardShadowView.layer.masksToBounds = false
        cardShadowView.layer.shadowColor = UIColor.black.cgColor
        cardShadowView.layer.shadowOpacity = 0.5
        cardShadowView.layer.shadowRadius = 4
        cardShadowView.layer.shadowOffset = CGSize(width: 2, height: 2)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        contentView.backgroundColor = .systemBackground
        
        selectionView.backgroundColor = selected ? .separator : .clear
    }

}
