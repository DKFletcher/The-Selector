//
//  PDFViewController.swift
//  WML
//
//  Created by Donald Fletcher on 30/12/2019.
//  Copyright © 2019 Donald Fletcher. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController, UIPrintInteractionControllerDelegate {
    
    //	var pdfView: PDFView!
    
    //	var pdfCreator : PDFCreator!
    
    
    @IBOutlet var pdfView: PDFView!
    
    var pdfDocument: PDFDocument!
    
    var card: Card!
    
    var nsData : NSData!
    
    var job : Jobs = .InfoSheet
    
    var documentData : Data!
    
    let folderName : String = "ReflectorSelector"
    
    var printButton : UIBarButtonItem!
    
    var fileButton : UIBarButtonItem!
    
    var printerName : String!
    
    let spinner : SpinnerViewController = SpinnerViewController()
    
    let directories: [FileManager.SearchPathDirectory] = [
        .documentDirectory,
        .applicationSupportDirectory,
        .cachesDirectory
    ]
    
    var focusSheet : QuestionAnswer? = nil
    
    var save : Bool = true
    
    var additionalInfoForFileName : String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pdfView = PDFView()
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)
        
        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(action))
        
        
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
        
        
        workFlow()
    }
    
    private func workFlow(){
        let name = (tabBarController as! TabBarController).learnerName
        let cards = (tabBarController as! TabBarController).cards!
        let pages = (tabBarController as! TabBarController).abstractedWorkbook
        additionalInfoForFileName = ""
        switch self.job{
        
        case .FocusSheet :
            if let focus = focusSheet, let theCard = card{
                save = true
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    let log = LearnerLog(learner: name)
                    self?.documentData = log.focusQuestion(for: focus, partOf: theCard)
                    self?.additionalInfoForFileName = " for \(theCard.name)"
                    DispatchQueue.main.async {
                        self?.pdfOnViewport()
                    }
                }
            }
            
        case .WorkSheet :
            if let theCard = card{
                save = true
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    let log = LearnerLog(learner: name)
                    self?.documentData = log.workSheet(for: theCard)
                    self?.additionalInfoForFileName = " for \(theCard.name)"
                    DispatchQueue.main.async {
                        self?.pdfOnViewport()
                    }
                }
            }
            
        case .InfoSheet :
            if let theCard = card{
                save = true
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    let collector = Collector(learner: name)
                    self?.documentData = collector.infoSheets(for: theCard, in:cards)
                    self?.additionalInfoForFileName = " for \(theCard.name)"
                    DispatchQueue.main.async {
                        self?.pdfOnViewport()
                    }
                }
            }
            
        case .Handbook :
            save = false
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let handbook = Handbook(learner: name)
                self?.documentData = handbook.handbook(from: cards)
                DispatchQueue.main.async {
                    self?.pdfOnViewport()
                }
            }
            
        case .Logbook :
            save = true
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                let log = LearnerLog(learner: name)
                self?.documentData = log.logbook(from: cards, in: pages)
                DispatchQueue.main.async{
                    self?.pdfOnViewport()
                }
            }
            
        case .DoubleLong :
            save = true
            if let theCard = card{
                let collector = Collector(learner: name)
                DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                    self?.documentData = collector.collector(for: theCard, in: cards)
                    self?.additionalInfoForFileName = " for \(theCard.name)"
                    DispatchQueue.main.async{
                        self?.pdfOnViewport()
                    }
                }
            }
        }
    }
    
    private func pdfOnViewport(){
        if let data = documentData, let document = PDFDocument(data: data){
            nsData = NSData(data: data)
            pdfDocument = document
            pdfView.displayMode = .singlePageContinuous
            pdfView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.25)
            pdfView.scaleFactor = 0.25
            pdfView.document = document
            //			documentData=Data()
        }
        
        spinner.willMove(toParent:  nil)
        spinner.view.removeFromSuperview()
        spinner.removeFromParent()
    }
    
    @objc func action(){
        let message = NSLocalizedString(job.rawValue, comment: "")
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .actionSheet)
        if save{
            alert.addAction(UIAlertAction(title: "Save", style: .default) { [unowned self] _ in
                self.performSegue(withIdentifier: "FileSegue", sender: nil)
            })
        }
        alert.addAction(UIAlertAction(title: "Print", style: .default) { [unowned self] _ in
            self.printHardCopy()
            //			self.activity()
        })
        
        alert.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(alert, animated: true, completion: nil)
    }
    
    func activity(){
        let vc = UIActivityViewController(activityItems: [documentData], applicationActivities: [])
        present(vc, animated: true)	}
    
    func printHardCopy(){
        let jobName = (tabBarController as! TabBarController).learnerName ?? job.rawValue
        DispatchQueue.main.async {
            let printController = UIPrintInteractionController.shared
            printController.showsNumberOfCopies = false
            printController.delegate = self
            printController.showsPaperSelectionForLoadedPapers = false
            
            
            let printInfo = UIPrintInfo(dictionary : nil)
            //		printInfo.duplex = .longEdge
            printInfo.orientation = .portrait
            printInfo.outputType = .general
            printInfo.jobName = jobName
            
            
            printController.printInfo = printInfo
            printController.printingItem = self.documentData
            printController.present(animated : true)
        }
    }
    
    
    func pdfOnScreen(pdf card: Card){
        guard let path = Bundle.main.url(forResource: card.name, withExtension: "pdf") else {
            return
        }
        if let document = PDFDocument(url: path) {
            pdfView.document = document
            pdfDocument = document
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "FileSegue"{
            let name = (tabBarController as! TabBarController).learnerName ?? ""
            (segue.destination as! SaveFileViewController).fileText = name+" "+job.rawValue+additionalInfoForFileName
            (segue.destination as! SaveFileViewController).nsData = nsData
        }
    }
}

extension PDFViewController{
    enum Jobs: String {
        case WorkSheet = "Worksheet"
        case InfoSheet = "Information Pack"
        case Handbook = "Handbook"
        case Logbook = "Log Book"
        case DoubleLong = "Collector"
        case FocusSheet = "Focus Sheet"
    }
}


extension UIAlertController {
    override open func viewDidLoad() {
        super.viewDidLoad()
        pruneNegativeWidthConstraints()
    }
    
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}


class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        view.addSubview(spinner)
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
