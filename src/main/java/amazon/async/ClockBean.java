package amazon.async;

import com.jsmartframework.web.annotation.AsyncBean;
import com.jsmartframework.web.listener.WebAsyncListener;
import com.jsmartframework.web.manager.WebContext;

import javax.servlet.AsyncContext;
import javax.servlet.ServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;

import amazon.service.SpringService;
import org.springframework.beans.factory.annotation.Autowired;

@AsyncBean("/home/clock")
public class ClockBean implements WebAsyncListener {

    @Autowired
    private SpringService springService;

    private volatile boolean finished = false;

    @Override
    public void asyncContextCreated(final AsyncContext asyncContext) {
        asyncContext.setTimeout(300000);
        asyncContext.start(new Runnable() {

            @Override
            public void run() {
                try {
                    while (!finished) {
                        WebContext.writeResponseAsEventStream(asyncContext, "clock-event", new Date());
                        Thread.sleep(1000);
                    }
                } catch (IOException | InterruptedException e) {
                    asyncContext.complete();
                    e.printStackTrace();
                }
            }
        });
    }

    @Override
    public void asyncContextDestroyed(AsyncContext asyncContext, Reason reason) {
        if (reason == Reason.TIMEOUT) {
            asyncContext.complete();
        }
        finished = true;
    }

}