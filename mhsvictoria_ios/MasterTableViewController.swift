//
//  MasterTableViewController.swift
//  mhsvictoria_ios
//
//  Created by Ron Allan on 2020-07-19.
//  Copyright © 2020 Ron Allan. All rights reserved.
//

import UIKit

/*
 Name of Resource
 Nobody's Perfect
 Smiling Mind
 Mindshift CBT
 Booster Buddy
 FamilySmart 1-(855) 887-8004
 HerWay Home
 YMCA Mindfulness
 YMCA Jumpstep i
 Child and Youth Mental Care
 Aboriginal Child and Youth Mental Health
 Family Development Program
 Youth Services
 Mental Health Outreach
 Rise Up Youth Employment Project
 Representative for Children and Youth in BC advocacy services.
 Hulitan Family & Community Services
 Daytime Youth drop-In
 Alliance Club
*/
class MasterTableViewController: UITableViewController {

    let fakeData = ["Nobody's Perfect", "Smiling Mind", "Mindshift CBT", "YMCA"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fakeData.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = fakeData[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        let imageView = UIImageView(frame: CGRect(x: -20, y: 0, width: tableView.frame.width + 40, height: 100))
        let brainView = UIImageView(frame: CGRect(x: 80, y: 10, width: 88, height: 80))
        brainView.image = UIImage(named: "brain_sm_rot.png")
        
        let image = UIImage(named: "mnsgv_bg_3.png")
        imageView.image = image
        view.addSubview(imageView)
        view.backgroundColor = UIColor(displayP3Red: 0x79/0xFF, green: 0xBE/0xFF, blue: 0xDD/0xFF, alpha: 1.0)
        imageView.contentMode = .scaleToFill
        imageView.addSubview(brainView)
        let editText = UITextField(frame: CGRect(x:tableView.frame.width/2, y: 60, width: tableView.frame.width/2, height: 36))
        view.addSubview(editText)
        editText.bringSubviewToFront(imageView)
        editText.placeholder = "Enter search string"
        editText.borderStyle = .line
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 100
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
