import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  static const String aboutUs = '/about_us';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(),
                CircleAvatar(
                  radius: 90,
                  backgroundImage: AssetImage('assets/images/abtus2.PNG'),
                ),
                SizedBox(height: 20),
                Text(
                  'Helping Hands is a New Gen recognised startup.',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Helping Hands enables millions of underprivileged and '
                  'unorganized blue-collar workforce in finding local employment, free of cost, '
                  'directly from nearby employers, and without the middlemen in between.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'In turn, the platform makes it easy, quick, reliable & affordable for millions '
                  'of employers to find & hire nearby blue-collar workers, again without the middlemen in between.'
                  'With a larger vision to end poverty, forced labour, worker\'s exploitation, and human trafficking, '
                  'Helping Hands is working towards creating an ecosystem of inclusive economic '
                  'growth for India\'s underprivileged unorganised blue-collar workforce.'
                  'The platform helps in establishing Employer-Worker connections in a '
                  'fairly organised way. At a local level, it allows both men & women '
                  'workers to connect directly with the nearby Employers.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 20),
                Text(
                  'In the long run, having enough local employment opportunities '
                  'allows workers to find a better working environment and '
                  'better salaries for themselves and an opportunity to '
                  'improve their quality of life.',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 40),
                Text(
                  'Contact Us',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'E-mail :',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: Text(
                        'helpinghandofudaipur@gmail.com',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Text(
                  'Developer Contact',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'E-mail : ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        'mohitvatsktl@gmail.com',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Contact : ',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '9660223279',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
