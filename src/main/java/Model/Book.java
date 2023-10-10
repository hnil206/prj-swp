package Model;

public class Book {
    public String id;
    public String title;
    String description;
    String image;
    String author;
    String genre;
    String quantity;
    boolean available;
    String borrowing;
    public Book(String id, String title, String description, String image, String author, String genre, String quantity, boolean available, String borrowing) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.image = image;
        this.author = author;
        this.genre = genre;
        this.quantity = quantity;
        this.available = available;
        this.borrowing = borrowing;
    }

    public Book(String id, String title, String description, String image, String author, String genre, String quantity, boolean available) {
        this.id = id;
        this.title = title;
        this.description = description;
        this.image = image;
        this.author = author;
        this.genre = genre;
        this.quantity = quantity;
        this.available = available;
    }

    public String getBorrowing() {
        return borrowing;
    }

    
//    public String getBorrowing() {
//        return borrowing;
//    }

    public String getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getImage() {
        return image;
    }

    public String getAuthor() {
        return author;
    }

    public String getGenre() {
        return genre;
    }

    public String getQuantity() {
        return quantity;
    }

    public boolean isAvailable() {
        return available;
    }
}
