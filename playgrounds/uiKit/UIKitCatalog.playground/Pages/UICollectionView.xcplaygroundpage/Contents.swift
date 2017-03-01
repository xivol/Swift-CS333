//: # UICollectionView
//: Manages an ordered collection of data items and presents them using customizable layouts.
//:
//: [Collection View API Reference](https://developer.apple.com/reference/uikit/uicollectionview)
import UIKit
import PlaygroundSupport

class Model: NSObject, UICollectionViewDataSource {
    let cellReuseIdentifier = "Cell"
    let headerReuseIdentifier = "Header"
    
    var data = [[String]]()
    var titles = [String]()
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].count
    }
    
    // Mark: Cells
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath)
        // Collection View Cells contain several subviews
        cell.backgroundView = UIView(frame: cell.bounds)
        cell.backgroundView?.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        cell.selectedBackgroundView = UIView(frame: cell.bounds)
        cell.selectedBackgroundView?.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
        // Content Mode manages subview layout
        cell.contentMode = .scaleAspectFit
        // Content View: views to be displayed
        cell.contentView.subviews.last?.removeFromSuperview() // clear for reuse
        // There are no default labels, so we need to add one
        cell.contentView.addSubview(cellLabel(for: indexPath, of: cell.bounds.size))
        // Add Shadow
        cell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        cell.layer.shadowRadius = 5
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowOffset = CGSize.zero
        
        return cell
    }
    
    func cellLabel(for indexPath: IndexPath, of size: CGSize) -> UILabel {
        let titleFrame = CGRect(origin: CGPoint.zero, size: size)
        let title = UILabel(frame: titleFrame)
        title.text = data[indexPath.section][indexPath.row]
        title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        title.textAlignment = .center
        return title
    }
    
    // MARK: Section Header and Footer
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerReuseIdentifier, for: indexPath)
            
            header.subviews.last?.removeFromSuperview() // clear for reuse
            header.addSubview(headerLabel(for: indexPath.section, of: header.bounds.size))
            return header
        case UICollectionElementKindSectionFooter:
            fallthrough // are not set up
        default:
            print("Wrong kind of element!")
            PlaygroundPage.current.finishExecution()
        }
    }

    func headerLabel(for section: Int, of size: CGSize) -> UILabel {
        let titleFrame = CGRect(origin: CGPoint.zero, size: size)
        let title = UILabel(frame: titleFrame)
        title.text = titles.count > section ? titles[section] : "???"
        title.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        title.textAlignment = .center
        return title
    }
}

class Controller: NSObject, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let dataSource = collectionView.dataSource as? Model else {
            print("Unexpected data source!")
            PlaygroundPage.current.finishExecution()
        }
        dataSource.data[indexPath.section][indexPath.row] = "👻"
        collectionView.reloadItems(at: [indexPath])
    }
}
//: ### Create Layout
let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//: Cell Margins
layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//: Cell Size
layout.itemSize = CGSize(width: 50, height: 50)
//: Header size
layout.headerReferenceSize = CGSize(width: 50, height: 25)
//: Scroll Direction
layout.scrollDirection = .vertical
//: ### Initialize Collection View
let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 250, height: 500), collectionViewLayout: layout)
collectionView.backgroundView = UIImageView(image: #imageLiteral(resourceName: "gradient.png"))
//: ### Initialize Data
let dataSource = Model()
dataSource.titles.append("Bees")
dataSource.data.append([String](repeating: "🐝", count: 8))
dataSource.titles.append("Flowers")
dataSource.data.append([String](repeating: "🌺", count: 8))
dataSource.titles.append("Candies")
dataSource.data.append([String](repeating: "🍭", count: 8))
//: ### Register Reuseable Classes
collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: dataSource.cellReuseIdentifier)
collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: dataSource.headerReuseIdentifier)
collectionView.dataSource = dataSource
//: ### Setup Controller
let delegate = Controller()
collectionView.delegate = delegate

PlaygroundPage.current.liveView = collectionView
