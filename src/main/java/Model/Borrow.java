package Model;

public class Borrow {
    public String id;
    public String book_id;
    public String user_id;
    public String status;
    public String created_at;
    public String username;
    public String book_name;

    public Borrow(String id, String book_id, String user_id, String status, String created_at) {
        this.id = id;
        this.book_id = book_id;
        this.user_id = user_id;
        this.status = status;
        this.created_at = created_at;
    }

    public Borrow(String id, String book_id, String user_id, String status, String created_at, String username, String book_name) {
        this.id = id;
        this.book_id = book_id;
        this.user_id = user_id;
        this.status = status;
        this.created_at = created_at;
        this.username = username;
        this.book_name = book_name;
    }

    public Borrow(String book_id, String user_id, String status, String created_at, String username, String book_name) {
        this.book_id = book_id;
        this.user_id = user_id;
        this.status = status;
        this.created_at = created_at;
        this.username = username;
        this.book_name = book_name;
    }

    public String getUsername() {
        return username;
    }

    public String getBook_name() {
        return book_name;
    }

    public String getId() {
        return id;
    }

    public String getBook_id() {
        return book_id;
    }

    public String getUser_id() {
        return user_id;
    }

    public String getStatus() {
        return status;
    }

    public String getCreated_at() {
        return created_at;
    }
}
