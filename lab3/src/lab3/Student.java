package lab3;

public class Student {

    private Integer labsAmount;
    private String subject;
    private Integer number;

    Student(Integer number) {
        this.number = number;
        this.subject = Constants.subjects[(int) (Math.random() * 3)];
        this.labsAmount = Constants.labSizes[(int) (Math.random() * 3)];
    }

    public String getSubject() {
        return subject;
    }

    public Integer getLabs() {
        return labsAmount;
    }

    public Integer getNumber() {
        return number;
    }

    public void changeLabsAmount(Integer delta) {
        this.labsAmount = labsAmount + delta;
    }

    @Override
    public String toString() {
        StringBuilder sb = new StringBuilder();
        sb.append("Student number ").append(this.number).append(" with ");
        sb.append(this.labsAmount).append(" ").append(this.subject).append(" labs");
        return sb.toString();
    }
}
