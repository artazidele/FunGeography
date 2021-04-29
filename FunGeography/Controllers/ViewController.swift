//
//  ViewController.swift
//  FunGeography
//
//  Created by arta.zidele on 17/04/2021.
//


import UIKit
import Foundation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var time: UILabel!
    let coreData = CoreDataModel()
    let cardGame = MatchFlagsAndCountriesGame()
    var timer: Timer?
    var firstIsTapped = false
    var miliseconds: Float = 80000
    var region = ""
    var cardArray = [Card]()
    var usernameString = String()
    var firstFlippedCardIndex: IndexPath?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func endGame(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    var someCountryList: [Card] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        getCardData()
        collectionView.delegate = self
        collectionView.dataSource = self
        time.text = "Time: 80.00"
     }
    @objc func timerEnd() {
        miliseconds -= 1
        let seconds = String(format: "%.2f", miliseconds/1000)
        time.text = "Time: \(seconds)"
        if miliseconds <= 10000 {
            time.textColor = UIColor.red
        }
        if miliseconds <= 0 {
            timer?.invalidate()
            checkGameEnded()
        }
    }
    func getCardData(){
        var countryList: [Country] = []
        let url = URL(string: "http://countryapi.gear.host/v1/Country/getCountries")!
        NetworkController.performRequest(for: url, httpMethod: .get) {(data, err) in
            if let error = err {
                print("Getting err from url \(url.absoluteString), error: \(error.localizedDescription)")
            }
            if let data = data {
                
                do {
                    let game = try JSONDecoder().decode(Game.self, from: data)
                    countryList = game.response
                    var regionCountries: [Country] = []
                    if self.region == "All" {
                        regionCountries = countryList
                    } else {
                        for i in 0..<countryList.count {
                            if countryList[i].region == self.region {
                                regionCountries.append(countryList[i])
                            }
                        }
                    }
                    var generatedNumbersArray = [Int]()
                 //   while generatedNumbersArray.count < 9 {
                /*    var index = 1
                    while index < 10 {
                        let randomNumber = arc4random_uniform(UInt32(regionCountries.count))
                        if generatedNumbersArray.contains(Int(randomNumber)) == false {
                            generatedNumbersArray.append(Int(randomNumber))
                            let oneCard = Card()
                            oneCard.imageName = "\(regionCountries[Int(randomNumber)].imageUrl ?? "")"
                            oneCard.country = "\(regionCountries[Int(randomNumber)].name)"
                            self.someCountryList.append(oneCard)
                            let twoCard = Card()
                            twoCard.text = 1
                            twoCard.imageName = "\(regionCountries[Int(randomNumber)].imageUrl ?? "")"
                            twoCard.country = "\(regionCountries[Int(randomNumber)].name)"
                            self.someCountryList.append(twoCard)
                        }
                        index += 1
                    }*/
                    while generatedNumbersArray.count < 9 {
                        let randomNumber = arc4random_uniform(UInt32(regionCountries.count))
                        if generatedNumbersArray.contains(Int(randomNumber)) == false {
                            generatedNumbersArray.append(Int(randomNumber))
                            let oneCard = Card()
                            oneCard.imageName = "\(regionCountries[Int(randomNumber)].imageUrl ?? "")"
                            oneCard.country = "\(regionCountries[Int(randomNumber)].name)"
                            self.someCountryList.append(oneCard)
                            let twoCard = Card()
                            twoCard.text = 1
                            twoCard.imageName = "\(regionCountries[Int(randomNumber)].imageUrl ?? "")"
                            twoCard.country = "\(regionCountries[Int(randomNumber)].name)"
                            self.someCountryList.append(twoCard)
                        }
                    }
                    for i in 0..<self.someCountryList.count {
                        let randomNumber = Int(arc4random_uniform(UInt32(generatedNumbersArray.count)))
                        let temporary = self.someCountryList[i]
                        self.someCountryList[i] = self.someCountryList[randomNumber]
                        self.someCountryList[randomNumber] = temporary
                    }
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                } catch {
                    print("failed to decode data \(error), data: \(data)")
                }
            } else {
                print("Data is nil")
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return someCountryList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: indexPath) as! CardCollectionViewCell
        let card = someCountryList[indexPath.row]
        cell.setCard(card)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        let card = someCountryList[indexPath.row]
        print(card.country!)
        if firstIsTapped == false {
            timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerEnd), userInfo: nil, repeats: true)
            firstIsTapped = true
        }
        if card.isMatched == true {
            return
        }else if card.isFlipped == true && card.isMatched == false {
            cell.flipBack(card)
            card.isFlipped = false
        } else {
            cell.flip(card)
            card.isFlipped = true
            if firstFlippedCardIndex == nil {
                firstFlippedCardIndex = indexPath
            } else {
                checkForMatches(indexPath)
            }
        }
    }
    func checkForMatches(_ secondFlippedCardIndex: IndexPath) {
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionViewCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionViewCell
        let cardOne = someCountryList[firstFlippedCardIndex!.row]
        let cardTwo = someCountryList[secondFlippedCardIndex.row]
        if cardOne.imageName == cardTwo.imageName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            cardOneCell?.remove()
            cardTwoCell?.remove()
            checkGameEnded()
        } else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            cardOneCell?.flipBack(cardOne)
            cardTwoCell?.flipBack(cardTwo)
        }
        if cardOneCell == nil {
            collectionView.reloadItems(at: [firstFlippedCardIndex!])
        }
        firstFlippedCardIndex = nil
    }
    func checkGameEnded() {
        let isWon = cardGame.isWon(someCountryList)
        var title = ""
        var message = ""
        if isWon == true {
            coreData.addResult(thisUser: usernameString, thisResult: Int(miliseconds)/1000)
            if miliseconds > 0 {
                timer?.invalidate()
            }
            title = "Congratulations!"
            message = "You have won"
        } else {
            if miliseconds > 0 {
                return
            }
            title = "Game over"
            message = "You have lost"
        }
        showAlert(title, message)
    }
    func showAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true) {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            guard let vc = storyboard.instantiateViewController(identifier: "RegionView") as? RegionViewController else { return }
            vc.usernameString = self.usernameString
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.navigationController?.pushViewController(vc, animated: true)
             }
        }
    }
}
