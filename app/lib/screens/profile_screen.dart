import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app/models/user_model.dart';
import 'package:app/screens/edit_profile_screen.dart';
import 'package:app/utilities/constants.dart';
import 'package:app/services/auth_service.dart';

class ProfileScreen extends StatefulWidget {
  final String userId;

  ProfileScreen({this.userId});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: usersRef.document(widget.userId).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          User user = User.fromDoc(snapshot.data);

          return ListView(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    CircleAvatar(
                      radius: 70.0,
                      backgroundColor: Colors.grey,
                      backgroundImage: user.profileImageUrl.isEmpty
                          ? AssetImage('assets/images/user_placeholder.jpg')
                          : CachedNetworkImageProvider(user.profileImageUrl),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      user.name,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      height: 80.0,
                      child: Text(
                        user.bio,
                        style: TextStyle(fontSize: 14.0, color: Colors.black,),
                      ),
                    ),
                      Container(
                            width: 150.0,
                            child: FlatButton(
                              onPressed: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditProfileScreen(
                                    user: user,
                                  ),
                                ),
                              ),
                              color: Colors.black,
                              textColor: Colors.white,
                              child: Text(
                                'Edit Profile',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                      ),
                      Container(
                            width: 150.0,
                            child: FlatButton(
                              onPressed: () => AuthService.logout(),
                              color: Colors.black,
                              textColor: Colors.white,
                              child: Text(
                                'Log Out',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
