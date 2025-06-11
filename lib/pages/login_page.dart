import 'package:canting_app/custom_widgets/custom_text_input_.dart';
import 'package:canting_app/provider/index_nav_provider.dart';
import 'package:canting_app/provider/simple_property_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:canting_app/custom_widgets/custom_button_elevated.dart';
import 'package:canting_app/custom_widgets/custom_tab_bar_item.dart';
import 'package:canting_app/extension/snackbar_extension.dart';
import 'package:canting_app/provider/login_tab_provider.dart';
import 'package:canting_app/routes/navigation_route.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with TickerProviderStateMixin {
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerPhoneNumber = TextEditingController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<LoginTabProvider>().setCurrentTabIndex(
          _tabController.index,
        );
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerPhoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox.square(
                dimension:
                    MediaQuery.of(context).orientation == Orientation.portrait
                    ? 64
                    : 0,
              ),
              Text(
                "Welcome to Canting",
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                "Enter your login info to continue",
                style: Theme.of(context).textTheme.labelLarge,
              ),
              SizedBox.square(dimension: 16.0),
              CustomTabBarItem(
                tabController: _tabController,
                tab: [
                  Tab(text: "Login"),
                  Tab(text: "Phone Number"),
                ],
                onTap: (index) =>
                    context.read<LoginTabProvider>().setCurrentTabIndex(index),
              ),
              const SizedBox.square(dimension: 16.0),
              Expanded(
                /// jangan dihapus
                // child: Consumer<LoginTabProvider>(
                //   builder: (context, tabProvider, child) {
                //     return IndexedStack(
                //       index: tabProvider.currentTabIndex,
                //       children: [
                //         _buildLoginForm(context),
                //         _buildPhoneForm(context),
                //       ],
                //     );
                //   },
                // ),
                child: IndexedStack(
                  index: context.watch<LoginTabProvider>().currentTabIndex,
                  children: [
                    _buildLoginForm(context),
                    _buildPhoneForm(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    bool isHidden = context.watch<SimplePropertyProvider>().isHidden;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Email"),
          CustomTextInput(
            controller: _controllerEmail,
            textInputType: TextInputType.emailAddress,
            hintText: "Email",
          ),
          const SizedBox.square(dimension: 16.0),
          const Text("Password"),
          CustomTextInput(
            controller: _controllerPassword,
            textInputType: TextInputType.visiblePassword,
            hintText: "Password",
            obsecureText: isHidden,
            suffixIcon: IconButton(
              onPressed: () {
                context.read<SimplePropertyProvider>().toggleHidden();
              },
              icon: Icon(isHidden ? Icons.visibility : Icons.visibility_off),
            ),
          ),
          const SizedBox.square(dimension: 8.0),
          Align(
            alignment: Alignment.centerRight,
            child: InkWell(
              onTap: () {},
              child: Text(
                "Forgot Password?",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
          ),
          const SizedBox.square(dimension: 16.0),
          _filledButtonLoginAndOtp(
            context,
            text: 'Login',
            onPressed: () {
              context.snackbarShow("Anda Berhasil Login");
              context.read<IndexNavProvider>().resetIndex();
              Navigator.pushReplacementNamed(
                context,
                NavigationRoute.mainRoute.name,
              );
            },
          ),
          const SizedBox.square(dimension: 16.0),
          const Center(child: Text("or continue with")),
          const SizedBox.square(dimension: 16.0),
          CustomButtonElevated(
            onPressed: () {
              context.featNotAvailable();
            },
            imageSource: 'assets/images/google_g_logo.png',
            nameButton: "Google",
          ),
          const SizedBox.square(dimension: 4.0),
          CustomButtonElevated(
            onPressed: () {
              context.featNotAvailable();
            },
            imageSource: 'assets/images/apple_logo.png',
            nameButton: 'Apple',
          ),
          const SizedBox.square(dimension: 64.0),
          _buildFooter(context),
        ],
      ),
    );
  }

  /// Form Phone Number
  Widget _buildPhoneForm(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Phone Number"),
          CustomTextInput(
            controller: _controllerPhoneNumber,
            textInputType: TextInputType.phone,
            hintText: " +62 812 3456 7890",
            prefixText: "+62 ",
          ),
          const SizedBox.square(dimension: 24.0),
          _filledButtonLoginAndOtp(
            context,
            text: "Send Otp",
            onPressed: () {
              Navigator.pushReplacementNamed(
                context,
                NavigationRoute.mainRoute.name,
              );
            },
          ),
          const SizedBox.square(dimension: 16.0),
          Text(
            "We'll send you a verification code via SMS",
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  /// Login button dan Login button Phone Number
  SizedBox _filledButtonLoginAndOtp(
    BuildContext context, {
    required String text,
    required void Function() onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Text(text),
      ),
    );
  }

  /// Footer: Dont Have Account
  Row _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        TextButton(
          onPressed: () {},
          style: ButtonStyle(
            padding: WidgetStateProperty.all(EdgeInsets.zero),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: Text(
            "Register",
            style: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}
