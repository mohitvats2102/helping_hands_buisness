import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  static const String privacyPolicy = '/privacy_policy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
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
                  'Information we collect',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'The Platform seeks to provide the customers with information '
                  'details of prospective nearest Helpers/Workers located in '
                  'the vicinity of Customer’s Search location. For the afore '
                  'mentioned to be possible, it is essential for the Platform'
                  ' to collect and use certain information from the Customers. '
                  'The Platform may collect Personal Identification information '
                  'as well as non-personal identification information from the Customers.'
                  'The personal identification information includes, but it not '
                  'limited to, your email address, name, telephone number,'
                  ' access to your location, your contacts & your album folder'
                  ' and other appropriate details that would help the Platformin '
                  'ensuring you get connected with the nearest Helpers/Workers '
                  'around your search locality and avail all the services being '
                  'offered by the Platform, and also in verifying your Identity, '
                  'to make sure someone else doesn’t use the platform in your identity. '
                  'This information is collected by the Platform only if they '
                  'are submitted by the Customers & allowed access to by the '
                  'Customers. The objective behind collecting your personal '
                  'information is to provide the services you are seeking and '
                  'to perform various site related activities with greater '
                  'convenience and efficiency when you place an order. '
                  'The Platform may collect personal identification information '
                  'in order to register Customers on the Platform, keep a record '
                  'of the services sought by the Customers and for performing other'
                  ' website related activities which helps the platform in serving '
                  'you better. Due to the nature of services provided by the app, '
                  'the Platform may disclose your personal information to third '
                  'parties, with your explicit consent, in order to provide you '
                  'with the best information for which you accessed the Platform’s services.'
                  'The Platform may also disclose information in response to a '
                  'court order or government request, or when it would be '
                  'reasonably necessary to disclose the said information to '
                  'protect the rights of the Platform, third parties, or the '
                  'public at large. The Platform May disclose information to '
                  'comply with legal process, to enforce their Terms of Use, '
                  'to protect their Operations and rights, privacy and safety '
                  'of the properties and to pursue any available legal remedies',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 40),
                Text(
                  'Changes in Information or Untrue Information',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'You are responsible for maintaining the accuracy of the '
                  'information you submit to us, such as your contact '
                  'information provided as part of account registration. '
                  'If your personal information changes, you may correct, '
                  'delete inaccuracies, or amend information by making the '
                  'change on our information page or by contacting us through '
                  '"helpinghandofudaipur@gmail.com". We will make good faith '
                  'efforts to make requested changes in our then active databases. '
                  'If you provide any information that is untrue, inaccurate, '
                  'out of date or incomplete (or becomes untrue, inaccurate, '
                  'out of date or incomplete), or the Platform has reasonable '
                  'grounds to suspect that the information provided by you is '
                  'untrue, inaccurate, out of date or incomplete, the Platform '
                  'may, at its sole discretion, discontinue the provision of '
                  'the Services to you',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
                SizedBox(height: 40),
                Text(
                  'Changes to this Privacy Policy',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'This Privacy Policy is current as of the effective date set '
                  'forth above. The Platform Has the discretion to make '
                  'amendments in the privacy policy as it may deem fit, '
                  'without any prior notice. The Customers will be sent an '
                  'email in order to notify them for the changes being made. '
                  'Continued use of the app, even after the changes made, '
                  'shall constitute your acceptance of the change. '
                  'Therefore, the Platform encourages to review this '
                  'Privacy Policy frequently and stay aware of changes',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
