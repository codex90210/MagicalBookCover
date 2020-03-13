//
//  ViewController.swift
//  MagicalNewsPaperXD
//
//  Created by David Mompoint on 1/27/20.
//  Copyright © 2020 PolarisOne. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import SpriteKit
import SafariServices

class ViewController: UIViewController, ARSCNViewDelegate, SFSafariViewControllerDelegate{
    
    @IBOutlet var sceneView: ARSCNView!
    
    var webLink: String = ""
    var webIsRunning: Bool!
    var currentName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        //sceneView.showsStatistics = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARImageTrackingConfiguration()
        
        if let imageToTrack = ARReferenceImage.referenceImages(inGroupNamed: "MediaPaperImages", bundle: Bundle.main) {
            configuration.trackingImages = imageToTrack
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    @IBAction func webButton(_ sender: UIBarButtonItem) {
        
        // Error handling condition in case weblink value is empty and if not, present values
        
        if webLink == "" {
            let alertNotice = UIAlertController(title: "Error", message: "Book cover not found", preferredStyle: .alert)
            alertNotice.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alertNotice, animated: true, completion: nil)
        } else {
            if let url = URL(string: webLink) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                vc.modalPresentationStyle = .popover
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            
            let imageName = imageAnchor.referenceImage.name!
            //default values set for variables.
            //This setup below is a prototype concept to see how the app works for functionality testing in general to the application.
            //Later, the varibales would be tied to JSON API requests pulling data from the web.
            
            var trailer = ""
            var firstDimension = 0
            var secondDimension = 0
            
            if imageName == "CrazyRichAsians" {
                trailer = "CrazyRichAsiansTrailer.mp4"
                firstDimension = 1920
                secondDimension = 1080
                webLink = "https://www.barnesandnoble.com/w/crazy-rich-asians-kevin-kwan/1112787602?ean=9780345803788#/"
            } else if imageName == "HarryPotterFour" {
                trailer =  "HarryPotterFour.mp4"
                firstDimension = 640
                secondDimension = 360
                webLink = "https://www.barnesandnoble.com/w/harry-potter-and-the-goblet-of-fire-j-k-rowling/1100042956?ean=9780439139601#/"
            } else if imageName == "HarryPotterOne" {
                trailer = "HarryPotterOne.mp4"
                firstDimension = 640
                secondDimension = 360
                webLink = "https://www.barnesandnoble.com/w/harry-potter-and-the-sorcerers-stone-j-k-rowling/1100036321?ean=9780590353427#/"
            } else if imageName == "HungerGamesThree" {
                trailer = "HungerGamesThree.mp4"
                firstDimension = 1920
                secondDimension = 1080
                webLink = "https://www.barnesandnoble.com/w/mockingjay-suzanne-collins/1100171586?ean=9780545663267#/"
            } else if imageName == "Insurgent" {
                trailer = "InsurgentTrailer.mp4"
                firstDimension = 1920
                secondDimension = 1080
                webLink = "https://www.barnesandnoble.com/w/insurgent-veronica-roth/1105707005?ean=9780062388452"
            }
            
            let videoNode = SKVideoNode(fileNamed: "\(trailer)")
            videoNode.play()
            
            //Size
            let videoScene = SKScene(size: CGSize(width: firstDimension, height: secondDimension))
            
            videoNode.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
            
            videoNode.yScale = -1.0
            
            videoScene.addChild(videoNode)
            
            let plane = SCNPlane(width: imageAnchor.referenceImage.physicalSize.width, height: imageAnchor.referenceImage.physicalSize.height)
            plane.firstMaterial?.diffuse.contents = videoScene
            
            let planeNode = SCNNode(geometry: plane)
            
            planeNode.eulerAngles.x = -.pi/2
            
            node.addChildNode(planeNode)
        }
        return node
    }
    
}
