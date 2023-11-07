package Model;

public class Borrow {
    public String id;
    public String book_id;
    public String user_id;
    public String status;
    public String created_at;
    public String username;
    public String book_name;
    public boolean feedback;
    public boolean canFeedback;

    public Borrow() {
    }
    
    

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
    
    //ben tat ca don thue cua user
     public Borrow(String id, String book_id, String user_id, String status, String created_at, String username, String book_name, boolean isfeedback, boolean canFeedback) {
        this.id = id;
        this.book_id = book_id;
        this.user_id = user_id;
        this.status = status;
        this.created_at = created_at;
        this.username = username;
        this.book_name = book_name;
        this.feedback = isfeedback;
        this.canFeedback = canFeedback;
    }

    public boolean isFeedback() {
        return feedback;
    }

    public void setFeedback(boolean feedback) {
        this.feedback = feedback;
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

    public boolean isCanFeedback() {
        return canFeedback;
    }

    public void setCanFeedback(boolean canFeedback) {
        this.canFeedback = canFeedback;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setBook_id(String book_id) {
        this.book_id = book_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setCreated_at(String created_at) {
        this.created_at = created_at;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setBook_name(String book_name) {
        this.book_name = book_name;
    }
    
    
    
}
