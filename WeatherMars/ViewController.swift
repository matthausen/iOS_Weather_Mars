//
//  ViewController.swift
//  WeatherMars
//
//  Created by Matteo Fusilli on 30/05/2020.
//  Copyright © 2020 Matteo Fusilli. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    //MARK: - Global Variables
    @IBOutlet weak var currentView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var cards: [UIImageView] = [];
    let url = URL(string:"https://api.nasa.gov/insight_weather/?api_key=DEMO_KEY&feedtype=json&ver=1.0")

    // MARK: - Lyfe Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Gradient color to current card and rounded corners
        currentView.setGradientBackground(colorTop: ColorGradients.salmonOrange, colorBottom: ColorGradients.salmonPink)
        currentView.layer.cornerRadius = 10;
        currentView.clipsToBounds = true;
        
        // Setup the scroll View
        scrollView.delegate = self
        // cards = createCard()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Fetch the weather
        fetchMarsWeather(url: url!)
    }
    
    //MARK: - Fetch Mars Weather Method
    func fetchMarsWeather(url: URL) {
        let task = URLSession.shared.dataTask(with: url as URL, completionHandler: {data, response, error in
            var sol_keys: [String]
            if let data =  data, error == nil {
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] else {return}
                    sol_keys = json["sol_keys"] as! [String]
                    for sol in sol_keys {
                        let card = self.createCard()
                        self.cards.append(card)
                        print(json[sol])
                    }
                    DispatchQueue.main.async {
                        // Function to update the labels with weathe info here
                        // self.setWeather()
                        self.setupCardScrollView(cards: self.cards)
                    }
                } catch {
                    print("Error fetching weather information")
                    self.fetchError()
                }
            }
        })
        
        task.resume()
    }
    
    // MARK: - Create the card
    func createCard() -> UIImageView {
        var card : UIImageView
        
        // set the cardView
        card = UIImageView(frame:CGRect(x: 0, y: 0, width: 350, height: 350));
        card.setGradientBackground(colorTop: ColorGradients.paleGreen, colorBottom: ColorGradients.salmonPink)
        card.layer.cornerRadius = 10;
        card.clipsToBounds = true;
        
        return card
    }
    
    // MARK: - Set the scrollView
    func setupCardScrollView(cards: [UIImageView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
        scrollView.contentSize = CGSize(width: 400 * CGFloat(cards.count), height: 200)
        scrollView.isPagingEnabled = true
                
        for i in 0 ..< cards.count {
            cards[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: 300, height: 300)
            
            // set day of the year
            var sol : UILabel
            sol = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
            sol.center = CGPoint(x: 160, y: 284)
            sol.textAlignment = .center
            sol.text = "Sol: 565"
            
            scrollView.addSubview(cards[i])
            // scrollView.addSubview(sol)
        }
    }
    
    // MARK: - Set error view if API fails to return data
    func fetchError() -> UIImageView {
        let errorView:UIImageView
        errorView = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        errorView.backgroundColor = .red
        return errorView
    }

}

// MARK: - Setup card gradient method
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

