package dk.sdu.mmmi.dm.healthos.domain;

import java.util.List;

/**
 *
 * @author Oliver Nordestgaard | olnor18
 */
public interface IPersistanceHandler {

    public List<Employee> getEmployees();
    public Employee getEmployee(int id);
    public boolean createEmployee(Employee employee);
    public List<Patient> getPatients();
    public Patient getPatient(int id);
    public boolean createPatient(Patient patient);
    public List<Bed> getBeds();
    public Bed getBed(int id);
    public boolean createBed(Bed bed);
    public List<Admission> getAdmissions();
    public Admission getAdmission(int id);
    public boolean createAdmission(Admission admission);
    public boolean deleteAdmission(int id);
}
