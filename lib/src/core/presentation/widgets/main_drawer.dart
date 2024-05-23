import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:credit_card_validator/src/features/card_validation/presentation/cubit/credit_card_cubit.dart';

import '../../../features/card_validation/presentation/widgets/widgets.dart';
import '../../../injection_container.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GestureDetector(
        onHorizontalDragEnd: (_) {},
        child: Container(
          color: Colors.transparent,
          child: Row(
            children: [
              SizedBox(
                width: 304,
                child: Column(
                  children: [
                    Expanded(
                      child: Drawer(
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: <Widget>[
                            BlocProvider(
                              create: (_) => CreditCardCubit(
                                saveCreditCard: sl(),
                              ),
                              child: const CreditCardForm(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
