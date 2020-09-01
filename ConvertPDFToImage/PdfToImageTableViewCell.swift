//
//  PdfToImageTableViewCell.swift
//  ConvertPDFToImage
//
//  Created by Mauricio Esteves on 2020-09-01.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit

class PdfToImageTableViewCell: UITableViewCell {

    @IBOutlet weak var receiptImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(image: UIImage) {
        self.receiptImageView.image = image
    }
}
