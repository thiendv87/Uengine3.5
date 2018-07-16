package org.uengine.scheduler;

import javax.servlet.GenericServlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;

import java.io.IOException;
import java.text.ParseException;

import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.impl.StdSchedulerFactory;

public class JobScheduler extends GenericServlet{
	
	public void init()throws ServletException{ 
		try{
			schedulerRestart();
		} catch (Exception e){
			e.printStackTrace();
		}
	}
	
	public void schedulerShutDown() {

		Scheduler sched = null;
		try {
			sched = StdSchedulerFactory.getDefaultScheduler();
			sched.shutdown();
		} catch (SchedulerException e1) {

			e1.printStackTrace();
		}
	}
	
	public void schedulerRestart() {

		StdSchedulerFactory ssf = null;
		Scheduler sched = null;
		
    	try {
    		ssf = new StdSchedulerFactory();
			sched = ssf.getScheduler();
			sched.start();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
		
		try {
			JobDetail jd = new JobDetail("waitJob", "groupJob", WaitJob.class);
			CronTrigger cronTrigger = new CronTrigger("waitTrigger", "groupTrigger");
			cronTrigger.setCronExpression("0 * * * * ?");
			
			sched.scheduleJob(jd, cronTrigger);
		} catch (ParseException e) {
			e.printStackTrace();
		} catch (SchedulerException e) {
			e.printStackTrace();
		}
	}

	@Override
	public void service(ServletRequest arg0, ServletResponse arg1)
			throws ServletException, IOException {
	}
}
