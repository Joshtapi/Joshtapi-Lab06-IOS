import UIKit

class DetalleViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var marcaLabel: UILabel!
    @IBOutlet weak var modeloLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    var auto: Auto?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let auto = auto {
           
            imageView.image = auto.imagen
            marcaLabel.text = auto.marca
            modeloLabel.text = auto.modelo
            descripcionLabel.text = auto.descripcion
            descripcionLabel.numberOfLines = 0
        }
    }
    
}

