//
//  ViewController.swift
//  nasAR2
//
//  Created by Ji Hye Park on 10/3/20.
//  Copyright © 2020 DAJSpace. All rights reserved.
//

import UIKit
import RealityKit
import ARKit
import Foundation

class ViewController: UIViewController {
    @IBOutlet var arView: ARView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("hello!")
        let url = "http://api.open-notify.org/iss-now.json"
        getData(from: url)
    }
    
    private func getData(from url: String) {

        URLSession.shared.dataTask(with: URL (string: url)!, completionHandler: {
            data, response, error in

            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("failed")
            }
            guard let json = result else {
                return
            }
            print(json)
            }).resume()
    }
       
}

struct Response: Codable {
            let iss_position: PositionDetail
        }
struct PositionDetail: Codable {
            let latitude: String
            let longitude: String
}


//class ViewController: UIViewController {
//
//    @IBOutlet var arView: ARView!
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        arView.session.delegate = self
//
//        setupARView()
//
//        arView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:))))
//    }
//
//    func setupARView() {
//        arView.automaticallyConfigureSession = false
//        let configuration = ARWorldTrackingConfiguration()
//        configuration.planeDetection = [.horizontal, .vertical]
//        configuration.environmentTexturing = .automatic
//        arView.session.run(configuration)
//    }
//
//    @objc
//    func handleTap(recognizer: UITapGestureRecognizer) {
//        let location = recognizer.location(in: arView)
//
//        let results = arView.raycast(from: location, allowing: .estimatedPlane, alignment: .horizontal)
//
//        if let firstResult = results.first {
//            let anchor = ARAnchor(name:  "Star", transform: firstResult.worldTransform)
//            arView.session.add(anchor: anchor)
//        } else {
//            print("Object placement failed - couldn't find surface.")
//        }
//    }
//
//    func placeObject(named entityName: String, for anchor: ARAnchor) {
//        let entity = try! ModelEntity.loadModel(named: entityName)
//
//        entity.generateCollisionShapes(recursive: true)
//        arView.installGestures([.rotation, .translation], for: entity)
//
//        let anchorEntity = AnchorEntity(anchor: anchor)
//        anchorEntity.addChild(entity)
//        arView.scene.addAnchor(anchorEntity)
//    }
//}
//
//extension ViewController: ARSessionDelegate {
//    func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
//        for anchor in anchors {
//            if let anchorName = anchor.name, anchorName == "Star" {
//                placeObject(named: anchorName, for: anchor)
//            }
//        }
//    }
//}
