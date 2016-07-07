//
//  LZCartViewController.swift
//  CartDemo_Swift
//
//  Created by Artron_LQQ on 16/6/27.
//  Copyright © 2016年 Artup. All rights reserved.
//

import UIKit
//import 


class LZCartViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var dataArray: [LZCartModel] = []
    var selectArray: [LZCartModel] = []
    
    var tableView: UITableView? = nil
    var priceLabel: UILabel?
    var allSelectButton: UIButton?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.setupNavBar()
        self.setupBottomView()
        self.createData()
        
//        self.emptyView()
        self.setupTableView()
    }

    /*创建假数据*/
    func createData() {
        for i in 0...10 {
            
            let model = LZCartModel()
            model.name = "测试\(i)"
            model.price = "100.00"
            model.number = 2
            model.date = "2016.06.28"
            model.image = UIImage(named: "40fe711f9b754b596159f3a6.jpg")
            dataArray.append(model)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*创建表视图*/
    func setupTableView() {
        
        tableView = UITableView(frame: CGRectZero,style: UITableViewStyle.Plain)
        tableView?.delegate = self
        tableView?.dataSource = self
        tableView?.backgroundColor = LZColorTool.colorFromRGB(235, G: 246, B: 248)
        tableView?.separatorStyle = UITableViewCellSeparatorStyle.None
        tableView?.rowHeight = KLZTableViewCellHeight;
        self.view.addSubview(tableView!)
        
        tableView?.snp_makeConstraints(closure: { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(self.view).offset(kLZNavigationBarHeight)
            make.bottom.equalTo(self.view).offset(-kLZTabbarHeight)
        })
    }
    /*计算总金额*/
    func priceCount() {
        var price: Double = 0.0
        
        for model in self.selectArray {
            
            let pri = Double(model.price!)
            
            price += pri! * Double(model.number)
        }
        
        self.priceLabel?.attributedText = self.priceString("\(price)")
    }
    
    /*tableView 代理方法 */
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: LZCartTableViewCell? = tableView.dequeueReusableCellWithIdentifier("cartCellID") as? LZCartTableViewCell
        if cell == nil {
            cell = LZCartTableViewCell(style: UITableViewCellStyle.Default,reuseIdentifier: "cartCellID")
        }
        
        
        let model = dataArray[indexPath.row]
        
        cell?.configCellDateWithModel(model)
        
        /*点击cell数量加按钮回调*/
        cell?.addNumber({number in
            
            model.number = number
            
            print("aaa\(number)")
        })
        
        /*点击cell数量减按钮回调*/
        cell?.cutNumber({number in
            
            model.number = number
            print("bbbbb\(number)")
        })
        
        /*选择cell商品回调*/
        cell?.selectAction({select in
        
            model.select = select
            
            if select {
                self.selectArray.append(model)
            } else {
                
                let index = self.selectArray.indexOf(model)
                self.selectArray.removeAtIndex(index!)
            }
            
            if self.selectArray.count == self.dataArray.count {
                
                self.allSelectButton?.selected = true
            } else {
                self.allSelectButton?.selected = false
            }
            
            self.priceCount()
            
            print("select\(select)")
        })
        
        return cell!
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let alert = UIAlertController(title: "提示",message: "删除后无法恢复,是否继续删除?",preferredStyle: UIAlertControllerStyle.Alert)
        
        let ok = UIAlertAction(title: "确定",style: UIAlertActionStyle.Default,handler:{okAction in
            
            let model = self.dataArray.removeAtIndex(indexPath.row)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            
            if self.selectArray.contains(model) {
                
                let index = self.selectArray.indexOf(model)
                self.selectArray.removeAtIndex(index!)
            
                self.priceCount()
            }
            
            if self.selectArray.count == self.dataArray.count {
                
                self.allSelectButton?.selected = true
            } else {
                self.allSelectButton?.selected = false
            }
            
            if self.dataArray.count == 0 {
                
                self.emptyView()
            }
        })
        
        let cancel = UIAlertAction(title: "取消",style: UIAlertActionStyle.Cancel,handler: {cancelAction in
            
            
        })
        
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.presentViewController(alert, animated: true, completion: nil)
        
        
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        
        return "删除"
    }
    /*创建自定义导航*/
    func setupNavBar() {
        let backgroundView = UIView();
        
        backgroundView.frame = CGRectMake(0, 0, kLZScreenWidth, kLZNavigationBarHeight);
        
        backgroundView.backgroundColor = UIColor.cyanColor()
        self.view.addSubview(backgroundView)
        
        
        let leftButton = UIButton(type: UIButtonType.Custom)
        leftButton.frame = CGRectMake(0, 20, 60, 44);
        leftButton.setImage(UIImage(named: "back_button"), forState: UIControlState.Normal)
        leftButton.addTarget(self, action: #selector(leftButtonClick), forControlEvents: .TouchUpInside)
        backgroundView.addSubview(leftButton)
        
        let titleLabel = UILabel()
        titleLabel.center = CGPointMake(self.view.center.x, 42)
        titleLabel.bounds = CGRectMake(0, 0, 200, 44)
        titleLabel.font = UIFont.systemFontOfSize(18)
        titleLabel.textColor = UIColor.blueColor()
        titleLabel.text = "购物车";
        titleLabel.textAlignment = NSTextAlignment.Center
        backgroundView.addSubview(titleLabel)
        
        
    }

    /*创建底部视图*/
    func setupBottomView() {
        let backgroundView = UIView()
        backgroundView.backgroundColor = LZColorTool.colorFromRGB(245, G: 245, B: 245)
        self.view.addSubview(backgroundView)
        
        backgroundView.snp_makeConstraints { (make) in
            
            make.left.right.bottom.equalTo(self.view)
            make.height.equalTo(kLZTabbarHeight)
        }
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.lightGrayColor()
        backgroundView.addSubview(lineView)
        
        lineView.snp_makeConstraints { (make) in
            make.left.right.equalTo(self.view)
            make.top.equalTo(backgroundView)
            make.height.equalTo(1.0)
        }
        
        let seletAllButton = UIButton(type: .Custom)
        seletAllButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        seletAllButton.setTitle("  全选", forState: UIControlState.Normal)
        seletAllButton.setImage(UIImage(named: "cart_unSelect_btn"), forState: UIControlState.Normal)
        seletAllButton.setImage(UIImage(named: "cart_selected_btn"), forState: UIControlState.Selected)
        seletAllButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        seletAllButton.addTarget(self, action: #selector(selectAllButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        backgroundView.addSubview(seletAllButton)
        allSelectButton = seletAllButton
        
        seletAllButton.snp_makeConstraints { (make) in
            make.left.equalTo(backgroundView).offset(10)
            make.top.equalTo(backgroundView).offset(5)
            make.bottom.equalTo(backgroundView).offset(-5)
            make.width.equalTo(80)
        }
        
        
        let commitButton = UIButton(type: .Custom)
        commitButton.backgroundColor = LZColorTool.redColor()
        commitButton.setTitle("去结算", forState: UIControlState.Normal)
        commitButton.addTarget(self, action: #selector(comitButtonClick), forControlEvents: UIControlEvents.TouchUpInside)
        backgroundView.addSubview(commitButton)
        
        commitButton.snp_makeConstraints { (make) in
            make.top.equalTo(backgroundView)
            make.right.equalTo(backgroundView)
            make.bottom.equalTo(backgroundView)
            make.width.equalTo(100)
        }
        
        let priceLabel = UILabel()
        priceLabel.font = UIFont.systemFontOfSize(18)
        priceLabel.textColor = UIColor.redColor()
        backgroundView.addSubview(priceLabel)
        self.priceLabel = priceLabel;
        
        priceLabel.attributedText = self.priceString("100")
        priceLabel.snp_makeConstraints { (make) in
        
            make.left.equalTo(seletAllButton.snp_right).offset(10)
            make.right.equalTo(commitButton.snp_left).offset(-10)
            make.top.bottom.equalTo(backgroundView)
        }
        
    }
    
    /*富文本字符串*/
    func priceString(price: String) -> NSMutableAttributedString {
        
        let text = "合计:¥" + price
        let attributedString = NSMutableAttributedString.init(string: text)
        
        let rang = (text as NSString).rangeOfString("合计:")
        
        attributedString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blackColor(), range: rang)
        attributedString.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(16), range: rang)
        
        return attributedString
    }
    
    /*返回按钮点击事件*/
    func leftButtonClick() {
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    /*全选按钮点击事件*/
    func selectAllButtonClick(button: UIButton) {
        
        button.selected = !button.selected
        
        for model in self.selectArray {
            model.select = false
        }
        
        self.selectArray.removeAll()
        
        if button.selected {
            for model in self.dataArray {
                model.select = true
                
                self.selectArray.append(model)
            }
        }
        
        self.tableView?.reloadData()
        self.priceCount()
    }
    /*提交按钮点击事件*/
    func comitButtonClick() {
        
        for model in self.selectArray {
            
            print("选择的商品:\(model)")
        }
    }
    /*购物车为空时的视图*/
    func emptyView() {
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(backgroundView)
        
        backgroundView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        let imageView = UIImageView(image: UIImage(named: "cart_default_bg"))
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        backgroundView.addSubview(imageView)
        
        imageView.snp_makeConstraints { (make) in
            make.width.equalTo(247.0/187 * 100)
            make.height.equalTo(100)
            make.centerX.equalTo(backgroundView)
            make.centerY.equalTo(backgroundView.snp_centerY).offset(-100)
        }
        
        let label = UILabel()
        label.textAlignment = NSTextAlignment.Center
        label.text = "购物车为空"
        label.font = UIFont.systemFontOfSize(16)
        label.textColor = LZColorTool.colorFromHex(0x706f6f)
        backgroundView.addSubview(label)
        
        label.snp_makeConstraints { (make) in
            make.left.right.equalTo(backgroundView)
            make.height.equalTo(40)
            make.top.equalTo(imageView.snp_bottom).offset(50)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
