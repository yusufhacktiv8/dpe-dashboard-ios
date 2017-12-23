//
//  ViewController.swift
//  DPE Dashboard
//
//  Created by Muhammad Yusuf on 12/23/17.
//  Copyright © 2017 Department Power Plant & Energy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://s3-ap-southeast-1.amazonaws.com/dpe-dashboard-files/images/bali.jpg") {
            imageView.contentMode = .scaleAspectFit
            downloadImage(url: url)
        }
    }
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.imageView.image = UIImage(data: data)
            }
        }
    }

    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }


}

