package lab3;

import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.TimeUnit;

public class Broker {

    private ArrayBlockingQueue<Student> q;
    private Boolean keepProducing;

    public Broker(){
        q = new ArrayBlockingQueue<Student>(Constants.qSize);
        keepProducing = true;
    }

    public void put(Student student) throws InterruptedException {
        q.put(student);
    }

    public Student get() throws InterruptedException {
        return q.poll(1, TimeUnit.SECONDS);
    }

    public Student peek() throws InterruptedException {
        return q.peek();
    }

    public ArrayBlockingQueue<Student> getQ() {
        return q;
    }

    public void setState(Boolean newState) {
        keepProducing = newState;
    }

    public Boolean getState() {
        return keepProducing;
    }
}
