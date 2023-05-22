import 'package:email_validator/email_validator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:labexam210970/custom_textfield.dart';
import 'package:labexam210970/our_button.dart';
import 'package:velocity_x/velocity_x.dart';

class Regis extends StatefulWidget {
  const Regis({super.key});

  @override
  State<Regis> createState() => _RegisState();
}

class _RegisState extends State<Regis> {
  bool? isCheck = false;
  bool? isMale = false;
  bool? isFemale = false;
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purpleAccent,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            60.heightBox,
            "Registration to Employee".text.white.size(22).make(),
            10.heightBox,
            Column(
              children: [
                customTextField(
                    hint: "xyz",
                    title: "Name",
                    controller: nameController,
                    isPass: false,
                    isEmail: false),
                customTextField(
                    hint: "xyz@gmail.com",
                    title: "Email",
                    controller: emailController,
                    isPass: false,
                    isEmail: true),
                customTextField(
                    hint: "*********",
                    title: "Password",
                    controller: passwordController,
                    isPass: true,
                    isEmail: false),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Checkbox(
                        checkColor: Colors.red,
                        value: isMale,
                        onChanged: (newValue) {
                          setState(() {
                            isMale = newValue;
                            isFemale = false;
                            isCheck = true;
                          });
                        }),
                    "Male".text.make(),
                    Checkbox(
                        checkColor: Colors.red,
                        value: isFemale,
                        onChanged: (newValue) {
                          setState(() {
                            isFemale = newValue;
                            isMale = false;
                            isCheck = true;
                          });
                        }),
                    "Female".text.make(),
                    10.heightBox,
                  ],
                ),
                5.heightBox,
                ourButton(
                  color: isCheck == true ? Colors.black : Colors.grey,
                  title: "Registration",
                  textColor: Colors.white,
                  onPress: () async {
                    if (isCheck! &&
                        EmailValidator.validate(emailController.text) &&
                        !nameController.text.isEmpty &&
                        !emailController.text.isEmpty) {
                      DatabaseReference ref =
                          FirebaseDatabase.instance.ref("employee");

                      await ref.set({
                        "name": nameController.text,
                        "email": emailController.text,
                        "password": passwordController.text,
                        'gender': isFemale == true ? 'female' : 'male',
                      });

                      final snapshot = await ref.child('name').get();
                      if (snapshot.exists) {
                        // ignore: use_build_context_synchronously
                        VxToast.show(context,
                            msg: "Form Submitted by ${snapshot.value}");
                      } else {
                        // ignore: use_build_context_synchronously
                        VxToast.show(context, msg: "Some Error occured");
                      }
                    } else {
                      VxToast.show(context, msg: "Wrong Credentional!");
                    }
                  },
                ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
              ],
            )
                .box
                .color(Colors.grey)
                .rounded
                .padding(const EdgeInsets.all(16))
                .width(context.screenWidth - 50)
                .shadowSm
                .make(),
          ],
        ),
      ),
    );
  }
}
