//
//  ViewController.swift
//  WeatherMars
//
//  Created by Matteo Fusilli on 30/05/2020.
//  Copyright © 2020 Matteo Fusilli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Global Variables
    @IBOutlet weak var currentView: UIImageView!
    
    let url = URL(string:"https://api.nasa.gov/insight_weather/?api_key=DEMO_KEY&feedtype=json&ver=1.0")

    // MARK: - Lyfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Gradient color to current card and rounded corners
        currentView.setGradientBackground(colorTop: ColorGradients.salmonOrange, colorBottom: ColorGradients.salmonPink)
        currentView.layer.cornerRadius = 10;
        currentView.clipsToBounds = true;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchMarsWeather(url: url!)
    }
    
    //MARK: - Fetch Mars Weather Method
    func fetchMarsWeather(url: URL) {
        let task = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error in
            guard error == nil else {return}
            guard let data = data else {return}
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print("NASA API Response: ")
                    print(json)
                }
            } catch let error {
                print(error.localizedDescription)
            }
        })
        
        task.resume()
    }

}

extension UIImageView {
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]

        layer.insertSublayer(gradientLayer, at: 0)
    }
}

