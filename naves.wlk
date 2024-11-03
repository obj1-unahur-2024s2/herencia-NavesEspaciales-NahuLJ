class Nave {
  var velocidad = 0
  var direccion = 0

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
}


class NvaeBaliza inherits Nave {
  var baliza = "rojo"

  override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
  }

  method cambiarColorDeBaliza(colorNuevo){
    if(self.puedeTenerBalizaDeColor(colorNuevo)){
      baliza = colorNuevo
    } 
  }

  method puedeTenerBalizaDeColor(unColor) = unColor == "verde" or unColor == "rojo" or unColor == "azul"

}

class NaveDePasajeros inherits Nave {
  var cantidadDePasajeros 
  var cantidadRaciones = 0
  var cantidadBebidas = 0

  override method prepararViaje(){
    self.cargarDeRacionesCantidad(4* cantidadDePasajeros)
    self.cargarDeBebidasCantidad(6 * cantidadDePasajeros)
    self.acercarseUnPocoAlSol()
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
}