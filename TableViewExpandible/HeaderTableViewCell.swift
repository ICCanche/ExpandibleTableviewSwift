//
//  HeaderTableView.swift
//  TableViewExpandible
//
//  Created by Irvin Geovani Chan Canché on 02/05/17.
//  Copyright © 2017 iccanche. All rights reserved.
//

import UIKit

protocol HeaderTableViewDelegate: UIGestureRecognizerDelegate {
    func headerIsUp(headerCell:HeaderTableViewCell,isUp:Bool)->Void
}

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    var delegate:HeaderTableViewDelegate?
    var isUpTable:Bool!
    
    static var reuseIdentifier:String {
        return String(describing: self)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureView() -> Void {
        isUpTable = false
        
        
        let pinkColor = UIColor(colorLiteralRed: 233/255.0,
                                green: 30/255.0,
                                blue: 99/255.0, alpha: 1.0)
        
        self.contentView.backgroundColor = pinkColor
        textLabel?.textColor = UIColor.white
        
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAction))
        tapGestureRecognizer.cancelsTouchesInView = true
        tapGestureRecognizer.delaysTouchesBegan = true
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.delegate = self
        self.addGestureRecognizer(tapGestureRecognizer)
    
    }
    
    func handleTapAction(sender:Any)->Void {
        if (!self.isUpTable) {
            self.delegate?.headerIsUp(headerCell: self, isUp: false)
            self.isUpTable = true
        } else {
            self.delegate?.headerIsUp(headerCell: self, isUp: true)
            self.isUpTable = false
        }
    }
    
    override func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    
}
