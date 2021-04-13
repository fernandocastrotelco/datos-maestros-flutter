import 'package:app_flutter_datosmaestros/color_style.dart';
import 'package:app_flutter_datosmaestros/pages/dashboard_page.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_button.dart';
import 'package:app_flutter_datosmaestros/widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool passwordVisible;

  var fullNameController = TextEditingController();
  var addressController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 800) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: mobileBody(constraints.biggest.width * 0.9),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: desktopBody(),
            ),
          );
        }
      },
    );
  }

  Widget formSignUp() {
    return Column(
      children: [
        isLogin
            ? SizedBox(
                height: 80.0,
              )
            : CustomTextField(
                nameController: fullNameController,
                label: 'Nombre',
                icon: Icons.person),
        SizedBox(height: 18.0),
        isLogin
            ? SizedBox()
            : CustomTextField(
                nameController: addressController,
                label: 'Direccion',
                icon: Icons.home),
        SizedBox(height: 18.0),
        CustomTextField(
            nameController: emailController, label: 'Email', icon: Icons.email),
        SizedBox(height: isLogin ? 10.0 : 18.0),
        isLogin
            ? SizedBox()
            : CustomTextField(
                keyboardType: TextInputType.phone,
                nameController: phoneController,
                label: 'Telefono',
                icon: Icons.phone),
        SizedBox(height: isLogin ? 10.0 : 18.0),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
              offset: Offset(0, 5),
              blurRadius: 10.0,
              color: Colors.black12,
            )
          ]),
          child: TextField(
            obscureText: !passwordVisible,
            controller: passwordController,
            keyboardType: TextInputType.visiblePassword,
            decoration: InputDecoration(
                prefixIcon: Icon(Icons.lock),
                suffixIcon: IconButton(
                    icon: Icon(
                      passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: Theme.of(context).primaryColor,
                    ),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    }),
                labelText: 'Contraseña',
                fillColor: Colors.white,
                filled: true,
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide(width: 0.2, color: Colors.grey)),
                labelStyle: TextStyle(fontSize: 14.0),
                hintStyle: TextStyle(color: Colors.grey, fontSize: 10.0)),
            style: TextStyle(fontSize: 14.0),
          ),
        ),
        SizedBox(height: 28.0),
        CustomButton(
          text: 'Guardar',
          onPressed: () {
            isLogin ? _validationLogin() : _validationSignUp();
          },
        ),
        SizedBox(height: 12.0),
        TextButton(
            onPressed: () {
              setState(() {
                isLogin = !isLogin;
              });
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Guardar'),
                SizedBox(width: 3.0),
                Text(
                  isLogin ? 'Create account' : 'Login Here',
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: BrandColors.colorPrimary.withOpacity(0.7)),
                )
              ],
            ))
      ],
    );
  }

  _validationSignUp() {
    if (fullNameController.text.length < 3) {
      print('check fullName');
      return;
    }
    if (addressController.text.length < 3) {
      print('check address');
      return;
    }
    if (!emailController.text.contains('@')) {
      print('check email');
      return;
    }
    if (phoneController.text.length < 8) {
      print('check phone');
      return;
    }

    if (passwordController.text.length < 8) {
      print('check password');
      return;
    }
    registration();
    fullNameController.clear();
    addressController.clear();
    emailController.clear();
    passwordController.clear();
    phoneController.clear();
  }

  registration() async {
    print('registration start');
    // var _idRes = await RequstHelper.signUpRequest(
    //   name: fullNameController.text,
    //   address: addressController.text,
    //   email: emailController.text,
    //   phone: phoneController.text,
    //   password: passwordController.text,
    // );
    //if (_idRes.toString() != 'failed') {

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => DashBoardPage()));
    // } else {
    //   print('Sign up FAILED');
    // }
  }

  _validationLogin() {
    if (!emailController.text.contains('@')) {
      print('check email');
      return;
    }

    if (passwordController.text.length < 8) {
      print('check password');
      return;
    }
  }

  List<Widget> desktopBody() {
    return <Widget>[
      LeftSideBody(
        isLogin: isLogin,
      ),
      Expanded(
          child: Column(
        children: [
          isLogin ? LoginTopTitle() : SizedBox(),
          formSignUp(),
          Spacer(),
          Container(
            height: 1.2,
            color: Colors.black12,
            width: double.infinity,
          ),
          SocialLink()
        ],
      ))
    ];
  }

  List<Widget> mobileBody(double width) {
    return <Widget>[
      Container(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'KITShop',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 18.0),
            Text(
              isLogin ? 'Please Login to your account.' : 'welcome back',
              style: TextStyle(
                  fontWeight: FontWeight.w700, color: BrandColors.colorText),
            ),
            SizedBox(height: 8.0),
            Text(
              isLogin ? 'Welcome Back' : 'Create your\npersonal\ncabinet',
              style: TextStyle(
                  letterSpacing: 1.5,
                  fontSize: 36.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            formSignUp(),
            SizedBox(height: 32.0),
            Text(
              'Social network',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: BrandColors.colorText,
              ),
            ),
            SizedBox(height: 7.0),
            Container(
              height: 1.2,
              color: Colors.black12,
              width: double.infinity,
            ),
            SocialLink()
          ],
        ),
      ),
    ];
  }
}

class LoginTopTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Please Login to your account.',
          style: TextStyle(
              fontWeight: FontWeight.w700, color: BrandColors.colorText),
        ),
        SizedBox(height: 8.0),
        Text(
          'Welcome Back',
          style: TextStyle(
              letterSpacing: 1.5,
              fontSize: 48.0,
              color: Colors.black,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

class SocialLink extends StatelessWidget {
  const SocialLink({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        IconButton(
            iconSize: 36.0,
            color: BrandColors.colorText,
            tooltip: 'Facebook',
            icon: Icon(FontAwesome.facebook_square),
            onPressed: () {}),
        SizedBox(width: 5.0),
        IconButton(
            iconSize: 36.0,
            color: BrandColors.colorText,
            tooltip: 'Telegram',
            icon: Icon(FontAwesome.telegram),
            onPressed: () {}),
      ],
    );
  }
}

class LeftSideBody extends StatelessWidget {
  final bool isLogin;
  LeftSideBody({this.isLogin});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isLogin
                ? Center(
                    child: Container(
                      height: 400.0,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/logo_k.png',
                            color: BrandColors.colorText,
                          ),
                          Positioned(
                              bottom: 20.0,
                              left: 20.0,
                              child: Text(
                                'kitshop'.toUpperCase(),
                                style: TextStyle(
                                    fontSize: 55.0,
                                    fontWeight: FontWeight.w700,
                                    color: BrandColors.colorText),
                              ))
                        ],
                      ),
                    ),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'welcome back',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: BrandColors.colorText),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        'Create your\npersonal\ncabinet',
                        style: TextStyle(
                            letterSpacing: 1.5,
                            fontSize: 59.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
            Text(
              'Social network',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                color: BrandColors.colorText,
              ),
            )
          ],
        ),
      ),
    );
  }
}
