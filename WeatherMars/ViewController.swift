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
        cards = createCards()
        setupCardScrollView(cards: cards)
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
    
    // MARK: - Setup the scrollView methods
    func createCards() -> [UIImageView] {
        var card1 : UIImageView
        card1 = UIImageView(frame:CGRect(x: 0, y: 0, width: 350, height: 350));
        card1.setGradientBackground(colorTop: ColorGradients.paleGreen, colorBottom: ColorGradients.salmonPink)
        card1.layer.cornerRadius = 10;
        card1.clipsToBounds = true;
        
        var card2 : UIImageView
        card2 = UIImageView(frame:CGRect(x: 0, y: 0, width: 350, height: 350));
        card2.setGradientBackground(colorTop: ColorGradients.paleBlue, colorBottom: ColorGradients.paleGreen)
        card2.layer.cornerRadius = 10;
        card2.clipsToBounds = true;
        
        var card3 : UIImageView
        card3 = UIImageView(frame:CGRect(x: 0, y: 0, width: 350, height: 350));
        card3.setGradientBackground(colorTop: ColorGradients.purple, colorBottom: ColorGradients.paleBlue)
        card3.layer.cornerRadius = 10;
        card3.clipsToBounds = true;
        
        return [card1, card2, card3]
    }
    
    func setupCardScrollView(cards: [UIImageView]) {
        scrollView.frame = CGRect(x: 0, y: 0, width: 400, height: 200)
        scrollView.contentSize = CGSize(width: 400 * CGFloat(cards.count), height: 200)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< cards.count {
            cards[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: 300, height: 300)
            scrollView.addSubview(cards[i])
        }
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

