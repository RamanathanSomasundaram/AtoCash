//
//  TabCollectionCell.swift
//  TabPageViewController
//
//  Created by EndouMari on 2016/02/24.
//  Copyright © 2016年 EndouMari. All rights reserved.
//

import UIKit

class TabCollectionCell: UICollectionViewCell {

    var tabItemButtonPressedBlock: (() -> Void)?
    var option: TabPageOption = TabPageOption() {
        didSet {
            currentBarViewHeightConstraint.constant = option.currentBarHeight
        }
    }
    var item: String = "" {
        didSet {
            let arr = item.components(separatedBy: "~")
            itemLabel.text = arr[0]
           // countLabel.invalidateIntrinsicContentSize()
           // itemLabel.text = arr[1]
            //itemLabel.invalidateIntrinsicContentSize()
            invalidateIntrinsicContentSize()
        }
    }
    var isCurrent: Bool = false {
        didSet {
            currentBarView.isHidden = !isCurrent
            if isCurrent {
                highlightTitle()
            } else {
                unHighlightTitle()
            }
            currentBarView.backgroundColor = option.currentColor
            layoutIfNeeded()
        }
    }

   // @IBOutlet fileprivate weak var countLabel: UILabel!
    @IBOutlet fileprivate weak var itemLabel: UILabel!
    @IBOutlet fileprivate weak var currentBarView: UIView!
    @IBOutlet fileprivate weak var currentBarViewHeightConstraint: NSLayoutConstraint!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        itemLabel.clipsToBounds = true

        currentBarView.isHidden = true
    }

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        if item.count == 0 {
            return CGSize.zero
        }

        return intrinsicContentSize
    }

    class func cellIdentifier() -> String {
        return "TabCollectionCell"
    }
}


// MARK: - View

extension TabCollectionCell {
    override var intrinsicContentSize : CGSize {
        var width: CGFloat
        if let tabWidth = option.tabWidth , tabWidth > 0.0 {
            width = tabWidth
        } else {
            width = itemLabel.intrinsicContentSize.width + option.tabMargin * 2
        }
        width = (width > 100) ? width : 100
        
        let size = CGSize(width: width, height: option.tabHeight)
        return size
    }

    func hideCurrentBarView() {
        currentBarView.isHidden = true
    }

    func showCurrentBarView() {
        currentBarView.isHidden = false
    }

    func highlightTitle() {
        hideCurrentBarView()
        itemLabel.layer.cornerRadius = 4.0
        itemLabel.textColor = option.currentTextColor
        itemLabel.backgroundColor = option.currentColor
       // itemLabel.font = UIFont.boldSystemFont(ofSize: option.fontSize)
    }

    func unHighlightTitle() {
        hideCurrentBarView()
        itemLabel.backgroundColor = UIColor.clear
        itemLabel.textColor = option.defaultColor
        //itemLabel.font = UIFont.systemFont(ofSize: option.fontSize)
    }
}


// MARK: - IBAction

extension TabCollectionCell {
    @IBAction fileprivate func tabItemTouchUpInside(_ button: UIButton) {
        tabItemButtonPressedBlock?()
    }
}
