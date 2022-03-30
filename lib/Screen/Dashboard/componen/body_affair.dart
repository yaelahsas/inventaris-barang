import 'package:flutter/material.dart';
import 'package:inventaris_barang/constants.dart';

class BodyAffair extends StatelessWidget {
  const BodyAffair({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: size.width,
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 50),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: Column(
        children: [
          Container(
            height: size.height * 0.2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: kPrimaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                  child: Text('Looks like '),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.purple,
                    padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                    textStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {},
                  child: Text('Looks like '),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
                child: Text('Looks like '),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple,
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  textStyle:
                      TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                onPressed: () {},
                child: Text('Looks like '),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
