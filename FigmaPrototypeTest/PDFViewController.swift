//
//  PDFViewController.swift
//  FigmaPrototypeTest
//
//  Created by Sohel Rana on 31/1/23.
//

import UIKit
import PDFKit
import ANLoader
class PDFViewController: UIViewController {
    
    private var pdfView = PDFView()

    @IBOutlet weak var pdfVieww: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView.backgroundColor = .clear
            let value = UIInterfaceOrientation.landscapeRight.rawValue
            UIDevice.current.setValue(value, forKey: "orientation")
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            ANLoader.showLoading("Deck Loading...", disableUI: true)
        }
           
            DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            
            self.pdfView.translatesAutoresizingMaskIntoConstraints = false
            self.pdfVieww.addSubview(self.pdfView)
            self.pdfView.maxScaleFactor = 4.0;
//            self.pdfView.minScaleFactor = self.pdfView.scaleFactorForSizeToFit
            self.pdfView.autoScales = true;

                self.pdfView.topAnchor.constraint(equalTo: self.pdfVieww.topAnchor).isActive = true
                self.pdfView.bottomAnchor.constraint(equalTo: self.pdfVieww.bottomAnchor).isActive = true
                self.pdfView.leadingAnchor.constraint(equalTo: self.pdfVieww.leadingAnchor).isActive = true
                self.pdfView.trailingAnchor.constraint(equalTo: self.pdfVieww.trailingAnchor).isActive = true

                let sampleDocumentURL = URL(string: "https://baller-ac.s3.amazonaws.com/deck.pdf")

        let sampleDocument = PDFDocument(url: sampleDocumentURL!)

            self.pdfView.document = sampleDocument
                ANLoader.hide()
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func backAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    override var shouldAutorotate: Bool {
       return true
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
