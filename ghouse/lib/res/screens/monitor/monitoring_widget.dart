import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MonitoringWidget extends StatelessWidget {
  final String title;
  final String value;
  final String status;
  final String mark;
  final IconData icon;
  final Widget statu;
  const MonitoringWidget({
    Key key,
    @required this.title,
    @required this.value,
    this.mark,
    @required this.icon,
    @required this.status,
    this.statu,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 100,
      // width: 120,
      decoration: BoxDecoration(
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 0),
              spreadRadius: -2,
              blurRadius: 23)
        ],
        borderRadius: BorderRadius.circular(10),
      ),
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        onPressed: null,
        child: Row(
          children: [
            SizedBox(
              width: 15,
            ),
            FaIcon(icon, size: 40, color: Colors.grey[600]),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Text(
                    title,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.italic),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        value,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            fontStyle: FontStyle.italic),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        mark,
                        style: TextStyle(
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
                Spacer(),
                statu
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.end,
                //   children: [
                //     Container(
                //       margin: EdgeInsets.all(10),
                //       padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                //       decoration: BoxDecoration(
                //         color: Colors.green,
                //         borderRadius: BorderRadius.circular(7),
                //       ),
                //       child: Text(
                //         status,
                //         style: TextStyle(color: Colors.white),
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

Widget goodState = Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        'good',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    )
  ],
);

Widget badState = Row(
  mainAxisAlignment: MainAxisAlignment.end,
  children: [
    Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        'bad',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    )
  ],
);
