void main() {
  Author authorErnestHemingway = Author('Ernest Hemingway', 1899);
  Book bookTheManAndTheSee = Book('Der alte Mann und das Meer', 127, authorErnestHemingway );

  print('Title: ${bookTheManAndTheSee.title}, Seiten: ${bookTheManAndTheSee.pages}, Autor: ${bookTheManAndTheSee.author.name} (geb. ${bookTheManAndTheSee.author.birthYear})');
}

class Author {
  String name;
  int birthYear;
  Author(this.name, this.birthYear);
}

class Book {
  String title;
  int pages;
  Author author;
  Book(this.title, this.pages, this.author);
}




