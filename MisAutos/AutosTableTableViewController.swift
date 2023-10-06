import UIKit

class AutosTableViewController: UITableViewController {

    var autos: [Auto] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        autos = [
            Auto(marca: "Toyota", modelo: "Corolla", descripcion: "El Toyota Corolla es un automóvil compacto reconocido por su confiabilidad y eficiencia. Es una opción popular en todo el mundo y ha ganado la confianza de millones de conductores. Con su diseño elegante y tecnología innovadora, el Corolla es una excelente elección para aquellos que buscan un vehículo confiable y económico.", imagen: UIImage(named: "corolla")),
            Auto(marca: "Honda", modelo: "Civic", descripcion: "El Honda Civic es un sedán compacto que ha ganado una gran popularidad debido a su combinación de estilo, rendimiento y eficiencia. Con su diseño aerodinámico y características avanzadas, el Civic es una excelente opción para conductores que valoran la calidad y la economía de combustible.", imagen: UIImage(named: "civic")),
            Auto(marca: "Ford", modelo: "Mustang", descripcion: "El Ford Mustang es un icónico muscle car que ha dejado una marca indeleble en la industria automotriz. Con su potente motor y su diseño agresivo, el Mustang es sinónimo de velocidad y emoción. Es una elección perfecta para los amantes de la adrenalina y la potencia pura.", imagen: UIImage(named: "mustang")),
            Auto(marca: "Chevrolet", modelo: "Cruze", descripcion: "El Chevrolet Cruze es un auto compacto que ha ganado popularidad por su equilibrio entre tamaño y eficiencia. Es ideal para aquellos que buscan un vehículo maniobrable y fácil de estacionar sin comprometer el espacio interior. Con su diseño moderno y características innovadoras, el Cruze es una excelente opción en su categoría.", imagen: UIImage(named: "cruze")),
            Auto(marca: "BMW", modelo: "X5", descripcion: "El BMW X5 es un SUV de lujo que combina elegancia y alto rendimiento. Con su diseño imponente y su interior lujosamente equipado, el X5 ofrece una experiencia de conducción excepcional. Es perfecto para aquellos que buscan un vehículo que ofrezca comodidad, tecnología y un rendimiento excepcional en cualquier terreno.", imagen: UIImage(named: "x5")),
            Auto(marca: "Audi", modelo: "A4", descripcion: "El Audi A4 es un sedán de gama alta que destaca por su tecnología avanzada y su elegante diseño. Con características innovadoras y un interior sofisticado, el A4 ofrece una experiencia de conducción premium. Es la elección perfecta para aquellos que buscan estilo, rendimiento y tecnología de vanguardia.", imagen: UIImage(named: "a4")),
            Auto(marca: "Nissan", modelo: "Altima", descripcion: "El Nissan Altima es un sedán mediano muy popular conocido por su confiabilidad y eficiencia. Con su diseño moderno y características avanzadas, el Altima ofrece una experiencia de conducción cómoda y agradable. Es una excelente opción para aquellos que buscan un vehículo familiar confiable y elegante.", imagen: UIImage(named: "altima")),
            Auto(marca: "Tesla", modelo: "Model 3", descripcion: "El Tesla Model 3 es un auto eléctrico revolucionario con una autonomía impresionante. Con su diseño futurista y tecnología de vanguardia, el Model 3 está a la vanguardia de la innovación automotriz. Es la elección perfecta para aquellos que buscan un vehículo ecológico sin comprometer el rendimiento.", imagen: UIImage(named: "model3")),
            Auto(marca: "Mercedes-Benz", modelo: "C-Class", descripcion: "El Mercedes-Benz C-Class es un sedán de lujo que combina elegancia y potencia. Con su interior lujosamente equipado y su diseño sofisticado, el C-Class ofrece una experiencia de conducción excepcional. Es la elección perfecta para aquellos que buscan un vehículo que refleje estilo y exclusividad.", imagen: UIImage(named: "cclass")),
            Auto(marca: "Jeep", modelo: "Wrangler", descripcion: "El Jeep Wrangler es un todoterreno legendario conocido por su capacidad off-road inigualable. Con su diseño robusto y características diseñadas para la aventura, el Wrangler es el compañero perfecto para explorar terrenos difíciles. Es la elección ideal para los amantes de la naturaleza y la emoción en estado puro.", imagen: UIImage(named: "wrangler"))
        ]


        self.tableView.isEditing = true
        self.tableView.estimatedRowHeight = 100
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        setEditing(true, animated: true)
        
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autos.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let auto = autos[indexPath.row]
        
        cell.textLabel?.text = "\(auto.marca) \(auto.modelo)"
        cell.detailTextLabel?.text = auto.descripcion
        cell.imageView?.image = auto.imagen
        
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            autos.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let autoMovido = self.autos[fromIndexPath.row]
        autos.remove(at: fromIndexPath.row)
        autos.insert(autoMovido, at: to.row)
        NSLog("%@", "\(fromIndexPath.row) => \(to.row) \(autos)")
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        if self.isEditing {
            self.editButtonItem.title = "Editar"
        } else {
            self.editButtonItem.title = "Hecho"
        }
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let eliminarAction = UIContextualAction(style: .destructive, title: "Eliminar") { [weak self] (action, view, completion) in
            self?.eliminarAutoEnIndexPath(indexPath)
            completion(true)
        }
        
        let verMasAction = UIContextualAction(style: .normal, title: "Ver Más") { [weak self] (action, view, completion) in
            self?.mostrarDetallesDelAutoEnIndexPath(indexPath)
            completion(true)
        }
        
        let configuracionAcciones = UISwipeActionsConfiguration(actions: [eliminarAction, verMasAction])
        configuracionAcciones.performsFirstActionWithFullSwipe = false
        return configuracionAcciones
    }
    
    private func eliminarAutoEnIndexPath(_ indexPath: IndexPath) {
        autos.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    }
    
    private func mostrarDetallesDelAutoEnIndexPath(_ indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let detalleViewController = storyboard.instantiateViewController(withIdentifier: "DetalleViewController") as? DetalleViewController else {
            return
        }
        
        detalleViewController.auto = autos[indexPath.row]
        self.navigationController?.pushViewController(detalleViewController, animated: true)
    }

}

