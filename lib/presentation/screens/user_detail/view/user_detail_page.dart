import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/models.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/loading_widget.dart';
import 'package:lms1/presentation/screens/register/register.dart';
import 'package:lms1/presentation/screens/update_password/update_password.dart';
import 'package:lms1/presentation/screens/user_detail/bloc/user_detail_bloc.dart';
import 'package:lms1/presentation/screens/user_detail/view/components/fine_history.dart';
import 'package:lms1/presentation/screens/user_detail/view/components/issued_book_card.dart';
import 'package:lms1/presentation/screens/user_detail/view/components/transaction_card.dart';

class UserDetailPage extends StatefulWidget {
  static Route route(String email, String role) => MaterialPageRoute(
      builder: (_) => UserDetailPage(email: email, role: role));

  final String email;
  final String role;
  const UserDetailPage({Key? key, required this.email, required this.role})
      : super(key: key);

  @override
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
  late UserDetailBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<UserDetailBloc>(context);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _bloc.add(FetchData(email: widget.email, role: widget.role));
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User Details',
          style: GoogleFonts.pacifico(),
        ),
        elevation: 1,
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
      ),
      body: SafeArea(child: buildBody()),
    );
  }

  buildBody() {
    return BlocConsumer<UserDetailBloc, UserDetailState>(
      listener: (context, state) {},
      builder: (context, state) {
        return RefreshIndicator(
          onRefresh: () async {
            _bloc.add(FetchData(email: widget.email, role: widget.role));
          },
          child: Center(
            child: Stack(
              children: [
                SingleChildScrollView(
                  clipBehavior: Clip.antiAlias,
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
                  child: refreshIndicatorChild(state),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget refreshIndicatorChild(state) {
    if (state is Loaded) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          headingText('Name'),
          const SizedBox(height: 8),
          fieldText(state.user.name),
          const SizedBox(height: 16),
          headingText('Email'),
          const SizedBox(height: 8),
          fieldText(state.user.email),
          const SizedBox(height: 16),
          headingText('Phone'),
          const SizedBox(height: 8),
          fieldText(state.user.phone),
          const SizedBox(height: 16),
          headingText('Address'),
          const SizedBox(height: 8),
          fieldText(state.user.address),
          const SizedBox(height: 16),
          headingText('City'),
          const SizedBox(height: 8),
          fieldText(state.user.city),
          const SizedBox(height: 16),
          headingText('State'),
          const SizedBox(height: 8),
          fieldText(state.user.state),
          const SizedBox(height: 16),
          headingText('Pincode'),
          const SizedBox(height: 8),
          fieldText(state.user.pincode),
          (widget.role == Role.student.name)
              ? issuedBooksList(state.issuedBooks)
              : Container(),
          (widget.role == Role.student.name)
              ? fineHistoryList(state.fineHistory)
              : Container(),
          (widget.role == Role.student.name)
              ? transactionsList(state.transactions)
              : Container(),
          const SizedBox(height: 12),
          const Divider(height: 2),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomButtons(state.user),
          ),
          const SizedBox(height: 24),
        ],
      );
    } else if (state is Loading) {
      return const LoadingWidget();
    } else if (state is Failed) {
      return Column(
        children: [
          Center(child: Text(state.message)),
        ],
      );
    } else {
      return Column(
        children: const [
          Center(child: Text('No data')),
        ],
      );
    }
  }

  bottomButtons(UserModel user) => Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                onEditClicked(user);
              },
              child: const Text("Edit"),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                onChangePasswordClicked(user.email, user.role);
              },
              child: const Text("Change Password"),
            ),
          ),
        ],
      );

  onEditClicked(UserModel user) {
    Navigator.of(context)
        .push(RegisterPage.route(user, PageMode.edit))
        .then((value) {
      _bloc.add(FetchData(email: widget.email, role: widget.role));
    });
  }

  onChangePasswordClicked(String email, String role) {
    Navigator.of(context).push(UpdatePasswordPage.route(email, role));
  }

  issuedBooksList(List issuedBooks) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Divider(height: 2),
          const SizedBox(height: 12),
          Text(
            'Books Issued',
            style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          const SizedBox(height: 10),
          (issuedBooks.isNotEmpty)
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: issuedBooks.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) => IssuedBookCard(
                    book: issuedBooks[index],
                  ),
                )
              : const Text('No Data Available'),
        ],
      );

  fineHistoryList(List fines) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Divider(height: 2),
          const SizedBox(height: 12),
          Text(
            'Fine History',
            style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          const SizedBox(height: 10),
          (fines.isNotEmpty)
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: fines.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) => FineHistoryCard(
                    fine: fines[index],
                  ),
                )
              : const Text('No Data Available'),
        ],
      );

  transactionsList(List transactions) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          const Divider(height: 2),
          const SizedBox(height: 12),
          Text(
            'Transactions',
            style: GoogleFonts.lato(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent),
          ),
          const SizedBox(height: 10),
          (transactions.isNotEmpty)
              ? ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: transactions.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) => TransactionCard(
                    transaction: transactions[index],
                  ),
                )
              : const Text('No Data Available'),
        ],
      );
}
