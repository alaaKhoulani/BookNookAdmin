/**
 *  List<String> recent = [
    "Harry Poter",
    "The Smurfs",
    "The Lord of The Ring",
    "The Dark Lord",
    "Flutter Book",
    "The New Way"
  ];
 * List topBook = [
  {
    'photo': 'assets/images/bookphoto1.png',
    'title': 'book1',
    'author': 'author1'
  },
  ]
 */

/**showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Select Year"),
          content: Container( // Need to use container to add size constraint.
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 100, 1),
              lastDate: DateTime(DateTime.now().year + 100, 1),
              initialDate: DateTime.now(),
              // save the selected date to _selectedDate DateTime variable.
              // It's used to set the previous selected date when
              // re-showing the dialog.
              selectedDate: _selectedDate,
              onChanged: (DateTime dateTime) {
                // close the dialog when year is selected.
                Navigator.pop(context);

                // Do something with the dateTime selected.
                // Remember that you need to use dateTime.year to get the year
              },
            ),
          ),
        );
      },
    ); */