import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/providers/profile_provider.dart';

class ProfilePage extends ConsumerWidget {
  final profileProvider = ChangeNotifierProvider<ProfileProvider>((ref) {
    return ProfileProvider();
  });

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    _updatingProfileListener(ref, context);
    return Scaffold(
      body: Center(
        child: GestureDetector(
            onTap: () {
              ref.read(profileProvider).update();
            },
            child: const Text('Click me')),
      ),
    );
  }

  void _updatingProfileListener(WidgetRef ref, BuildContext context) {
    ref.listen<ProfileProvider>(profileProvider, (previous, latest) {
      print('ProfileProvider: latest ${latest.isUpdating}');
      print('ProfileProvider: previous ${previous?.isUpdating}');
      if (previous?.isUpdating != latest.isUpdating) {
        // Program cannot get into this block
        bool updatingProfile = latest.isUpdating;
        if (updatingProfile) {
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Container(
                    color: Colors.white,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Platform.isAndroid
                            ? const SizedBox(
                                height: 40,
                                width: 40,
                                child: CircularProgressIndicator(),
                              )
                            : const CupertinoActivityIndicator(),
                        const SizedBox(height: 12),
                        const Text('Loading...Please wait')
                      ],
                    ),
                  ),
                );
              });
        } else if (!updatingProfile) {
          Navigator.pop(context);
        }
      }
    });
  }
}
