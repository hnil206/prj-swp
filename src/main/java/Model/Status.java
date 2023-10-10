package Model;

public enum Status {
    pending(0),
    approved(1),
    decline(-1);
    public final int value;

    Status(int value) {
        this.value = value;
    }

    public int getValue() {
        return value;
    }
    /*public int getValueBy(String status){
        int stt = Integer.parseInt(status);
        return
    }*/
}
