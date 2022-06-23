import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                Colors.blue.shade600,
                Colors.blue.shade300,
              ],
                  begin: FractionalOffset.bottomCenter,
                  end: FractionalOffset.topCenter)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
              child: Padding(
            padding: EdgeInsets.symmetric(vertical: 34, horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Image.network(
                    "http://10.46.1.25:80/ap/public/user/default.jpg",
                    fit: BoxFit.fitWidth,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white,
                    ),
                    child: Stack(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.5,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Dhimas Panji Sastra",
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    color: Colors.black,
                                    fontSize: 24),
                              ),
                              Text(
                                "waraga@gmail.com",
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              Text(
                                "Banyuwangi",
                                style: TextStyle(
                                    fontFamily:
                                        GoogleFonts.poppins().fontFamily,
                                    color: Colors.black,
                                    fontSize: 20),
                              ),
                              Center(
                                child: IconButton(
                                    onPressed: () {},
                                    icon: Icon(
                                      Icons.settings,
                                      size: 50,
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          )),
        )
      ],
    );
  }
}
