//
//  CatalogTableViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/9/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit

class CatalogTableViewController: UITableViewController {

    var catalogService : CatalogService?
    var catalogs = [Catalog]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catalogService = AppContext.sdk?.getCatalogService()
        
        loadCatalogs()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "addAction:")
     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadCatalogs() {
        catalogService?.list({ (catalogs) -> Void in
            
            //query each catalog detail
            var doneQuery = 0
            {
                didSet {
                    if doneQuery == catalogs.count {
                        
                        //refresh ui
                        AppUtil.onTimeout(1, closure: {
                            self.catalogs = catalogs
                            
                            self.tableView.reloadData()
                            
                        })
                    }
                }
            }
            
            for eachCatalog in catalogs {
                self.catalogService?.get({ (catalog : Catalog) -> Void in
                    
                    eachCatalog.videoNumber = catalog.videoNumber
                    doneQuery++
                    
                }, onFail: { (code, msg) -> Void in
                    
                    AppUtil.onFail(code, msg: msg)
                    doneQuery++
                    
                }, id: eachCatalog.id)
            }
        }, onFail: AppUtil.onFail)
    }
    
    func addAction(barButtonItem : UIBarButtonItem) {
        
        
        let alert = UIAlertController(title: "添加目录", message: "", preferredStyle: .Alert)
        alert.addTextFieldWithConfigurationHandler { (textField : UITextField!) -> Void in
            textField.placeholder = "目录名称"
        }

        let okAction = UIAlertAction(title: "添加", style: UIAlertActionStyle.Default) {(action : UIAlertAction!) -> Void in
            println(action)
            var catalogName = (alert.textFields?.first! as! UITextField).text
            
            println("try to add new catalog name is \(catalogName)")
            
            self.catalogService?.create({ (catalog) -> Void in
                
                self.catalogs.insert(catalog, atIndex: 0)
                
                let indexPath = NSIndexPath(forRow: 0, inSection: 0)
                self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                
            }, onFail: AppUtil.onFail, name: catalogName)
        }
    
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Destructive, handler: nil)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
 
        presentViewController(alert, animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return catalogs.count
    }

  
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let indentifier = "catalogCellIdentifier"
        
        println(" index is \(indexPath)")
        let cell = tableView.dequeueReusableCellWithIdentifier(indentifier, forIndexPath: indexPath) as! CatalogTableViewCell

        let catalog = catalogs[indexPath.row]
        cell.catalog = catalog
 
        return cell
    }


    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let catalog = catalogs[indexPath.row]
        println("edit catalog \(catalog.id)")
        
        func runOnDeleteSucess(catalog: Catalog) {
           
                println("delete catalog success")
                self.catalogs.removeAtIndex(indexPath.row)
                self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
           
        }
        
        if editingStyle == .Delete {
            catalogService?.delete(runOnDeleteSucess, onFail: AppUtil.onFail, id: catalog.id)
            


            // Delete the row from the data source
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
            
            println("aaaa")
        }    
    }

    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        println(segue.identifier)
        if "showVideoDetailIdentifier" == segue.identifier {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let catalog = catalogs[indexPath.row]
                
                
                ((segue.destinationViewController as! UINavigationController).topViewController as! VideoTableViewController).catalog = catalog
            }
        }
    }
}