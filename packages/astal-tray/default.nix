{
  astal,
  json-glib,
  my,
}:
astal.buildAstalModule {
  name = "tray";
  buildInputs = [
    json-glib
    my.vala-panel-appmenu
  ];
  meta.description = "Astal module for StatusNotifierItem";
}
