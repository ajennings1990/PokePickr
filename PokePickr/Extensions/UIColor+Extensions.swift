import UIKit

public extension UIColor {
    
    static let mainBlue = initiliazeFromRGBInt(integers: 55, 125, 226)
    
    static private func initiliazeFromRGBInt(integers: Int...) -> UIColor {
        guard integers.count == 3 else { return UIColor.orange }
        
        return UIColor(
            red: CGFloat(integers[0])/255.0,
            green: CGFloat(integers[1])/255.0,
            blue: CGFloat(integers[2])/255.0,
            alpha: 1
        )
    }
}
