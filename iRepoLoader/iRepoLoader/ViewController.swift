//
//  ViewController.swift
//  TableView
//
//  Created by Iván Álvarez Pereira on 2/1/15.
//  Copyright (c) 2015 Iván Álvarez. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var tableData: JSON = JSON.nullJSON
    
    @IBOutlet weak var list: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("Table data count \(tableData.count)")
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "IdCelda")
        
        cell.textLabel?.text = "# " + self.tableData[indexPath.row]["name"].string!
        cell.detailTextLabel?.text = "URL: " + self.tableData[indexPath.row]["html_url"].string!
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        var url: String = "https://api.github.com/users/programwar/repos"
        
        Alamofire.request(.GET, url, parameters: nil)
            .responseJSON { (req, res, json, error) in
                if(error != nil) {
                    NSLog("Error: \(error)")
                }
                else {
                    NSLog("Success: \(url)")
                    self.tableData = JSON(json!)
                    self.list.reloadData()
                }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
}

