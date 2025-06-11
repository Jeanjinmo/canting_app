enum NavigationRoute {
  mainRoute("/"),
  detailRoute("/detail"),
  loginRoute("/login"),
  splashRoute("/splash");

  const NavigationRoute(this.name);
  final String name;
}
