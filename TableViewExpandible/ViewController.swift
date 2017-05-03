//
//  ViewController.swift
//  TableViewExpandible
//
//  Created by Irvin Geovani Chan Canché on 02/05/17.
//  Copyright © 2017 iccanche. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.register(HeaderTableViewCell.self, forCellReuseIdentifier: HeaderTableViewCell.reuseIdentifier)
        }
    }
    @IBOutlet weak var verticalSpacingConstraint: NSLayoutConstraint!
    
    var items:Array<String>!
    var verticalSpacing:Int!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = []
        
        for index in 1...20 {
            let item = "Item en la posicion número: \(index)"
            items.append(item)
        }
        
        setupView()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.isScrollEnabled = false
        
        navigationItem.title = "Awesome App"
        
        
        verticalSpacing = 350
        
        verticalSpacingConstraint.constant = CGFloat(verticalSpacing!)

    }
    
    func animateWithDuration(duration:CGFloat, valueConstraint:Int) ->Void {
        self.verticalSpacingConstraint.constant = CGFloat(valueConstraint)
        tableView.setNeedsUpdateConstraints()
        
        UIView.animate(withDuration: TimeInterval(duration), animations: {()-> Void in
            self.tableView.layoutIfNeeded()
        })
        
        self.tableView.setContentOffset(CGPoint(x:0,y:0), animated: true)
        
    }


}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell", for:indexPath)
        cell.textLabel?.text = items[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView:HeaderTableViewCell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.reuseIdentifier) as! HeaderTableViewCell
        headerView.textLabel?.text = "Toca para expandir"
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 52
    }
    
    
    
}

extension ViewController: HeaderTableViewDelegate {
    func headerIsUp(headerCell: HeaderTableViewCell, isUp: Bool) {
        var value:Int = 0
        
        if (isUp) {
            value = verticalSpacing
            tableView.isScrollEnabled = false
            headerCell.textLabel?.text = "Toca para expandir"
        } else {
            value = 0
            tableView.isScrollEnabled = true
            headerCell.textLabel?.text = "Toca para minimizar"
        }
        
        animateWithDuration(duration: 0.25, valueConstraint: value)
        
    }
}

