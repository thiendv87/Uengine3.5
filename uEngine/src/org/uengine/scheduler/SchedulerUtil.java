package org.uengine.scheduler;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;

import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerFactory;
import org.quartz.impl.StdSchedulerFactory;

public class SchedulerUtil {
	
	public static Calendar getCalendarByCronExpression(String cronExpression) throws Exception {
		SchedulerFactory sf = new StdSchedulerFactory();
		Scheduler sched = sf.getScheduler();
		
		JobDetail jd = sched.getJobDetail("tempJobDetail", "tempGroupJobDetail");
		if (jd != null) {
			sched.unscheduleJob("tempJobDetail", "tempGroupJobDetail");
			sched.deleteJob("tempJobDetail" , "tempGroupJobDetail");
		}
		
		CronTrigger cronTrigger = new CronTrigger("tempCronTrigger", "tempGroupTrigger");
		cronTrigger.setCronExpression(cronExpression);
		
		Date firstRunTime = (Date) sched.scheduleJob(new JobDetail("tempJobDetail", "tempGroupJobDetail", TempJob.class), cronTrigger);
		Calendar c = new GregorianCalendar();
		c.setTime(firstRunTime);
		c.set(Calendar.MILLISECOND, 0);
		
		sched.unscheduleJob("tempJobDetail", "tempGroupJobDetail");
		sched.deleteJob("tempJobDetail" , "tempGroupJobDetail");
		
		return c;
	}
}
