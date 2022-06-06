import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/collect_fine/collect_fine.dart';

class CollectFinePage extends StatefulWidget {
  const CollectFinePage({Key? key}) : super(key: key);

  @override
  State<CollectFinePage> createState() => _CollectFinePageState();
}

class _CollectFinePageState extends State<CollectFinePage> {
  final _firstFormKey = GlobalKey<FormState>();
  late CollectFineBloc _bloc;
  late TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<CollectFineBloc>(context);
    _emailController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Collect Fine',
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext buildContext) {
    return BlocConsumer<CollectFineBloc, CollectFineState>(
      listener: (context, state) {
        if (state is FineDetailsLoaded) {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (_) => CollectFineDialog(
                    fineDataModel: state.fineData,
                    fineHistory: state.fineHistory),
                fullscreenDialog: true),
          );
        }
        if (state is CollectFineSuccess) {
          _emailController.clear();
          showSnackbar(state.message, buildContext);
        }

        if (state is CollectFineFailed) {
          showSnackbar(state.message, buildContext);
        }
      },
      builder: (context, state) {
        if (state is CollectFineLoading) {
          return const Center(child: LoadingWidget());
        }
        return Padding(
          padding: const EdgeInsets.all(36.0),
          child: Center(
            child: Form(
              key: _firstFormKey,
              child: Column(
                children: [
                  const Spacer(),
                  CustomTextField(
                    controller: _emailController,
                    validator: (value) {},
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Please enter email',
                    labelText: 'Email',
                    inputType: TextInputType.emailAddress,
                  ),
                  const Spacer(),
                  CustomButton(
                    onPressed: () {
                      if (_firstFormKey.currentState!.validate()) {
                        _bloc.add(FetchFineDetails(_emailController.text));
                      }
                    },
                    lable: 'Submit',
                    color: Colors.red,
                    textColor: Colors.white,
                    context: context,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
