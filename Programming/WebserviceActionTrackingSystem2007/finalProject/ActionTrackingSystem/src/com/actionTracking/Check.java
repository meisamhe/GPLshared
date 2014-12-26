package com.actionTracking;

import java.awt.List;

//import java.text.DateFormat;
//import java.text.SimpleDateFormat;
//import java.util.Date;


public class Check {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		Date d = new Date();
//		DateFormat dateFormat = new SimpleDateFormat("yyyyMMdd");
//		java.util.Date date = new java.util.Date();
//		System.out.println("Current Date Time : " + dateFormat.format(date));
		long l=13860623;
		try{
		String s=Long.toString(l);
		String temp=s.subSequence(0, 4)+"/"+
		s.subSequence(4, 6)+"/"+
		s.subSequence(6, 8);
		System.out.print(s);
		MainService m=new MainService();
		System.out.println("Start");
//		Activity a=m.uncompleted("manager", 13860923, "m.hejazinia");
//		System.out.print(a);
//		System.out.println("start");
//		String s1=a.getName();
//		System.out.print(s1);
//		System.out.print(new String(s1.getBytes("windows-1256"), "utf8"));
//		String s1="”·«„";
//		String s2="«‰Ã«„ «„Ê—";
//		System.out.print(s1);
//		List list=new List();
//		list.add("fstart");
//		System.out.println(list.getItem(0));

	//	Person[] p=m.getPersonel("manager");
	//	java.util.List personList= java.util.Arrays.asList(p);
	//	System.out.print(personList.size());
	//    String s3 = new String(s1.getBytes("UTF8"), "windows-1256");

//		EmployeeAffairs emp=new EmployeeAffairs("root", "123456", "localhost", "3306","actionTracking");
//		System.out.print(emp.replaceEmployee("snake", "ahamad", "babaiyan", "a.babaiyan",
//				"12346"));
//		System.out.print(emp.defineEmployee("ali", "akbari", "a.akbari"
//				, "1234", "organization", "Tehran"));
		reportGenerator r=new reportGenerator("root", "123456", "localhost", "3306","actionTracking");
		ActivityHandler activity=new ActivityHandler("root", "123456", "localhost", "3306",	"actionTracking");
		
	//	System.out.print(activity.changeResourceQuantityOfOrganization("laptop", "ardabil", 2));
//		System.out.print(r.getPersonel("employee")[1].getName());
//		System.out.println(m.defineActivity(s1,s2,3,				
//				13860623,13860604,13860624, "a.pashanj",
//				"meisam", "hejazinia","manager"));
		s="1386\06\25";
		System.out.print(s.indexOf('_'));
		System.out.print('\'');
	//	System.out.print(emp.changePassowrd("m.hejazinia", "manager", "123456"));
	//	System.out.print(s.substring(s.indexOf('\\'),s.lastIndexOf('\\')));
		String name;
		byte[] b=new byte[33];
	//	System.in.read(b);
		name=new String(b);
	//	System.out.print("activityName is"+activity.getActivityName(35));
		System.out.print(m.getSubsidaryPersonel("employee", "m.hejazinia"));
//		System.out.print(name);
//		System.out.print("finish");
		//System.out.print(m.viewReportOfActivity("g.heidari", "employee",35)[0].getTitle());

//		System.out.print(name);
//		s.replace("\\", "_");
//		System.out.print(s);
		
	//	System.out.print(s.substring(8,10));
//		System.out.print(activity.defineActivity("HP", "employee","do the job", new Long(0),new Long(13860725), new Long(13860724), 
//				new Long(13860623), new Long(2), new Long(3),new Long(1)));
	//	System.out.print(m.uncompletedActivityUntilDateOfsubsidary(99999999, "m.hejazinia")[0].getActivityId());
		}catch(Exception e){
			e.printStackTrace();
			System.out.print(e);
		}


	}

}
