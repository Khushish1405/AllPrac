//
//  ViewController.swift
//  AllPrac
//
//  Created by Jaimin Solanki on 25/08/23.
//

import UIKit
import Alamofire

var data = [
    MovieData(sectionType: "Movies", Movies: ["adipursh","Avatar","Dream","Strike","Roadtrip"]),
    MovieData(sectionType: "Movies1", Movies: ["Hero","Hobbit","Jhon","Joker","KGF"]),
    MovieData(sectionType: "Movies2", Movies: ["Master","Pathan","Pushpa","Ramsetu","Roadtrip"]),
    MovieData(sectionType: "Movies3", Movies: ["adipursh","Avatar","boy","Dream","girl","Strike"]),
    MovieData(sectionType: "Movies4", Movies: ["Hero","Hobbit","Jhon","Joker","KGF"]),
    MovieData(sectionType: "Movies5", Movies: ["Master","Pathan","Pushpa","Ramsetu","Roadtrip"])
]

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchData()
        performRequest()
        
        tableView.sectionHeaderTopPadding = 0
    }
    
    //MARK: - Almofire Fetch Request and Get Decoded JSON Data...
    var apiResult: CricData?
    
    func fetchData() {
        
        let requestDataURL = Bundle.main.url(forResource: "ApiData", withExtension: "geojson")
        //        let requestDataURL = "https://api.cricapi.com/v1/cricScore?apikey=43081de8-17ec-4137-b0dd-38e6d0b110c1"
        
        AF.request(requestDataURL!, method: .get, parameters: nil, encoding: URLEncoding.default).response { response in
            
            switch response.result {
                
            case .success(let data):
                
                do {
                    let jsonData = try JSONDecoder().decode(CricData.self, from: data!)
                    
                    print("data mali gyooo")
                    self.apiResult = jsonData
                    print(self.apiResult ?? "")
                    
                } catch {
                    print("Error..\(error.localizedDescription)")
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                
            }
        }
    }
    
    //MARK: - Urlsession Fetch Request and Get Decoded JSON Data...
    
    func performRequest() {
        
        let url = URL(string: "https://api.cricapi.com/v1/cricScore?apikey=43081de8-17ec-4137-b0dd-38e6d0b110c1")!
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { data, response, error in
            do {
                if let safeData = data {
                    if let jsonData = self.parseJSON(with: safeData) {
                        self.apiResult = jsonData
                        print("khushishhhhhh")
                        print(self.apiResult)
                        return
                    }
                }
            }
            catch {
                print("Error..\(error.localizedDescription)")
            }
        }
        task.resume()
        
    }
    
    func parseJSON(with cricData: Data) -> CricData? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CricData.self, from: cricData)
            
            let data = decodedData.data
            return decodedData
            
        } catch {
            print(error)
            return nil
        }
    }
    
    
}


extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return data[section].sectionType
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return data[section].sectionType
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        cell.collectionView.tag = indexPath.section
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = .green
    }
    
    func tableView(_ tableView: UITableView, willDisplayFooterView view: UIView, forSection section: Int) {
        view.tintColor = .orange
    }
    
}
