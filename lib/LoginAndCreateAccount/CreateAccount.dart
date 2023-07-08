import 'package:flutter/material.dart';

import 'CreateAccountModel.dart';

class CreateAccount extends StatefulWidget {
  // const CreateAccount({super.key});
final CreateAccountModel? createAccountModel;
 CreateAccount({this.createAccountModel});
  @override
  State<CreateAccount> createState() => _CreateAccountState();
}
class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a new account"),
    
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(8 ,20  ,8  ,8),
        child:widget.createAccountModel==null?SignUp():SignUp(createAccountModel: widget.createAccountModel,),
      ),
    );
  }
}
class SignUp extends StatefulWidget {
  //const SignUp({super.key});
CreateAccountModel?createAccountModel;
SignUp({this.createAccountModel});
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey  = GlobalKey<FormState>();
  final _passKey = GlobalKey<FormFieldState>();
  int _id=0;
   String _name = '';
  String _email = '';
  int userType = 0;
 String _userType = '';

  String _password = '';
  bool _termChecked = true;
  String url ='http://192.168.20.38:8080/api/posts';
   List<DropdownMenuItem<int>>userList=[];
   void loadUserList(){
    userList=[];
    userList.add(
      const DropdownMenuItem(child: Text('admin'),value: 0,),
    );
    userList.add(
      const DropdownMenuItem(child: Text('customer'),value: 1,),
    );
    userList.add(
      const DropdownMenuItem(child: Text('supplier'),value: 2,),
    );
   }
   @override
  void initState() {
    if(widget.createAccountModel!= null){
      _id = widget.createAccountModel!.id!;
      _name = widget.createAccountModel!.name.toString();
      _email = widget.createAccountModel!.email.toString();
      _password = widget.createAccountModel!.password.toString();
      _userType = widget.createAccountModel!.userType.toString();
    }
  }
  @override
  Widget build(BuildContext context) {
    loadUserList();
    return Form(
child: ListView(
  children:getFormWidget(),
  
),
    );
  }
  List<Widget> getFormWidget(){
    List<Widget> formWidget = [];
    formWidget.add(TextFormField(
initialValue: _name,
decoration: const InputDecoration(
  labelText: 'Enter your name',hintText: 'Name'),
  validator:(value){
if(value!.isEmpty){
  return 'Please enter your name';
}else{
  return null;
}
  },
   onChanged: (value) {
      _name = value.toString();
      },
    )
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
    formWidget.add(TextFormField(
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
    ),);

  return formWidget; }
}