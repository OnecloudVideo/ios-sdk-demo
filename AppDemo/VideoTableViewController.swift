//
//  VideoTableViewController.swift
//  AppDemo
//
//  Created by kinghai on 7/10/15.
//  Copyright (c) 2015 onecloud.inc. All rights reserved.
//

import UIKit
import MobileCoreServices



class VideoTableViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let VIDEO_TABLE_VIEW_CELL_INDENTIFIER = "videoTableViewCellIdentifier"
    let PREVIEW_SEGUE_INDENTIFIER = "previewSegueIdentifier"
    
    let SHOW_VIDEO_UPDATE_VIEW_CONTROLLER_SEGUE_IDENTIFIER = "showVideoUpadateViewControllerSegueIdentifier"
    let SHOW_VIDEO_DETAIL_VIEW_CONTROLLER_SEGUE_IDENTIFIER = "showVideoDetailViewControllerSegueIdentifier"

    
    var videoService : VideoService?
    var multipartService : MultipartService?
    
    var catalog : Catalog?
    var videos = [Video]() {
        didSet {
            catalog!.videoNumber = UInt(videos.count)
        }
    }
    
    var uploadDelegate : UploadDelegate?
    var multipartDelegate : MultipartDelagate?
    
    var editingVideo : Video?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        
        videoService = AppContext.sdk?.getVideoService()
        multipartService = AppContext.sdk?.getMultipartService()
        
        uploadDelegate = UploadDelegate()
        uploadDelegate!.videoController = self
        uploadDelegate!.catalog = catalog
        
        multipartDelegate = MultipartDelagate()
        multipartDelegate!.videoController = self
        multipartDelegate!.catalog = catalog
    
        loadVideo()
//        
//        navigationItem.rightBarButtonItems = [
//                UIBarButtonItem(image: UIImage(named: "multipart"), style: UIBarButtonItemStyle.Plain, target: self, action: "multipartUpload:"),
//                UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "upload:"),
//        ]
    }
    
    @IBAction func onUploadBtnClick(sender: UIBarButtonItem) {
        upload(sender)
    }
    
    @IBAction func onMultipartBtnClick(sender: UIBarButtonItem) {
        multipartUpload(sender)
    }
    
    func upload(bar : UIBarButtonItem) {

        //open dialog to select av
        let imagePicker = getImagePicker()
        imagePicker.delegate = uploadDelegate
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func multipartUpload(bar : UIBarButtonItem) {
        
        let imagePicker = getImagePicker()
        imagePicker.delegate = multipartDelegate
        
        presentViewController(imagePicker, animated: true, completion: nil)
        
    }
    
    func getImagePicker() -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        imagePicker.mediaTypes = [ kUTTypeMovie, kUTTypeAudio ]

        return imagePicker
    }
    
    func loadVideo() {
        videoService?.list({ (videos) -> Void in

            self.videos.removeAll(keepCapacity: true)

            self.videos += (self.uploadDelegate?.getUploadingVideos())!
            self.videos += videos
            
            self.tableView.reloadData()
        }, onFail: AppUtil.onFail, catalogId: catalog!.id)
    }

    func addVideo(v : Video, index : Int) {
        videos.insert(v, atIndex: index)
        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
    }
    
    func removeVideo(index : Int) {
        videos.removeAtIndex(index)
        tableView.deleteRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: .Automatic)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(VIDEO_TABLE_VIEW_CELL_INDENTIFIER, forIndexPath: indexPath) as! VideoTableViewCell

        var v = videos[indexPath.row]
        
        cell.video = v
        cell.controller = self
        
        return cell
    }


    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }

    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        let row = indexPath.row
        let video = videos[row]
        
        var updateAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "编辑") { (action, indexPath) -> Void in
            
            self.editingVideo = video
            self.performSegueWithIdentifier(self.SHOW_VIDEO_UPDATE_VIEW_CONTROLLER_SEGUE_IDENTIFIER, sender: self)
        }
//        
//        var codeAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "详细") { (action, indexPath) -> Void in
//             self.editingVideo = video
//            self.performSegueWithIdentifier(self.SHOW_VIDEO_DETAIL_VIEW_CONTROLLER_SEGUE_IDENTIFIER, sender: self)
//        }
//        
//        codeAction.backgroundColor = UIColor.brownColor()

        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "删除") { (action, indexPath) -> Void in
            let row = indexPath.row
            let video = self.videos[row]
            
            self.videoService?.delete({ (msg) -> Void in
                self.videos.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }, onFail: AppUtil.onFail, id: video.id!)

        }
        deleteAction.backgroundColor = UIColor.redColor()
        
        if video.isUploading() {
            return []
        }
        
        if video.isProgressing() {
            return []
        }
        
        return [deleteAction, updateAction ]
    }
    


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
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
        
        println("go to segue \(segue.identifier)")
        
        
        switch segue.identifier! {
        case PREVIEW_SEGUE_INDENTIFIER :

            let row : Int! = tableView.indexPathForSelectedRow()?.row
            let video = videos[row]

            ((segue.destinationViewController as! UINavigationController).topViewController as! PreviewAVPlayerViewController).video = video
        case SHOW_VIDEO_UPDATE_VIEW_CONTROLLER_SEGUE_IDENTIFIER:
            
            ((segue.destinationViewController as! UINavigationController).topViewController as! VideoUpdateViewController).video = editingVideo
        default:
            println("no need prepare for segue \(segue.identifier)")
        }
    }
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if PREVIEW_SEGUE_INDENTIFIER == identifier {
        
            let row = tableView.indexPathForSelectedRow()?.row
            let video = videos[row!]
            
            if video.isAuditSuccess() {
                return true
            } else if video.isUploading() {
                return false
            } else {
                AppUtil.alert("预览失败", msg: "视频状态为 \(video.status!)")
                return false
            }
        } else {
            return super.shouldPerformSegueWithIdentifier(identifier, sender: sender)
        }
    }
}

class UploadDelegate : UIView, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    static var uploadingVideoDict = [String : [Video]]()

    weak var videoController : VideoTableViewController?
    weak var catalog : Catalog?
    {
        didSet {
            if let c = catalog {
                
                if nil == UploadDelegate.uploadingVideoDict.indexForKey(c.id) {
                    println("init uploading video array for catalog id \(c.id)")
                    var videos = [Video]()
                    UploadDelegate.uploadingVideoDict[c.id] = videos
                }
                
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        var path : NSURL = info[UIImagePickerControllerMediaURL] as! NSURL
        println("user has select \(path.path)")
        var file = LocalFile(contentsOfFile: path.path!)
        
        var catalog = videoController?.catalog
        let catalogId = catalog!.id
        
        let index = getUploadingVideos().count
        
        // upload
        let video = getVideo(path.path!, catalog : catalog!)
        
        add(video)
        videoController?.addVideo(video, index: 0)
        
        videoController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getVideo(path : String, catalog : Catalog) -> Video {
        return (videoController?.videoService?.upload({ (video : Video) -> Void in
            self.removeNotUploadingVideo()
            }, onFail: {(code : Int?, msg : String) -> () in
                self.removeNotUploadingVideo()
                AppUtil.onFail(code, msg: msg)
            }, filePath: path, catalogId: catalog.id, name: "IMG.mov", description: "upload from swift"))!
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        videoController!.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func add(video : Video) {
        var videos = getUploadingVideos()
        videos.append(video)
        setUploadingVideos(catalog!.id, videos: videos)
    }
    
    func removeNotUploadingVideo() {
        var existVideos = getUploadingVideos()
        var videos = [Video]()
        
        for ev in existVideos {
            if ev.isUploading() {
                videos.append(ev)
            }
        }
        
        setUploadingVideos(catalog!.id, videos: videos)
    }
    
    func getUploadingVideos() -> [Video] {
        return UploadDelegate.uploadingVideoDict[catalog!.id]!
    }
    
    func setUploadingVideos(key : String, videos : [Video]) {
        UploadDelegate.uploadingVideoDict[key] = videos
    }
}

class MultipartDelagate : UploadDelegate {
    override func getVideo(path: String, catalog: Catalog) -> Video {
        return (videoController?.multipartService?.upload({ (video) -> Void in
            self.removeNotUploadingVideo()
        }, onFail: { (code, msg) -> Void in
            self.removeNotUploadingVideo()
            AppUtil.onFail(code, msg: msg)
        }, filePath: path, catalog: catalog))!
    }
}