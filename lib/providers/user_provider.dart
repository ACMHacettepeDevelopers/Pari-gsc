import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import '../models/user.dart';

final userProvider = StateProvider<UserClass?>((ref) => UserClass(uid: FirebaseAuth.instance.currentUser!.uid));
ProviderContainer container = ProviderContainer();
