import 'package:canting_app/custom_widgets/custom_profile_list_tile.dart';
import 'package:canting_app/extension/snackbar_extension.dart';
import 'package:canting_app/provider/index_nav_provider.dart';
import 'package:canting_app/provider/theme_mode_provider.dart';
import 'package:canting_app/routes/navigation_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: CircleAvatar(
                    radius: 25,
                    child: Image.network(
                      'https://bugcatcapoostore.com/cdn/shop/files/Store_Logo.png?v=1745154585&width=866',
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    "Jean (Jeanjinmo)",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text("+62 812 3456 7890"),
                ),
                SizedBox.square(dimension: 16.0),
                Text("General"),
                CustomProfileListTile(
                  onTap: context.featNotAvailable,
                  leadingIcon: Icons.language,
                  startText: "Language",
                  endText: "English",
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                CustomProfileListTile(
                  onTap: () => context.featNotAvailable(),
                  leadingIcon: Icons.location_on,
                  startText: "Address",
                  endText: "Home",
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                CustomProfileListTile(
                  onTap: () => context.featNotAvailable(),
                  leadingIcon: Icons.payments,
                  startText: "Payment Methods",
                  endText: "Gopay",
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                CustomProfileListTile(
                  onTap: () => context.featNotAvailable(),
                  leadingIcon: Icons.favorite,
                  startText: "Favorites",
                  endText: "5",
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                CustomProfileListTile(
                  onTap: () => context.featNotAvailable(),
                  leadingIcon: Icons.settings,
                  startText: "Settings",
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                  child: Text("Theme"),
                ),
                Consumer<ThemeModeProvider>(
                  builder: (context, value, child) {
                    return CustomProfileListTile(
                      leadingIcon: value.themeMode == ThemeMode.dark
                          ? Icons.dark_mode
                          : Icons.light_mode,
                      startText: value.themeMode == ThemeMode.dark
                          ? "Dark Mode"
                          : "Light Mode",
                      trailing: Switch(
                        value: value.themeMode == ThemeMode.dark,
                        onChanged: (isOn) {
                          debugPrint('info ThemeMode: ${value.themeMode}');
                          value.setThemeMode(
                            isOn ? ThemeMode.dark : ThemeMode.light,
                          );
                        },
                      ),
                    );
                  },
                ),
                SizedBox.square(dimension: 30.0),
                _footerLogout(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Button Logout dan footer
  Column _footerLogout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12.0),
              ),
              backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            ),
            onPressed: () {
              context.snackbarShow("Anda Berhasil logout");
              context.read<IndexNavProvider>().resetIndex();
              Navigator.pushReplacementNamed(
                context,
                NavigationRoute.loginRoute.name,
              );
            },
            label: Text(
              "Logout",
              style: Theme.of(context).textTheme.labelLarge!,
            ),
            icon: Icon(
              Icons.logout,
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ),
          ),
        ),
        const SizedBox.square(dimension: 32.0),
        Center(
          child: Text(
            "Version 1.0.0",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ],
    );
  }
}
