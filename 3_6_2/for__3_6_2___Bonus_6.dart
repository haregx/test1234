void main() {
  Author authorErnestHemingway = Author(name: 'Ernest Hemingway', birthYear: 1899);
  Book bookTheManAndTheSee = Book(title: 'Der alte Mann und das Meer', pages: 127, author: authorErnestHemingway);

  print('Title: ${bookTheManAndTheSee.title}, Seiten: ${bookTheManAndTheSee.pages}, Autor: ${bookTheManAndTheSee.author.name} (geb. ${bookTheManAndTheSee.author.birthYear})');
}

class Author {
  String name;
  int birthYear;
  Author({required this.name, required this.birthYear});
}

class Book {
  String title;
  int pages;
  Author author;
  Book({required this.title, required this.pages, required this.author});
}




