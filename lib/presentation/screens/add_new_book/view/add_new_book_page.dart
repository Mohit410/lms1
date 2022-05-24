import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lms1/core/utils/utils.dart';
import 'package:lms1/data/models/book_model.dart';
import 'package:lms1/presentation/components/utils/helper.dart';
import 'package:lms1/presentation/components/widgets/widgets.dart';
import 'package:lms1/presentation/screens/add_new_book/bloc/add_new_book_bloc.dart';

class AddNewBookPage extends StatefulWidget {
  static Route route(BookModel? book, PageMode mode) =>
      MaterialPageRoute(builder: (_) => AddNewBookPage(book: book, mode: mode));

  final BookModel? book;
  final PageMode mode;

  const AddNewBookPage({
    Key? key,
    required this.book,
    required this.mode,
  }) : super(key: key);

  @override
  State<AddNewBookPage> createState() => _AddNewBookPageState();
}

class _AddNewBookPageState extends State<AddNewBookPage> {
  final _formKey = GlobalKey<FormState>();

  late AddNewBookBloc _bloc;
  late TextEditingController _idController;
  late TextEditingController _nameController;
  late TextEditingController _titleController;
  late TextEditingController _priceController;
  late TextEditingController _authorController;
  late TextEditingController _copiesController;
  late TextEditingController _publisherController;
  late String _category;

  @override
  void initState() {
    _bloc = BlocProvider.of<AddNewBookBloc>(context);
    _idController = TextEditingController(text: widget.book?.bookId);
    _nameController = TextEditingController(text: widget.book?.name);
    _titleController = TextEditingController(text: widget.book?.title);
    _priceController =
        TextEditingController(text: widget.book?.price.toString());
    _authorController = TextEditingController(text: widget.book?.author);
    _copiesController =
        TextEditingController(text: widget.book?.copies.toString());
    _publisherController = TextEditingController(text: widget.book?.publisher);
    _category = widget.book?.category ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.mode == PageMode.addNew ? 'Add New Book' : 'Edit Book Details',
          style: GoogleFonts.pacifico(),
        ),
        foregroundColor: Colors.black87,
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: _buildBody(context),
    );
  }

  _buildBody(BuildContext buildContext) {
    return BlocConsumer<AddNewBookBloc, AddNewBookState>(
      listener: (context, state) {
        if (state is AddNewBookSuccess) {
          showSnackbar(state.message, buildContext);
          Navigator.pop(buildContext, "refresh");
        }
        if (state is AddNewBookFailed) {
          showSnackbar(state.message, buildContext);
        }
      },
      builder: (context, state) {
        if (state is AddNewBookLoading) {
          return const Center(child: LoadingWidget());
        }
        return SingleChildScrollView(
            padding: const EdgeInsets.all(36.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    _idField(),
                    const SizedBox(height: 20),
                    _titleField(),
                    const SizedBox(height: 20),
                    _nameField(),
                    const SizedBox(height: 20),
                    _publisherField(),
                    const SizedBox(height: 20),
                    _authorField(),
                    const SizedBox(height: 20),
                    _copiesField(),
                    const SizedBox(height: 20),
                    _categoryDropDown(),
                    const SizedBox(height: 20),
                    _priceField(),
                    const SizedBox(height: 35),
                    (widget.mode == PageMode.addNew)
                        ? _addButton()
                        : _updateButton(),
                    const SizedBox(height: 15),
                  ],
                ),
              ),
            ));
      },
    );
  }

  _nameField() => CustomTextField(
        controller: _nameController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the name";
          } else {
            return null;
          }
        },
        readOnly: widget.mode == PageMode.edit,
        prefixIcon: null,
        hintText: 'Enter Name',
        labelText: 'Name',
        inputType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _idField() => CustomTextField(
        controller: _idController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the book id";
          } else {
            return null;
          }
        },
        readOnly: widget.mode == PageMode.edit,
        prefixIcon: null,
        hintText: 'Enter Book Id',
        labelText: 'Book Id',
        inputType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _titleField() => CustomTextField(
        controller: _titleController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the title";
          } else {
            return null;
          }
        },
        readOnly: widget.mode == PageMode.edit,
        prefixIcon: null,
        hintText: 'Enter Book Title',
        labelText: 'Book Title',
        inputType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _priceField() => CustomTextField(
        controller: _priceController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the price";
          } else {
            return null;
          }
        },
        readOnly: widget.mode == PageMode.edit,
        prefixIcon: const Icon(Icons.currency_rupee),
        hintText: 'Enter Book Price',
        labelText: 'Book Price',
        inputFormators: [FilteringTextInputFormatter.digitsOnly],
        inputType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _authorField() => CustomTextField(
        controller: _authorController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the author name";
          } else {
            return null;
          }
        },
        readOnly: widget.mode == PageMode.edit,
        prefixIcon: null,
        hintText: 'Enter Author Name',
        labelText: 'Author',
        inputType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _publisherField() => CustomTextField(
        controller: _publisherController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the publisher's name";
          } else {
            return null;
          }
        },
        readOnly: widget.mode == PageMode.edit,
        prefixIcon: null,
        hintText: "Enter Publisher's Name",
        labelText: 'Publisher',
        inputType: TextInputType.name,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _copiesField() => CustomTextField(
        controller: _copiesController,
        validator: (value) {
          if (value != null && value.isEmpty) {
            return "Please enter the no of copies";
          } else {
            return null;
          }
        },
        inputFormators: [FilteringTextInputFormatter.digitsOnly],
        prefixIcon: null,
        hintText: 'Enter No of Copies',
        labelText: 'Copies',
        inputType: TextInputType.number,
        autovalidateMode: AutovalidateMode.onUserInteraction,
      );

  _categoryDropDown() => CustomDropDownFormField(
        itemList: [
          BookCategory.education.lable,
          BookCategory.music.lable,
          BookCategory.sport.lable,
        ],
        onItemChanged: _onCategoryChanged,
        enabled: widget.mode == PageMode.addNew,
        currentValue: _category == '' ? null : _category,
        hint: 'Select A Category',
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please select a category";
          }
          return null;
        },
      );

  _onCategoryChanged(String cate) {
    setState(() => _category = cate);
  }

  _addButton() => CustomButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final book = AddNewBookModel(
              id: _idController.text,
              title: _titleController.text,
              name: _nameController.text,
              publisher: _publisherController.text,
              author: _authorController.text,
              totalCopies: _copiesController.text,
              category: _category,
              price: _priceController.text,
            );

            _bloc.add(AddNewBookClicked(book));
          }
        },
        lable: 'Add',
        context: context,
        color: Colors.green.shade700,
        textColor: Colors.white,
      );

  _updateButton() => CustomButton(
        onPressed: () {
          if (_formKey.currentState!.validate()) {
            final book = widget.book?.copyWith(
              copies: int.parse(_copiesController.text),
            );

            _bloc.add(UpdateBookClicked(book!));
          }
        },
        lable: 'Update',
        context: context,
        color: Colors.green.shade700,
        textColor: Colors.white,
      );
}
