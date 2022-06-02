import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/return_book/return_book.dart';

class ReturnBookPage extends StatefulWidget {
  const ReturnBookPage({Key? key}) : super(key: key);

  @override
  State<ReturnBookPage> createState() => _ReturnBookPageState();
}

class _ReturnBookPageState extends State<ReturnBookPage> {
  final _bookDetailsFormKey = GlobalKey<FormState>();

  late ReturnBookBloc _bloc;
  late TextEditingController _emailController;
  late TextEditingController _bookIdController;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<ReturnBookBloc>(context);
    _emailController = TextEditingController();
    _bookIdController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _bookIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Return Book',
            style: GoogleFonts.pacifico(),
          ),
        ),
        automaticallyImplyLeading: false,
        elevation: 1,
        foregroundColor: AppBarColors.foregroundColor.color,
        backgroundColor: AppBarColors.backgroundColor.color,
      ),
      body: buildBody(context),
    );
  }

  buildBody(BuildContext buildContext) {
    return BlocConsumer<ReturnBookBloc, ReturnBookState>(
      listener: (context, state) {
        if (state is IssuedBookDetailsLoaded) {
          Navigator.push(
            buildContext,
            MaterialPageRoute(
              builder: (_) => ReturnBookDialog(issuedBook: state.issuedBook),
              fullscreenDialog: true,
            ),
          );
        }
        if (state is ReturnBookSuccess) {
          _emailController.clear();
          _bookIdController.clear();
          showSnackbar(state.message, buildContext);
        }
        if (state is ReturnBookFailed) {
          showSnackbar(state.message, buildContext);
        }
      },
      builder: (context, state) {
        if (state is ReturnBookLoading) {
          return const Center(child: LoadingWidget());
        }
        return _getBookDetailsPage();
      },
    );
  }

  _getBookDetailsPage() {
    return Padding(
      padding: const EdgeInsets.all(36.0),
      child: Center(
        child: Form(
          key: _bookDetailsFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              _emailField(),
              const SizedBox(height: 8),
              _bookIdField(),
              const Spacer(),
              _fetchBookDetailsButton(),
            ],
          ),
        ),
      ),
    );
  }

  _emailField() => CustomTextField(
        controller: _emailController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter student's email";
          }
          if (!Validator.isValidEmail(value)) {
            return "Please enter a valid email";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        hintText: "Enter Student's Email",
        inputType: TextInputType.emailAddress,
        labelText: 'Email',
        prefixIcon: const Icon(Icons.email),
      );

  _bookIdField() => CustomTextField(
        controller: _bookIdController,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter book id";
          }
          return null;
        },
        autovalidateMode: AutovalidateMode.onUserInteraction,
        prefixIcon: const Icon(Icons.info),
        hintText: 'Enter book id',
        labelText: "Book Id",
        inputType: TextInputType.number,
        inputFormators: [FilteringTextInputFormatter.digitsOnly],
      );

  _fetchBookDetailsButton() => CustomButton(
        onPressed: () {
          if (_bookDetailsFormKey.currentState!.validate()) {
            _bloc.add(FetchIssuedBookDetails(
                _emailController.text, _bookIdController.text));
          }
        },
        lable: "Submit",
        context: context,
        color: Colors.red,
      );
}
