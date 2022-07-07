
import UIKit

final class PhotoVC: UIViewController {
    
    private lazy var photoAPI = PhotoAPI()
    
    private lazy var photos = [Photo]()

    private lazy var collectionView: UICollectionView = {
        var collectionView =  UICollectionView(frame: UIScreen.main.bounds, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifire)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        photoAPI.fetchPhotos { photos in
            self.photos = photos
            self.collectionView.reloadData()
        }
       
    }
    
    private func setupViews() {
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        collectionView.pinEdgesToSuperView()
    }
}

extension PhotoVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension PhotoVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifire, for: indexPath) as! PhotoCell
        let photo = photos[indexPath.row]
        cell.configure(photo)
        return cell
    }
}

extension PhotoVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let inset = 10
        let itemsInRow = 2
        let insetsWidth = inset * (itemsInRow + 1)
        let availableWith = collectionView.bounds.width - CGFloat(insetsWidth)
        let widthForItem = availableWith / CGFloat(itemsInRow)
        return CGSize(width: widthForItem, height: widthForItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
