//
//  ViewController.swift
//  unitTestingDemo
//
//  Created by M_AMBIN05643 on 13/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableViewObj: UITableView!
    
    var viewModel: MovieViewModel?
    
    //MARK: - View life cycle starts from here
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = MovieViewModel(manager: ServiceManager())
        
        loadData()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - getting data from viewModel
    func loadData() {
        viewModel?.getAPIResponseData() {
            DispatchQueue.main.async {[weak self] in
                self?.tableViewObj.reloadData()
            }
        }
    }
    //MARK: - View life cycle ends here
}

//MARK: - tableview datasource delegate functions handling here
extension ViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfRows() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        if let res = viewModel?.cellForRow(at: indexPath.row) {
            cell.titlelabelObj.text = res.artistName ?? ""
            cell.descriptionLabelObj.text = res.name
        }
        cell.button.tag = indexPath.row
        cell.delegate = self
        return cell
    }
}

//MARK: - cellTappedDelegate function handling
extension ViewController: cellTappedDelegate {
    func cellIsTapped(at row: Int) {
        print(row)
       let res = viewModel?.getPlatform(index: 0, count: 20)
        print(res)
    }
    
    
}
