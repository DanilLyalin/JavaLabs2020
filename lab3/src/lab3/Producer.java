package lab3;

public class Producer implements Runnable {

    private Broker broker;

    public Producer(Broker broker){
        this.broker = broker;
    }

    @Override
    public void run() {
        try {
            for(int i = 1; i <= Constants.studentsTotal; i++) {
                Student student = new Student(i);
                broker.put(student);
                System.out.println("New student joined the queue: " + student);
            }
            broker.setState(false);
            System.out.println("Finished producing students");
        }catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}
