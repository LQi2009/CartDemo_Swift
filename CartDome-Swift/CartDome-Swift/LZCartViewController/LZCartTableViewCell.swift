//
//  LZCartTableViewCell.swift
//  CartDemo_Swift
//
//  Created by Artron_LQQ on 16/6/27.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit

typealias callBackFunc = (_ number: Int) -> Void
typealias selectFunc = (_ select: Bool ) -> Void

class LZCartTableViewCell: UITableViewCell {

    var lzImageView: UIImageView!
    var lzNameLabel: UILabel!
    var lzDateLabel: UILabel!
    var lzNumberLabel: UILabel!
    var lzPriceLabel: UILabel!
    var lzSelectButton: UIButton!
    
    var addCallback: callBackFunc?
    var cutCallback: callBackFunc?
    var selectAction: selectFunc?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = UITableViewCellSelectionStyle.none
        self.setupMainView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMainView() {
        
        // 背景view
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.white
        backgroundView.layer.borderColor = LZColorTool.colorFromHex(0xeeeeee).cgColor
        backgroundView.layer.borderWidth = 1
        self.addSubview(backgroundView)
        
        backgroundView.snp.makeConstraints { (make) in
            
            make.left.equalTo(self).offset(10)
            make.top.equalTo(self).offset(10)
            make.right.equalTo(self).offset(-10)
            make.bottom.equalTo(self)
        }
        
        let selectButton = UIButton(type: .custom)
        selectButton.setImage(UIImage(named: "cart_selected_btn"), for: UIControlState.selected)
        selectButton.setImage(UIImage(named: "cart_unSelect_btn"), for: UIControlState())
        selectButton.addTarget(self, action: #selector(selectButtonClick), for: UIControlEvents.touchUpInside)
        backgroundView.addSubview(selectButton)
        lzSelectButton = selectButton
        
        selectButton.snp.makeConstraints { (make) in
            
            make.left.equalTo(backgroundView).offset(10)
            make.centerY.equalTo(backgroundView)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        //头像背景view
        let headerBg = UIView()
        headerBg.backgroundColor = LZColorTool.colorFromHex(0xf3f3f3)
        backgroundView.addSubview(headerBg)
        
        headerBg.snp.makeConstraints { (make) in
            
            make.left.equalTo(selectButton.snp.right).offset(10)
            make.top.equalTo(backgroundView).offset(5)
            make.bottom.equalTo(backgroundView).offset(-5)
            make.width.equalTo(headerBg.snp.height)
        }
        
        //头像
        let header = UIImageView(image: UIImage(named: "40fe711f9b754b596159f3a6.jpg"))
        header.contentMode = UIViewContentMode.scaleAspectFit
        backgroundView.addSubview(header)
        lzImageView = header
        
        header.snp.makeConstraints { (make) in
            
            make.top.left.equalTo(headerBg).offset(10)
            make.right.bottom.equalTo(headerBg).offset(-10)
        }
        
        
        //名称
        let title = UILabel()
        title.font = UIFont.systemFont(ofSize: 16)
        backgroundView.addSubview(title)
        lzNameLabel = title
        
        //价格
        let price = UILabel()
        price.font = UIFont.systemFont(ofSize: 16)
        price.textColor = LZColorTool.redColor()
        price.textAlignment = NSTextAlignment.right
        backgroundView.addSubview(price)
        lzPriceLabel = price
        
        title.snp.makeConstraints { (make) in
            
            make.left.equalTo(headerBg.snp.right).offset(10)
            make.top.equalTo(header)
            make.height.equalTo(30)
            make.width.equalTo(price)
        }

        price.snp.makeConstraints { (make) in
            
            make.left.equalTo(title).offset(10)
            make.right.equalTo(backgroundView).offset(-10)
            make.top.equalTo(title)
            make.height.equalTo(title)
            make.width.equalTo(title)
        }
        
        // 时间
        let date = UILabel()
        date.font = UIFont.systemFont(ofSize: 10)
        date.textColor = LZColorTool.colorFromRGB(132, G: 132, B: 132)
        backgroundView.addSubview(date)
        lzDateLabel = date
        
        date.snp.makeConstraints { (make) in
            
            make.left.equalTo(headerBg.snp.right).offset(10)
            make.bottom.equalTo(header)
            make.right.equalTo(title)
            make.height.equalTo(20)
        }
        
        let addButton = UIButton(type: .custom)
        addButton.setImage(UIImage(named: "cart_addBtn_nomal"), for: UIControlState())
        addButton.setImage(UIImage(named: "cart_addBtn_highlight"), for: .highlighted)
        addButton.addTarget(self, action: #selector(addButtonClick), for: .touchUpInside)
        backgroundView.addSubview(addButton)
        
        let numberLabel = UILabel()
        numberLabel.textAlignment = .center
        numberLabel.font = UIFont.systemFont(ofSize: 16)
        numberLabel.text = "1"
        backgroundView.addSubview(numberLabel)
        lzNumberLabel = numberLabel
        
        let cutButton = UIButton(type: .custom)
        cutButton.setImage(UIImage(named: "cart_cutBtn_highlight"), for: .highlighted)
        cutButton.setImage(UIImage(named: "cart_cutBtn_nomal"), for: UIControlState())
        cutButton.addTarget(self, action: #selector(cutButtonClick), for: .touchUpInside)
        backgroundView.addSubview(cutButton)
        
        addButton.snp.makeConstraints { (make) in
            
            make.right.equalTo(backgroundView).offset(-10)
            make.bottom.equalTo(backgroundView).offset(-10)
            make.height.equalTo(26)
            make.width.equalTo(30)
        }
        
        numberLabel.snp.makeConstraints { (make) in
            
            make.right.equalTo(addButton.snp.left)
            make.bottom.equalTo(addButton)
            make.height.width.equalTo(addButton)
        }
        
        cutButton.snp.makeConstraints { (make) in
            
            make.right.equalTo(numberLabel.snp.left)
            make.bottom.equalTo(addButton)
            make.height.width.equalTo(addButton)
        }
    }
    
    func selectButtonClick(_ button: UIButton) {
        
        button.isSelected = !button.isSelected
        
        if selectAction != nil {
            selectAction!(button.isSelected)
        }
    }
    
    func addButtonClick(_ button: UIButton) {
        
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
                
                addCallback!(num)
            }
        }
    }
    
    func cutButtonClick(_ button: UIButton) {
        
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
                
                cutCallback!(num)
            }
        }
    }
    
    func selectAction(_ fun: @escaping (_ select: Bool)-> ()) {
        selectAction = fun
    }
    
    func addNumber (_ fun: @escaping ( _ num: Int)->()) {
        addCallback = fun
    }
    
    func cutNumber (_ fun: @escaping ( _ num : Int)->()) {
        cutCallback = fun
    }
    
    func configCellDateWithModel(_ model: LZCartModel) {
        
        lzImageView.image = model.image
        lzNumberLabel.text = "\(model.number)"
        lzNameLabel.text = model.name
        lzDateLabel.text = model.date
        lzPriceLabel.text = model.price
        if let sel = model.select {
            lzSelectButton.isSelected = sel
        } else {
            lzSelectButton.isSelected = false
        }
        
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
