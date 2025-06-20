{
  astal,
  json-glib,
  my,
}:
astal.buildAstalModule {
  name = "tray";
  buildInputs = [
    json-glib
    my.appmenu-glib-translator
  ];
  meta.description = "Astal module for StatusNotifierItem";
}
