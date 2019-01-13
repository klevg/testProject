//
//  MainViewController.swift
//  TestProject
//
//  Created by Евгений Клебан on 1/13/19.
//  Copyright © 2019 Евгений Клебан. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    private var items: [Item]?
    private var currentCellURL: String?
    private var alert: UIAlertController!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }
    
    private func fetchData() {
        let feedParser = FeedParser()
        feedParser.parseFeed(url: "https://www.wired.com/feed/rss") { (items) in
            self.items = items
    
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBAction func refreshFeed(_ sender: UIBarButtonItem) {
        fetchData()
        alert = UIAlertController(title: "Feed updated",
                                  message: "Your feed is up to date",
                                  preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    // Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Description" {
            let webViewController = segue.destination as! WebViewController
            if let url = currentCellURL {
                webViewController.link = url
            }
        }
    }
}

extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let items = items else { return 0 }
        
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Cell
        if let item = items?[indexPath.item] {
            cell.item = item
            cell.selectionStyle = .none
        }
        
        return cell
    }
    
  
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let item = items?[indexPath.row]
        currentCellURL = item?.link
                
        performSegue(withIdentifier: "Description", sender: self)
    }
    
}
