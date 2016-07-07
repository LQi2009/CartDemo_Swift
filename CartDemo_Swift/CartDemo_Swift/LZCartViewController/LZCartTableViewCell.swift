//
//  LZCartTableViewCell.swift
//  CartDemo_Swift
//
//  Created by Artron_LQQ on 16/6/27.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

typealias callBackFunc = (number: Int) -> Void
typealias selectFunc = (select: Bool ) -> Void

class LZCartTableViewCell: UITableViewCell {

    var lzImageView: UIImageView!
    var lzNameLabel: UILabel!
    var lzDateLabel: UILabel!
    var lzNumberLabel: UILabel!
    var lzPriceLabel: UILabel!
    var lzSelectButton: UIButton!
    
    var addCallback = callBackFunc?()
    var cutCallback = callBackFunc?()
    var selectAction = selectFunc?()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.setupMainView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMainView() {
        
        // 背景view
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.whiteColor()
        backgroundView.layer.borderColor = LZColorTool.colorFromHex(0xeeeeee).CGColor
        backgroundView.layer.borderWidth = 1
        self.addSubview(backgroundView)
        
        backgroundView.snp_makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self)
        }
        
        let selectButton = UIButton(type: .Custom)
        selectButton.setImage(UIImage(named: "cart_selected_btn"), forState: UIControlState.Selected)
        selectButton.setImage(UIImage(named: "cart_unSelect_btn"), forState: UIControlState.Normal)
        selectButton.addTarget(self, action: #selector(selectButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        backgroundView.addSubview(selectButton)
        lzSelectButton = selectButton
        
        selectButton.snp_makeConstraints { (make) in
            make.left.equalTo(backgroundView).offset(10)
            make.centerY.equalTo(backgroundView)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        //头像背景view
        let headerBg = UIView()
        headerBg.backgroundColor = LZColorTool.colorFromHex(0xf3f3f3)
        backgroundView.addSubview(headerBg)
        
        headerBg.snp_makeConstraints { (make) in
            
            make.left.equalTo(selectButton.snp_right).offset(10)
            make.top.equalTo(backgroundView).offset(5)
            make.bottom.equalTo(backgroundView).offset(-5)
            make.width.equalTo(headerBg.snp_height)
        }
        
        //头像
        let header = UIImageView(image: UIImage(named: "40fe711f9b754b596159f3a6.jpg"))
        header.contentMode = UIViewContentMode.ScaleAspectFit
        backgroundView.addSubview(header)
        lzImageView = header
        
        header.snp_makeConstraints { (make) in
            make.edges.equalTo(headerBg).offset(UIEdgeInsetsMake(10, 10, -10, -10))
        }
        
        //名称
        let title = UILabel()
        title.font = UIFont.systemFontOfSize(16)
        backgroundView.addSubview(title)
        lzNameLabel = title
        
        //价格
        let price = UILabel()
        price.font = UIFont.systemFontOfSize(16)
        price.textColor = LZColorTool.redColor()
        price.textAlignment = NSTextAlignment.Right
        backgroundView.addSubview(price)
        lzPriceLabel = price
        
        title.snp_makeConstraints { (make) in
            make.left.equalTo(headerBg.snp_right).offset(10)
            make.top.equalTo(header)
            make.height.equalTo(30)
            make.width.equalTo(price)
        }
        
        price.snp_makeConstraints { (make) in
            make.left.equalTo(title).offset(10)
            make.right.equalTo(backgroundView).offset(-10)
            make.top.equalTo(title)
            make.height.equalTo(title)
            make.width.equalTo(title)
        }
        
        // 时间
        let date = UILabel()
        date.font = UIFont.systemFontOfSize(10)
        date.textColor = LZColorTool.colorFromRGB(132, G: 132, B: 132)
        backgroundView.addSubview(date)
        lzDateLabel = date
        
        date.snp_makeConstraints { (make) in
            make.left.equalTo(headerBg.snp_right).offset(10)
            make.bottom.equalTo(header)
            make.right.equalTo(title)
            make.height.equalTo(20)
        }
        
        let addButton = UIButton(type: .Custom)
        addButton.setImage(UIImage(named: "cart_addBtn_nomal"), forState: .Normal)
        addButton.setImage(UIImage(named: "cart_addBtn_highlight"), forState: .Highlighted)
        addButton.addTarget(self, action: #selector(addButtonClick), forControlEvents: .TouchUpInside)
        backgroundView.addSubview(addButton)
        
        let numberLabel = UILabel()
        numberLabel.textAlignment = .Center
        numberLabel.font = UIFont.systemFontOfSize(16)
        numberLabel.text = "1"
        backgroundView.addSubview(numberLabel)
        lzNumberLabel = numberLabel
        
        let cutButton = UIButton(type: .Custom)
        cutButton.setImage(UIImage(named: "cart_cutBtn_highlight"), forState: .Highlighted)
        cutButton.setImage(UIImage(named: "cart_cutBtn_nomal"), forState: .Normal)
        cutButton.addTarget(self, action: #selector(cutButtonClick), forControlEvents: .TouchUpInside)
        backgroundView.addSubview(cutButton)
        
        addButton.snp_makeConstraints { (make) in
            make.right.equalTo(backgroundView).offset(-10)
            make.bottom.equalTo(backgroundView).offset(-10)
            make.height.equalTo(26)
            make.width.equalTo(30)
        }
        
        numberLabel.snp_makeConstraints { (make) in
            make.right.equalTo(addButton.snp_left)
            make.bottom.equalTo(addButton)
            make.height.width.equalTo(addButton)
        }
        
        cutButton.snp_makeConstraints { (make) in
            make.right.equalTo(numberLabel.snp_left)
            make.bottom.equalTo(addButton)
            make.height.width.equalTo(addButton)
        }
    }
    
    func selectButtonClick(button: UIButton) {
        
        button.selected = !button.selected
        
        if selectAction != nil {
            selectAction!(select: button.selected)
        }
    }
    
    func addButtonClick(button: UIButton) {
        
//        if addCallback != nil {
//            self.addCallback
//        }
        
//        var count = Int(self.lzNumberLabel.text!)
//        count! += 1
//        self.lzNumberLabel.text = "\(count!)"
//        
//        addCallback!()
        
        if var count = Int(self.lzNumberLabel.text!) {
            
            count += 1
            
            let num = count<=0 ? 1 : count
            
            self.lzNumberLabel.text = "\(num)"
            
            if addCallback != nil {
                
                addCallback!(number: num)
            }
        }
    }
    
    func cutButtonClick(button: UIButton) {
        
//        var count = Int(self.lzNumberLabel.text!)!
//        
//        
//        count -= 1
//        
//        let num = count<=0 ? 1 : count
//        
//        self.lzNumberLabel.text = "\(num)"
//        
//        if cutCallback != nil {
//            
//            cutCallback!()
//        }
        if var count = Int(self.lzNumberLabel.text!) {
            
            count -= 1
            
            let num = count<=0 ? 1 : count
            
            self.lzNumberLabel.text = "\(num)"
            
            if cutCallback != nil {
                
                cutCallback!(number: num)
            }
        }
    }
    
    func selectAction(fun: (select: Bool)-> ()) {
        selectAction = fun
    }
    
    func addNumber (fun: ( num: Int)->()) {
        addCallback = fun
    }
    
    func cutNumber (fun: ( num : Int)->()) {
        cutCallback = fun
    }
    
    func configCellDateWithModel(model: LZCartModel) {
        
        lzImageView.image = model.image
        lzNumberLabel.text = "\(model.number)"
        lzNameLabel.text = model.name
        lzDateLabel.text = model.date
        lzPriceLabel.text = model.price
        if let sel = model.select {
            lzSelectButton.selected = sel
        } else {
            lzSelectButton.selected = false
        }
        
        
    }
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
