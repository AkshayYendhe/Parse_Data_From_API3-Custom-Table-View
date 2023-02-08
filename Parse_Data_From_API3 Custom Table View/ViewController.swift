//
//  ViewController.swift
//  Parse_Data_From_API3 Custom Table View
//
//  Created by Akshay Yendhe on 05/02/23.
//

import UIKit

class ViewController: UIViewController {

    
    var countryData = [CapitalNames]()
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        
        guard let url = URL(string: "http://haritibhakti.com/capitalname.json")
                else
        {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response,error) in
            
            guard let data = data , error == nil else{
                print("Error Occured While Accessing Data")
                return
            }
            var cList = [CapitalNames]()
            do
            {
                cList = try JSONDecoder().decode([CapitalNames].self, from: data)
            }
            catch
            {
                print("Error While Decoding JSON in to Swift Structure \(error)")
            }
                self.countryData = cList
            DispatchQueue.main.async {
                self.myTableView.reloadData()
            }
        })
        task.resume()
    }
}

extension UIImageView
{
    func downloadImage(from url : URL){
        contentMode = .scaleToFill
        let dataTask = URLSession.shared.dataTask(with: url, completionHandler: {
            (data,response,error) in
            
            guard let httpURLres = response as? HTTPURLResponse, httpURLres.statusCode == 200,
                  let imageType = response?.mimeType, imageType.hasPrefix("image"),
                  let data = data , error == nil,
                  let image = UIImage(data: data)
            else{
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
            
        })
        dataTask.resume()
    }
}

extension ViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.countrynameLabel.text = countryData[indexPath.row].countryname
        cell.capitalnameLabel.text = countryData[indexPath.row].capitalname
        let urlImage = URL(string: "http://haritibhakti.com\(countryData[indexPath.row].flagimage)")
        cell.myImage.downloadImage(from: urlImage!)
        cell.myImage.layer.cornerRadius = 25
        return cell
    }
    
    
}
