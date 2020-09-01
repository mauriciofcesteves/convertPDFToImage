//
//  ViewController.swift
//  ConvertPDFToImage
//
//  Created by Mauricio Esteves on 2020-09-01.
//  Copyright © 2020 personal. All rights reserved.
//

import UIKit
import PDFKit

class PdfToImageViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var pdfListURL: [URL] = Array(repeating: URL(string: "http://www.orimi.com/pdf-test.pdf")!, count: 30)
    var images = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.register(UINib(nibName: "PdfToImageTableViewCell", bundle: nil), forCellReuseIdentifier: "PdfToImageTableViewCell")
        
        parsePDFToImage()
    }
    
    /// Parses the PDF URL list to a list of Images in the background thread.
    func parsePDFToImage() {
        DispatchQueue(label: "parsing", qos: .background).async {
            for pdfURL in self.pdfListURL {
                
                if let image = self.drawPDFfromURL(url: pdfURL) {
                    self.images.append(image)
                }
            }

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func drawPDFfromURL(url: URL) -> UIImage? {
        guard let document = CGPDFDocument(url as CFURL) else {
            return nil
        }
        
        return drawPDF(from: document)
    }
    
    func drawPDF(from document: CGPDFDocument) -> UIImage? {
        guard let page = document.page(at: 1) else { return nil }

        let pageRect = page.getBoxRect(.mediaBox)
        
        let renderer = UIGraphicsImageRenderer(size: pageRect.size)
//        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 375, height: 100))
        
        let image = renderer.image { ctx in
            UIColor.white.set()
            ctx.fill(pageRect)

            ctx.cgContext.translateBy(x: 0.0, y: pageRect.size.height)
//            ctx.cgContext.translateBy(x: 0.0, y: 400.0)
            
            ctx.cgContext.scaleBy(x: 1.0, y: -1.0)

            ctx.cgContext.drawPDFPage(page)
        }

        return image
    }
}

extension PdfToImageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "PdfToImageTableViewCell", for: indexPath) as? PdfToImageTableViewCell {
            
            cell.update(image: images[indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
    
    
}
