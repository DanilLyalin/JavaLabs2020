package lab3;

public class Consumer implements Runnable {

    private String subject;
    private Broker broker;

    public Consumer(String subject, Broker broker){
        this.broker = broker;
        this.subject = subject;
    }

    @Override
    public void run() {
        try{
            while(true) {
                Student student;
                synchronized (broker) {
                    if (!broker.getState() && broker.getQ().size() == 0) break;
                    else student = broker.peek();
                    if (student != null) {
                        if (student.getSubject().equals(subject)) {
                            student = broker.get();
                            broker.notifyAll();
                        } else {
                            broker.wait();
                        }
                    }
                    else
                        continue;
                }
                if(student.getSubject().equals(subject)) {
                    while (student.getLabs() > 0) {
                        System.out.println(subject + " robot is grading " + student);
                        student.changeLabsAmount(-5);
                        Thread.sleep(Constants.timeUnit);
                    }
                    System.out.println(subject + " robot finished grading " + student.getNumber());
                }
            }
        }catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}