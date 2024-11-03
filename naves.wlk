class Nave {
  var velocidad = 0
  var direccion = 0
  var combustible

  method acelerarCantidad(unaCantidad){
    velocidad = 100000.min(velocidad + unaCantidad)
  }

  method desacelerarCantidad(unaCantidad){
    velocidad = 0.max(velocidad - unaCantidad)
  }

  method irHaciaElSol(){
    direccion = 10
  }

  method escaparDelSol(){
    direccion = -10
  }

  method ponerseParaleloAlSol(){
    direccion = 0
  }

  method acercarseUnPocoAlSol(){
    direccion = 10.min(direccion + 1)
  }

  method alejarseUnPocoAlSol(){
    direccion = (-10).max(direccion - 1)
  }

  method prepararViaje()

  method combustible() = combustible

  method cargarDeCombustibleCantidad(unaCantidad){
    combustible += unaCantidad
  }

  method descargarDeCombustibleCantidad(unaCantidad){
    combustible = 0.max(combustible - unaCantidad)
  }

  method accionAdicional(){
    self.cargarDeCombustibleCantidad(30000)
    self.acelerarCantidad(5000)
  }

  method estaTranquila() = combustible >= 4000 and velocidad <= 12000
}

class NaveBaliza inherits Nave {
  var baliza = "rojo"

  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
    self.accionAdicional()
  }

  method cambiarColorDeBaliza(colorNuevo){
    if(self.puedeTenerBalizaDeColor(colorNuevo)){
      baliza = colorNuevo
    } 
  }

  method puedeTenerBalizaDeColor(unColor) = unColor == "verde" or unColor == "rojo" or unColor == "azul"

  override method estaTranquila() = super() and baliza != "rojo"
}

class NaveDePasajeros inherits Nave {
  var cantidadDePasajeros 
  var cantidadRaciones = 0
  var cantidadBebidas = 0

  override method prepararViaje(){
    self.cargarDeRacionesCantidad(4* cantidadDePasajeros)
    self.cargarDeBebidasCantidad(6 * cantidadDePasajeros)
    self.acercarseUnPocoAlSol()
    self.accionAdicional()
  }

  method cargarDeRacionesCantidad(unaCantidad){
    cantidadRaciones += unaCantidad
  }

  method descargarDeRacionesCantidad(unaCantidad){
    cantidadRaciones = 0.max(cantidadRaciones - unaCantidad)
  }

  method cargarDeBebidasCantidad(unaCantidad){
    cantidadBebidas += unaCantidad
  }

  method descargarDeBebidasCantidad(unaCantidad){
    cantidadBebidas = 0.max(cantidadBebidas - unaCantidad)
  }
}

class NaveDeCombate inherits Nave {
  var estaInvisible = false
  var misilesDesplegados = false
  const mensajesEmitidos = []

  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerarCantidad(15000)
    self.emitirMensaje("Saliendo en mision")
    self.accionAdicional()
  }

  override method accionAdicional(){
    super()
    self.acelerarCantidad(15000)
  }

  method ponerseVisible(){
    estaInvisible = false
  }

  method ponerseInvisible(){
    estaInvisible = true
  }

  method estaInvisible() = estaInvisible

  method desplegarMisiles(){
    misilesDesplegados = true
  }

  method replegarMisiles(){
    misilesDesplegados = false
  }

  method misilesDesplegados() = misilesDesplegados

  method emitirMensaje(unMensaje){
    mensajesEmitidos.add(unMensaje)
  }

  method mensajesEmitidos() = mensajesEmitidos

  method primerMensajeEmitido() = mensajesEmitidos.first()

  method ultimoMensajeEmitido() = mensajesEmitidos.last()

  method esEscueta() = mensajesEmitidos.all({mensaje => mensaje.size() <= 30})

  method emitioMensaje(unMensaje) = mensajesEmitidos.contains(unMensaje)

  override method estaTranquila() = super() and not misilesDesplegados
}

class NaveHospital inherits NaveDePasajeros {
  var tieneQuirofanosPreparados = false

  method tieneQuirofanosPreparados() = tieneQuirofanosPreparados

  method prepararQuirofanos(){
    tieneQuirofanosPreparados = true
  }

  method desprepararQuirofanos(){
    tieneQuirofanosPreparados = false
  }

  override method estaTranquila() = super() and not tieneQuirofanosPreparados
}

class NaveDeCombateSigilosa inherits NaveDeCombate {

  override method estaTranquila() = super() and not estaInvisible
}