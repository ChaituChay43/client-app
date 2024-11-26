import 'package:amplify/blocs/auth/auth_bloc.dart';
import 'package:amplify/blocs/auth/auth_event.dart';
import 'package:amplify/blocs/profile/profile_bloc.dart';
import 'package:amplify/blocs/profile/profile_event.dart';
import 'package:amplify/blocs/profile/profile_state.dart';
import 'package:amplify/views/Pages/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends BaseScreen {
  const ProfileScreen({super.key});

  @override
  void initScreen(BuildContext context) {
    super.initScreen(context);
    BlocProvider.of<ProfileBloc>(context).add(FetchProfile());
  }

  @override
  Widget getMobileBody(BuildContext context, BoxConstraints constraints) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (BuildContext context, ProfileState state) {
        if (state is ProfileSuccess) {
          return Align(
            alignment: AlignmentDirectional.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _profileIcon(context),
                  const SizedBox(
                    height: 12,
                  ),
                  _headerName(
                      context, state.profileRes.data?.displayName ?? 'PEPPER POTTS'),
                  Text(
                    state.profileRes.data?.userName ?? '',
                    style: const TextStyle(
                      color: Color(0xFFA08444),
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                ],
              ),
            ),
          );
        } else {
          if (state is ProfileFailed) {
            if (state.httpCode == 401) {
              BlocProvider.of<AuthBloc>(context).add(LoggedOut());
            }
          }
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  _profileIcon(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Theme.of(context).primaryColor,
      radius: 61,
      child: const Icon(Icons.account_circle, size: 120),
    );
  }

  _headerName(BuildContext context, String headerName) {
    return Text(
      headerName,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
    );
  }

  Widget _detailDisplayItem(
      BuildContext context, Widget icon, String detailName, String value) {
    return Container(
      padding: const EdgeInsets.all(4),
      margin: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: ShapeDecoration(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
            ),
            child: SizedBox(
              width: 24,
              height: 24,
              child: SizedBox(width: 14, height: 14, child: icon),
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  detailName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                    height: 0.09,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  value,
                  maxLines: 1,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
