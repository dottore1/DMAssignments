package dk.sdu.mmmi.dm.healthos.persistance;

import dk.sdu.mmmi.dm.healthos.domain.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @author Oliver Nordestgaard | olnor18
 */
public class PersistanceHandler implements IPersistanceHandler {
    private static PersistanceHandler instance;
    private String url = "localhost";
    private int port = 5432;
    private String databaseName = "dm6";
    private String username = "postgres";
    private String password = "Vjy26dxn";
    private Connection connection = null;

    private PersistanceHandler() {
        initializePostgresqlDatabase();
    }

    public static PersistanceHandler getInstance() {
        if (instance == null) {
            instance = new PersistanceHandler();
        }
        return instance;
    }

    private void initializePostgresqlDatabase() {
        try {
            DriverManager.registerDriver(new org.postgresql.Driver());
            connection = DriverManager.getConnection("jdbc:postgresql://" + url + ":" + port + "/" + databaseName, username, password);
        } catch (SQLException | IllegalArgumentException ex) {
            ex.printStackTrace(System.err);
        } finally {
            if (connection == null) System.exit(-1);
        }
    }

    @Override
    public List<Employee> getEmployees() {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM employees");
            ResultSet sqlReturnValues = stmt.executeQuery();
            int rowcount = 0;
            List<Employee> returnValue = new ArrayList<>();
            while (sqlReturnValues.next()) {
                returnValue.add(new Employee(sqlReturnValues.getInt(1), sqlReturnValues.getString(2), sqlReturnValues.getInt(3), sqlReturnValues.getInt(4), sqlReturnValues.getInt(5), sqlReturnValues.getInt(6)));
            }
            return returnValue;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    @Override
    public Employee getEmployee(int id) {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM employees WHERE id = ?");
            stmt.setInt(1, id);
            ResultSet sqlReturnValues = stmt.executeQuery();
            if (!sqlReturnValues.next()) {
                return null;
            }
            return new Employee(sqlReturnValues.getInt(1), sqlReturnValues.getString(2), sqlReturnValues.getInt(3), sqlReturnValues.getInt(4), sqlReturnValues.getInt(5), sqlReturnValues.getInt(6));
        } catch (SQLException ex) {
            ex.printStackTrace();
            return null;
        }
    }

    /*
    Implement all of the following. Beware that the model classes are as of yet not properly implemented
    */

    @Override
    public boolean createEmployee(Employee employee) {
        try {
            PreparedStatement stmt = connection.prepareStatement(
                    "INSERT into employees(name, phone, position_id, department_id, room_id) " +
                            "values(?,?,?,?,?)"
            );
            stmt.setString(1, employee.getName());
            stmt.setInt(2, employee.getPhone());
            stmt.setInt(3, employee.getPosition_id());
            stmt.setInt(4, employee.getDepartment_id());
            stmt.setInt(5, employee.getRoom_id());
            stmt.execute();
            return true;


        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Patient> getPatients() {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM patients");
            ResultSet rs = stmt.executeQuery();
            List<Patient> patients = new ArrayList<>();
            while (rs.next()) {
                patients.add(new Patient(
                        rs.getInt(1),
                        rs.getString(2),
                        rs.getString(4),
                        rs.getString(3)
                ));
            }
            return patients;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

    @Override
    public Patient getPatient(int id) {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM patients WHERE id = ?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if(!rs.next()){
                return null;
            } else{
                return new Patient(rs.getInt(1), rs.getString(2), rs.getString(4), rs.getString(3));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean createPatient(Patient patient) {
        try {
            PreparedStatement stmt = connection.prepareStatement(
                    "INSERT into patients(name, phone, cpr_number) " +
                            "values(?,?,?)"
            );
            stmt.setString(1, patient.getName());
            stmt.setString(2, patient.getPhone());
            stmt.setString(3, patient.getCpr_number());
            stmt.execute();
            return true;


        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Bed> getBeds() {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM beds");
            ResultSet rs = stmt.executeQuery();
            List<Bed> beds = new ArrayList<>();
            while (rs.next()) {
                beds.add(new Bed(
                        rs.getInt(1),
                        rs.getString(2)
                ));
            }
            return beds;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }

    }

    @Override
    public Bed getBed(int id) {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM beds WHERE id = ?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if(!rs.next()){
                return null;
            } else{
                return new Bed(rs.getInt(1), rs.getString(2));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean createBed(Bed bed) {
        //make HealthOS support this action in the presentation layer too.
        try {
            PreparedStatement stmt = connection.prepareStatement(
                    "INSERT into beds(bed_number) " +
                            "values(?)"
            );
            stmt.setString(1, bed.getBed_number());
            stmt.execute();
            return true;


        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public List<Admission> getAdmissions() {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM admissions");
            ResultSet rs = stmt.executeQuery();
            List<Admission> admissions = new ArrayList<>();
            while (rs.next()) {
                admissions.add(new Admission(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4), rs.getInt(5)));
            }
            return admissions;
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public Admission getAdmission(int id) {
        try {
            PreparedStatement stmt = connection.prepareStatement("SELECT * FROM admissions WHERE id = ?");
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if(!rs.next()){
                return null;
            } else{
                return new Admission(rs.getInt(1), rs.getInt(2), rs.getInt(3), rs.getInt(4),rs.getInt(5));
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }

    @Override
    public boolean createAdmission(Admission admission) {
        try {
            PreparedStatement stmt = connection.prepareStatement(
                    "INSERT into admissions(patient_id, room_id, bed_id, assigned_employee_id) " +
                            "values(?,?,?,?)"
            );
            stmt.setInt(1, admission.getPatient_id());
            stmt.setInt(2, admission.getRoom_id());
            stmt.setInt(3, admission.getBed_id());
            stmt.setInt(4, admission.getAssaigned_employee_id());
            stmt.execute();
            return true;


        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    public boolean deleteAdmission(int id) {
        try {
            PreparedStatement stmt = connection.prepareStatement("DELETE FROM admissions WHERE id = ?");
            stmt.setInt(1, id);
            stmt.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

}
