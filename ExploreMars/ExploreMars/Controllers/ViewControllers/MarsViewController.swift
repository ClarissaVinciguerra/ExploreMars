//
//  MarsViewController.swift
//  ExploreMars
//
//  Created by Clarissa Vinciguerra on 9/23/20.
//

import UIKit

class MarsViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var marsImageView: UIImageView!
    @IBOutlet weak var imageDescriptionLabel: UILabel!
    
    // MARK: - Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    @IBAction func exploreButtonTapped(_ sender: Any) {
        MarsController.fetchPhoto { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let photo):
                    self?.fetchImageAndUpdateViews(for: photo)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                    print(error)
                }
            }
        }
    }
    
    // MARK: Helper Functions
    func fetchImageAndUpdateViews(for photo: Photo) {
        MarsController.fetchImageFor(photo: photo) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.imageDescriptionLabel.text = "This photo was taken on \(photo.earth_date) by the \(photo.camera.name) of the Curiosity Rover."
                    self?.marsImageView.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
} 
