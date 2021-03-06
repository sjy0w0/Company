package company.model.util;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.Query;

import company.model.Employee;
import company.model.Manager;
import company.model.Signin;

public class ManagedEmployeeBean {
	public static void  createNewEmployee(Integer managerId, Employee employee){
	    EntityManager em = JPAResourceBean.getEMF().createEntityManager();
	    try{
	        em.getTransaction().begin();
	        em.persist(employee);
	        ManagedManagerBean.addEmployee(managerId, employee);
	        em.getTransaction().commit();
	    }finally{
	        em.close();
	    }
	}
	
	public static Employee getById(Integer employeeId){
	    EntityManager em = JPAResourceBean.getEMF().createEntityManager();
	    try{
	        return em.find(Employee.class, employeeId);
	    }finally{
	        em.close();
	    }
	}
	
	public static String getManagerName(Integer employeeId){
	    EntityManager em = JPAResourceBean.getEMF().createEntityManager();
	    try{
	        return em.find(Employee.class, employeeId).getManager().getName();
	    }finally{
	        em.close();
	    }
	}
	
	public static void  removeById(Integer employeeId){
	    EntityManager em = JPAResourceBean.getEMF().createEntityManager();
	    try{
	        em.getTransaction().begin();
	        Employee employee = em.find(Employee.class, employeeId);
	        Manager manager = employee.getManager();
	        manager.getEmployees().remove(employee);
	        em.remove(employee);
	        em.getTransaction().commit();
	    }finally{
	        em.close();
	    }
	}
	public static void updateFull(Integer employeeId, String name,Integer birthday, String email, String gender, String phone){
	    EntityManager em = JPAResourceBean.getEMF().createEntityManager();
	    try{
	        em.getTransaction().begin();
	        Employee employee = em.find(Employee.class, employeeId);
	        employee.setName(name);
	        employee.setBirthday(birthday);
	        employee.setEmail(email);
	        employee.setGender(gender);
	        employee.setPhone(phone);
	        em.getTransaction().commit();
	    }finally{
	        em.close();
	    }
	}
	
	public static void addSignin(Integer employeeId, Signin signin){
	    EntityManager em = JPAResourceBean.getEMF().createEntityManager();
	    try{
	        em.getTransaction().begin();
	        Employee employee = em.find(Employee.class, employeeId);
	        employee.getSignins().add(signin);
	        em.getTransaction().commit();
	    }finally{
	        em.close();
	    }
	}
	
	@SuppressWarnings("unchecked")
	public static List<Employee> getAllEmployees(){
	    EntityManager em = JPAResourceBean.getEMF().createEntityManager();
	    em.getTransaction().begin();
	    Query query=em.createQuery("select o from Employee o");
	    
	    return (List<Employee>) query.getResultList();
	}
}
