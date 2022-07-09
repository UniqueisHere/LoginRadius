import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:loginradius_example/core/api_client.dart';

class HomeScreen extends StatefulWidget {
  final String accesstoken;
  const HomeScreen({Key? key, required this.accesstoken}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ApiClient _apiClient = ApiClient();

  //get user data from ApiClient
  Future<Map<String, dynamic>> getUserData() async {
    dynamic userRes;
    userRes = await _apiClient.getUserProfileData(widget.accesstoken);
    return userRes.data;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: FutureBuilder<Map<String, dynamic>>(
          future: getUserData(), //<---
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  height: size.height,
                  width: size.width,
                  color: Colors.blueGrey,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
              //get results from snapshot
              String fullName = snapshot.data!['FullName'];
              String firstName = snapshot.data!['FirstName'];
              String lastName = snapshot.data!['LastName'];
              String birthDate = snapshot.data!['BirthDate'];
              String email = snapshot.data!['Email'][0]['Value'];
              String gender = snapshot.data!['Gender'];
              return Container(
                width: size.width,
                height: size.height,
                color: Colors.blueGrey.shade400,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(fullName),
                      SizedBox(
                        height: 10,
                      ),
                      Text(firstName),
                      SizedBox(
                        height: 10,
                      ),
                      Text(lastName),
                      SizedBox(
                        height: 10,
                      ),
                      Text(birthDate),
                      SizedBox(
                        height: 10,
                      ),
                      Text(email),
                      SizedBox(
                        height: 10,
                      ),
                      Text(gender),
                      SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
