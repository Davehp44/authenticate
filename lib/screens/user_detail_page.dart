// ignore_for_file: sort_child_properties_last

import 'package:authenticate/model/user.dart';
import 'package:authenticate/res/string_values.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatefulWidget {
  const UserDetailPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return UserDetailPageState();
  }
}

class UserDetailPageState extends State<UserDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Consumer<UserState>(
            builder: (context, userState, _) => SafeArea(
                    child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.only(bottom: 50.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: const <Widget>[
                          SizedBox(height: 50),
                          CircleAvatar(
                            radius: 100,
                            backgroundImage:
                                AssetImage('images/none_avatar.webp'),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                          color: Colors.grey,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 30.0, left: 30.0, right: 30.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Name:   ',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: userState.user?.name ?? '',
                                    style: const TextStyle(fontSize: 20.0))
                              ])),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10.0, left: 30.0, right: 30.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: 'User:   ',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: userState.user?.user ?? '',
                                    style: const TextStyle(fontSize: 20.0))
                              ])),
                            ),
                            Container(
                              margin: const EdgeInsets.only(
                                  top: 10.0, left: 30.0, right: 30.0),
                              child: RichText(
                                  text: TextSpan(children: [
                                const TextSpan(
                                    text: 'Email:   ',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: userState.user?.email ?? '',
                                    style: const TextStyle(fontSize: 20.0))
                              ])),
                            ),
                            Expanded(
                              child: Container(),
                              flex: 1,
                            ),
                            Container(
                              margin: const EdgeInsets.all(20.0),
                              alignment: Alignment.center,
                              child: ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: MaterialStatePropertyAll(
                                        Colors.blueGrey)),
                                onPressed: () {
                                  userState.logOut(context);
                                },
                                child: const Text(logout),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
