package lab3;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;

public class Main {

    public static void main(String[] args) {
        try
        {
            Broker broker = new Broker();

            ExecutorService threadPool = Executors.newFixedThreadPool(4);

            threadPool.execute(new Consumer(Constants.subjects[0], broker));
            threadPool.execute(new Consumer(Constants.subjects[1], broker));
            threadPool.execute(new Consumer(Constants.subjects[2], broker));
            Future producerStatus = threadPool.submit(new Producer(broker));

            // this will wait for the producer to finish its execution.
            producerStatus.get();
            threadPool.shutdown();
        }
        catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}
