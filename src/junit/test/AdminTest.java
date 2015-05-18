package junit.test;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.text.DateFormat;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import javax.persistence.Query;

import org.junit.Test;

import company.model.Admin;
import company.model.Employee;
import company.model.Manager;
import company.model.Signin;
import company.model.util.JPAResourceBean;
import company.model.util.ManagedAdminBean;
import company.model.util.ManagedEmployeeBean;
import company.model.util.ManagedManagerBean;
import company.model.util.ManagedSigninBean;

public class AdminTest {
	
	@Test
	public void getDate(){
		Date date = new Date();
		DateFormat df = DateFormat.getDateTimeInstance();
		System.out.print(df.format(date)+"\n");
	}
	
	@Test
	public void initial(){
		addAdmin();
		addManager();
		addEmployee();
		addSignIn();
	}
	//clean up
	@Test
	public void cleanUp() {
		EntityManagerFactory factory=Persistence.createEntityManagerFactory("company");
		EntityManager em=factory.createEntityManager();
	    em.getTransaction().begin();
	    em.createNativeQuery("drop table signin").executeUpdate();
	    em.createNativeQuery("drop table employee").executeUpdate();
	    em.createNativeQuery("drop table manager").executeUpdate();
	    em.createNativeQuery("drop table admin").executeUpdate();
	    em.getTransaction().commit();
	}
	//Functions for admin
	@Test
	public void addAdmin() {
		Admin admin = new Admin();
		admin.setName("sjy");
		admin.setPassword("sjy1125");
		ManagedAdminBean.createNewAdmin(admin);
	}
	
	@Test
	public void getAdminName() {
		Admin admin = ManagedAdminBean.getById(3);
		System.out.print(admin.getName());
	}
	
	@Test
	public void updateAdminName() {
		ManagedAdminBean.update(3, "shao", "sjy1125");
	}
	
	@Test
	public void deleteAdmin() {
		ManagedAdminBean.removeById(2);
	}
	//wrong
	@Test
	public void searchAdminQuery() {
		EntityManagerFactory factory=Persistence.createEntityManagerFactory("company");
		EntityManager em=factory.createEntityManager();
		Query query=em.createQuery("select o from Admin o where o.adminId=?1");
		query.setParameter(1, 11111111);
		Admin admin=(Admin)query.getSingleResult();//List<Admin> admins=query.getResultList()
		System.out.print(admin.getEmail()+"\n");//for(Admin admin:admins)
		em.close();
		factory.close();
	}
	
	//Functions for manager
	@Test
	public void addManager() {
		
		Admin admin = ManagedAdminBean.getById(1);
		
		Manager manager1 = new Manager();
		manager1.setName("Tian");
		manager1.setStatus("YES");
		manager1.setPassword("123456");
		manager1.setAdmin(admin);
		
		ManagedManagerBean.createNewManager(1, manager1);
	}
	
	@Test
	public void getManagerName() {
		String adminName = ManagedManagerBean.getAdminName(1);
		System.out.print(adminName);
	}

	@Test
	public void updateManager() {
		ManagedManagerBean.update(1, "zhang", "zmf1220", "NO");
		
	}
	
	@Test
	public void deleteManager() {
		ManagedManagerBean.removeById(4);
	}
	
	//Employee functions
	@Test
	public void addEmployee() {
		Manager manager = ManagedManagerBean.getById(1);
		
		Employee employee1 = new Employee();
		employee1.setName("Lei");
		employee1.setPassword("123456");
		employee1.setStatus("NULL");
		employee1.setManager(manager);		

		ManagedEmployeeBean.createNewEmployee(1, employee1);
	}
	
	@Test
	public void getEmployeeName() {
		Employee employee = ManagedEmployeeBean.getById(1);
		System.out.print(employee.getPassword());
	}
	
	@Test
	public void deleteEmployee() {
		ManagedEmployeeBean.removeById(2);
	}
	
	@Test
	public void searchEmployee(){
		EntityManager em = JPAResourceBean.getEMF().createEntityManager();
		Manager manager = em.find(Manager.class, 1);
		List<Employee> employees =new ArrayList<Employee>(manager.getEmployees());
		System.out.print(employees.get(1).getName());
		em.close();
		
	}
	//SignIn functions
	@Test
	public void addSignIn() {
		Employee employee = ManagedEmployeeBean.getById(2);
		
		Signin signin1 = new Signin();
		Date date = new Date();
		DateFormat df1 = DateFormat.getDateTimeInstance();	
		DateFormat df2 = DateFormat.getDateInstance();
		signin1.setTime(df1.format(date));
		signin1.setDate(df2.format(date));
		signin1.setStatus("YES");
		signin1.setEmployee(employee);
		
		ManagedSigninBean.createNewSignin(2, signin1);
	}
	
	@Test
	public void searchSignIn() {
		Date date = new Date();
		DateFormat df = DateFormat.getDateInstance();
		Signin signin = ManagedSigninBean.getByIdDate(1, df.format(date),"NO");
		System.out.print(signin.getTime());
	}
	
}
