import 'dart:convert';

import 'package:e_commerce_site/product_purchase/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Update extends StatefulWidget {
  final PurchaseModel? pModel;
  Update({this.pModel});
  @override
  State<Update> createState() => UpdateState();
}

class UpdateState extends State<Update> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration Form"),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: SignUpForm(pModel:widget.pModel,),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  // const SignUpForm({super.key});
  final PurchaseModel? pModel;
  SignUpForm({this.pModel});
  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();
  
  int _id = 0;
// If(){}
@override
void initState() {
    // TODO: implement initState
    _id= widget.pModel!.id!;
    _name = widget.pModel!.title.toString();
   _password = widget.pModel!.body.toString();

  }
  String _name = '';
  String _email = '';
  int _age = -1;
  String _maritalStatus = '';
  int _selectedGender = 0;
  String _password = '';
  bool _termChecked = true;
  String url = 'http://192.168.20.38:8080/api/posts';

  List<DropdownMenuItem<int>> genderList = [];
  void loadGenderList() {
    genderList = [];
    genderList.add(const DropdownMenuItem(
      child: Text('Male'),
      value: 0,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Female'),
      value: 1,
    ));
    genderList.add(const DropdownMenuItem(
      child: Text('Others'),
      value: 2,
    ));
  }

  @override
  Widget build(BuildContext context) {
    loadGenderList();
    return Form(
        child: ListView(
      children: getFormWidget(),
    ));
  }

  List<Widget> getFormWidget() {
    List<Widget> formWidget = [];

    formWidget.add(
      TextFormField(
        initialValue: _name,
        decoration:
            const InputDecoration(labelText: 'Enter Name', hintText: 'Name'),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter a name';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          _name = value.toString();
        },
        // onSaved: (value) {
        //   setState(() {
        //     _name = value.toString();
        //   });
        // },
      ),
    );

    validateEmail(String? value) {
      if (value!.isEmpty) {
        return 'Please enter an email';
      }

      Pattern pattern =
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regex = RegExp(pattern.toString());
      if (!regex.hasMatch(value.toString())) {
        return 'Enter Valid Email';
      } else {
        return null;
      }
    }

    formWidget.add(
      TextFormField(
        decoration:
            const InputDecoration(labelText: 'Enter Email', hintText: 'Email'),
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
        onChanged: (value) {
          _email = value.toString();
        },
        // onSaved: (value) {
        //   setState(() {
        //     _email = value.toString();
        //   });
        // },
      ),
    );

    formWidget.add(TextFormField(
      decoration:
          const InputDecoration(hintText: 'Age', labelText: 'Enter Age'),
      keyboardType: TextInputType.number,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter age';
        } else {
          return null;
        }
      },
      onChanged: (value) {
        _age = int.parse(value.toString());
      },
      // onSaved: (value) {
      //   setState(() {
      //     _age = int.parse(value.toString());
      //   });
      // },
    ));

    formWidget.add(DropdownButton(
      hint: const Text('Select Gender'),
      items: genderList,
      value: _selectedGender,
      onChanged: (value) {
        setState(() {
          _selectedGender = int.parse(value.toString());
        });
      },
      isExpanded: true,
    ));

    formWidget.add(Column(
      children: <Widget>[
        RadioListTile<String>(
          title: const Text('Single'),
          value: 'single',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
        RadioListTile<String>(
          title: const Text('Married'),
          value: 'married',
          groupValue: _maritalStatus,
          onChanged: (value) {
            setState(() {
              _maritalStatus = value.toString();
            });
          },
        ),
      ],
    ));

    formWidget.add(
      TextFormField(
          key: _passKey,
          obscureText: true,
          decoration: const InputDecoration(
              hintText: 'Password', labelText: 'Enter Password'),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Please Enter password';
            } else if (value.length < 8) {
              return 'Password should be more than 8 characters';
            } else {
              return null;
            }
          }),
    );

    formWidget.add(
      TextFormField(
        obscureText: true,
        decoration: const InputDecoration(
            hintText: 'Confirm Password', labelText: 'Enter Confirm Password'),
        validator: (confirmPassword) {
          if (confirmPassword != null && confirmPassword.isEmpty) {
            return 'Enter confirm password';
          }
          var password = _passKey.currentState?.value;
          if (confirmPassword != null &&
              confirmPassword.compareTo(password) != 0) {
            return 'Password mismatch';
          } else {
            return null;
          }
        },
        onChanged: (value) {
          _password = value.toString();
        },
        // onSaved: (value) {
        //   setState(() {
        //     _password = value.toString();
        //   });
        // }
      ),
    );

    formWidget.add(CheckboxListTile(
      value: _termChecked,
      onChanged: (value) {
        setState(() {
          _termChecked = value.toString().toLowerCase() == 'true';
        });
      },
      subtitle: !_termChecked
          ? const Text(
              'Required',
              style: TextStyle(color: Colors.red, fontSize: 12.0),
            )
          : null,
      title: const Text(
        'I agree to the terms and condition',
      ),
      controlAffinity: ListTileControlAffinity.leading,
    ));

    Future<void> onPressedSubmit() async {
      // if (_formKey.currentState!.validate() && _termsChecked) {
      //   _formKey.currentState?.save();

      // Product product = new Product();

      // product.name = _name;
      // product.email = _email;
      // product.price = _age.toString();
      // product.quantity = _password;

      // (await ProductApiService().createProduct(product));
      // print("Delete Call!");

      print("Name " + _name);
      print("Email " + _email);
      print("Age " + _age.toString());

      switch (_selectedGender) {
        case 0:
          print("Gender Male");
          break;
        case 1:
          print("Gender Female");
          break;
        case 3:
          print("Gender Others");
          break;
      }
      print("Marital Status " + _maritalStatus);
      print("Password " + _password);
      print("Termschecked " + _termChecked.toString());
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Form Submitted')));

      // Navigator.pushAndRemoveUntil<dynamic>(context,
      //   MaterialPageRoute<dynamic>(
      //     builder: (BuildContext context) =>Home(),
      //   ),
      //       (route) =>false,
      // );
      // }
      final String login = 'http://192.168.20.46:8080/api/posts';
      var reqBody = {"title": _email, "body": _name};
      var response = await http.post(Uri.parse(login),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(reqBody));
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['status']) {
        print('Data Submitted');
      } else {
        print('something went wrong!');
      }
    }

    formWidget.add(ElevatedButton(
        child: const Text('Sign Up'), onPressed: onPressedSubmit));

    formWidget.add(ElevatedButton(
        child: const Text('Home'),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(context, "/p3", (route) => false);
        }));

    return formWidget;
  }
}
