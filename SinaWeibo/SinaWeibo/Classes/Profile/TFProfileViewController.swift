//
//  TFProfileViewController.swift
//  SinaWeibo
//
//  Created by 陶飞 on 2016/10/20.
//  Copyright © 2016年 TaoFei. All rights reserved.
//

import UIKit

class TFProfileViewController: TFBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        visitorView.setupVisitorViewInfo(iconName: "visitordiscover_image_profile", tip: "登录后，你的微薄、相册、个人资料会显示在这里，展示给别人")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }


}
