import UIKit


// MARK: - 查找复用cell(代码创建和xib创建)的便利方法
extension UITableViewCell {
    public static var identifier : String {
        return String(describing: self)
    }
    
    public static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UITableView {
    
    /// 查找使用代码编写的复用cell
    ///
    /// - Parameters:
    ///   - cellType: 传递 YourCell.self
    ///   - style: UITableViewCellStyle 默认为default
    /// - Returns: YourCell的实例
    public func dequeueReusableClassCell<T : UITableViewCell>(_ cellType : T.Type, style : UITableViewCell.CellStyle = .default) -> T {
        let identifier = cellType.identifier
        var cell = dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = T(style: style, reuseIdentifier: identifier)
        }
        return cell as! T
    }
    
    /// 查找xib创建的复用的cell
    ///
    /// - Parameters:
    ///   - cellType: 传递 YourCell.self
    ///   - owner: loadNibNamed的参数owner,一般传递self
    /// - Returns: YourCell的实例
    public func dequeueReusableNibCell<T : UITableViewCell>(_ cellType : T.Type,owner: Any?) -> T {
        let identifier = cellType.identifier
        var cell = dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            let wraperCell = Bundle.main.loadNibNamed(identifier, owner: owner, options: nil)?.first
            guard let unwrap = wraperCell as? T else {
                fatalError("cell is nil or cell can not be converted to \(type(of: T.self))")
            }
            cell = unwrap
        }
        return cell as! T
    }
}


extension UICollectionViewCell {
    public static var identifier : String {
        return String(describing: self)
    }
    
    public static var nib : UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}

extension UICollectionView {
    
    /// 注册UICollectionViewCell
    /// - Parameter cellType: 传递 YourCell.self
    public func registerClass<T : UICollectionViewCell>(cellType: T.Type) {
        register(cellType.classForCoder(), forCellWithReuseIdentifier: cellType.identifier)
    }
    
    public func registerNib<T : UICollectionViewCell>(cellType: T.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    public func dequeueReusableCell<T : UICollectionViewCell>(_ cellType : T.Type,indexPath: IndexPath) -> T {
        let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath)
        guard let unwrap = cell as? T else {
            fatalError("cell is nil or cell can not be converted to \(type(of: T.self))")
        }
        return unwrap
    }
}

