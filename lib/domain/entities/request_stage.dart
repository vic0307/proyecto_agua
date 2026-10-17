enum RequestStage {
  recibida('Recibida', 'Ya tenemos su solicitud.'),
  enRevision('En revisión', 'Estamos revisando los datos.'),
  programada('Programada', 'Ya hay fecha para atenderle.'),
  entregada('Entregada', 'El servicio fue completado.');

  const RequestStage(this.title, this.description);
  final String title;
  final String description;
}
