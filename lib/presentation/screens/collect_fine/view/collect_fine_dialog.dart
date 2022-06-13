import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/data/models/fine_details_response.dart';
import 'package:lms1/data/models/user_detail_response.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/collect_fine/collect_fine.dart';

class CollectFineDialog extends StatefulWidget {
  final FineDataModel fineDataModel;
  final List<FineHistoryModel> fineHistory;

  const CollectFineDialog(
      {super.key, required this.fineDataModel, required this.fineHistory});

  @override
  State<CollectFineDialog> createState() => _CollectFineDialogState();
}

class _CollectFineDialogState extends State<CollectFineDialog> {
  final _formKey = GlobalKey<FormState>();
  List<FineHistoryModel> _selectedBooks = [];
  late TextEditingController _amountController;
  late TextEditingController _purposeController;
  late TextEditingController _emailController;
  late TextEditingController _payingForController;

  @override
  void initState() {
    super.initState();
    _amountController = TextEditingController(text: '0');
    _purposeController = TextEditingController();
    _emailController = TextEditingController(text: widget.fineDataModel.email);
    _payingForController = TextEditingController();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _purposeController.dispose();
    _emailController.dispose();
    _payingForController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Collect Fine')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                RichText(
                    text: TextSpan(
                  text: "Total fine for ",
                  style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      decoration: TextDecoration.none),
                  children: [
                    TextSpan(
                        text: _emailController.text,
                        style: GoogleFonts.lato(color: Colors.blue)),
                    const TextSpan(text: " is "),
                    TextSpan(
                        text: "$rupeeSymbol${widget.fineDataModel.fine}",
                        style: GoogleFonts.lato(color: Colors.red)),
                  ],
                )),
                const SizedBox(height: 100),
                _emailField(),
                const SizedBox(height: 20),
                _amountField(),
                const SizedBox(height: 20),
                _purposeField(),
                const SizedBox(height: 20),
                _showDropDown(),
                const SizedBox(height: 170),
                _collectButton(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _emailField() => CustomTextField(
        controller: _emailController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the email";
          } else {
            return null;
          }
        },
        readOnly: true,
        prefixIcon: null,
        hintText: 'Enter Email',
        labelText: 'User Email',
        inputType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _amountField() => CustomTextField(
        controller: _amountController,
        validator: (value) {
          if (value == null || value.isEmpty || int.parse(value) == 0) {
            return "Please enter the amount";
          } else {
            return null;
          }
        },
        readOnly: true,
        prefixIcon: const Icon(Icons.currency_rupee),
        hintText: 'Enter Amount',
        labelText: 'Amount',
        inputFormators: [FilteringTextInputFormatter.digitsOnly],
        inputType: const TextInputType.numberWithOptions(
            decimal: false, signed: false),
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _purposeField() => CustomTextField(
        controller: _purposeController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the purpose";
          } else {
            return null;
          }
        },
        prefixIcon: null,
        hintText: 'Enter purpose for the fine',
        labelText: 'Purpose',
        inputType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _showMultiSelect(List<FineHistoryModel> books) async {
    final result = await showDialog(
      context: context,
      builder: (_) {
        return MultiSelectFineDialog(
            fineHistory: books, previouslySelected: _selectedBooks);
      },
    );

    if (result != null) {
      setState(() {
        _selectedBooks = result;
        _payingForController.text = _selectedBooks.isNotEmpty
            ? "${_selectedBooks.length} Books selected"
            : '';
        _calculateFine();
      });
    }
  }

  _calculateFine() {
    int sum = 0;
    for (var book in _selectedBooks) {
      sum += book.fine;
    }
    setState(() {
      _amountController.text = sum.toString();
    });
  }

  _showDropDown() => TextField(
        controller: _payingForController,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          labelText: "Paying For",
          hintText: "Select Books",
          contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        ),
        readOnly: true,
        onTap: () {
          _showMultiSelect(widget.fineHistory);
        },
      );

  _collectButton() => CustomButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            BlocProvider.of<CollectFineBloc>(context).add(CollectFineClicked(
              _emailController.text,
              _selectedBooks.map((book) => book.bookId).toList(),
              _amountController.text,
              _purposeController.text,
            ));
            Navigator.pop(context);
          }
        },
        lable: 'Collect',
        color: Colors.blue,
        textColor: Colors.white,
        context: context,
      );
}

class MultiSelectFineDialog extends StatefulWidget {
  final List<FineHistoryModel> fineHistory;
  final List<FineHistoryModel> previouslySelected;
  const MultiSelectFineDialog({
    Key? key,
    required this.fineHistory,
    required this.previouslySelected,
  }) : super(key: key);

  @override
  State<MultiSelectFineDialog> createState() => _MultiSelectFineDialogState();
}

class _MultiSelectFineDialogState extends State<MultiSelectFineDialog> {
  final List<FineHistoryModel> _selectedBooks = [];

  @override
  void initState() {
    super.initState();
    _selectedBooks.addAll(widget.previouslySelected);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      elevation: 1,
      title: const Text('Select Books'),
      content: SizedBox(
        height: 400,
        width: MediaQuery.of(context).size.width * .75,
        child: (widget.fineHistory.isNotEmpty)
            ? ListView.builder(
                itemCount: widget.fineHistory.length,
                itemBuilder: (context, index) {
                  return CheckboxListTile(
                    value: _selectedBooks.contains(widget.fineHistory[index]),
                    title: Text(widget.fineHistory[index].toString()),
                    onChanged: (isChecked) =>
                        _bookChanged(widget.fineHistory[index], isChecked!),
                  );
                },
              )
            : const Center(
                child: Text('No Books Available'),
              ),
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: _cancel,
        ),
        ElevatedButton(
          child: const Text('Submit'),
          onPressed: _submit,
        ),
      ],
    );
  }

  _bookChanged(FineHistoryModel fineHistoryModel, bool isSelected) {
    setState(() {
      isSelected
          ? _selectedBooks.add(fineHistoryModel)
          : _selectedBooks.remove(fineHistoryModel);
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedBooks);
  }
}
