import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app/controller/auth_controller.dart';
import 'package:note_app/controller/theme_controller.dart';

class Setting_Screen extends StatelessWidget {
  Setting_Screen({super.key});
  final themeController = Get.put(ThemeController());
  final authController = Get.find<AuthController>();

  final lstTile = [
    {'label': 'Profile', 'Icon': Icons.person},
    {'label': 'Language', 'Icon': Icons.translate},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        print('User ${authController.firestoreUser.value?.name}');
        return Scaffold(
            appBar: AppBar(
              title: const Text('Setting'),
              actions: [
                IconButton(
                    onPressed: () {
                      themeController.changeTheme();
                    },
                    icon: Icon(themeController.isDark.value
                        ? Icons.light_mode
                        : Icons.dark_mode))
              ],
            ),
            body: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: NetworkImage(
                            "https://images.ctfassets.net/lh3zuq09vnm2/yBDals8aU8RWtb0xLnPkI/19b391bda8f43e16e64d40b55561e5cd/How_tracking_user_behavior_on_your_website_can_improve_customer_experience.png"),
                      ),
                      SizedBox(
                        width: 24,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            authController.firestoreUser.value?.name
                                    .toString() ??
                                "No Name",
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 20),
                          ),
                          Text(
                            authController.user.value?.email.toString() ??
                                'No Email',
                            style: TextStyle(
                                fontWeight: FontWeight.normal, fontSize: 14),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: lstTile.length,
                        itemBuilder: (context, index) {
                          final items = lstTile[index];
                          return GestureDetector(
                            onTap: () {
                              print('tap $index');
                            },
                            child: ListTile(
                              leading: Icon(items['Icon'] as IconData),
                              title: Text(items['label'] as String),
                              trailing: Icon(
                                Icons.arrow_forward_ios_rounded,
                                size: 18,
                              ),
                            ),
                          );
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                authController.signOut();
                              },
                              icon: Icon(Icons.logout),
                              label: Text('Logout'),
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }
}
