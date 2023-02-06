enum Keys {
    enum Home: String {
        case title = "Shipping"
        case button = "Check out"
    }
    
    enum Transversal: String {
        case titleBuy = "Monto"
        case titleAlert = "Validacion"
        case messageAlertOne = "Debe ingresar un monto"
        case messageAlertTwo = "Monto debe ser mayor a 0"
        case insertAmount = "Ingreso de monto"
        case placeholder = "$0.000"
        case ok = "OK"
        case next = "Next"
        case titlePayment = "Medios de pago"
        case payment = "Selecciona un medio de pago"
        case titleBank = "Bancos"
        case bank = "Selecciona un banco"
        case titleQuota = "Cuotas"
        case quotas = "Seleciona la cantidad de cuotas"
    }
    
    enum Alert: String {
        case title = "¡¡Atención!!"
        case success = "Pagar"
        case cancel = "Cancelar"
    }
}
