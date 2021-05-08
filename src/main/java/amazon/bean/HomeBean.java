package amazon.bean;

import com.jsmartframework.web.util.WebText;
import com.jsmartframework.web.manager.WebContext;
import com.jsmartframework.web.annotation.WebBean;

import amazon.service.SpringService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;

@WebBean
public class HomeBean {

    @Autowired
    private SpringService springService;

    public void updateClockTime(String clockTime) {
		if (!StringUtils.isBlank(clockTime)) {
			WebContext.addSuccess("feedback", WebText.getString("texts", "async.archetype.clock.updated", clockTime));
		} else {
			WebContext.addWarning("feedback", WebText.getString("texts", "async.archetype.clock.error"));
		}
    }

}
