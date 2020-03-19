package dk.sdu.mmmi.dm.healthos.presentation;

import dk.sdu.mmmi.dm.healthos.domain.*;
import dk.sdu.mmmi.dm.healthos.persistance.PersistanceHandler;

import javax.print.DocFlavor;
import java.awt.*;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

/**
 *
 * @author Oliver Nordestgaard | olnor18
 */
public class Main {
    public static void main(String[] args) {
        System.out.println(
            "------------------------------------------\n"
            + "WELCOME TO HealthOS\n"
            + "Please input your command or type \"help\"\n"
            + "------------------------------------------\n"
        );
        boolean running = true;
        IPersistanceHandler persistanceHandler = PersistanceHandler.getInstance();
        try(Scanner s = new Scanner(System.in)){
            while(running) {
                switch(s.nextLine().toLowerCase()) {
                    case "getemployees":
                        System.out.println(persistanceHandler.getEmployees());
                        break;
                    case "getemployee":
                        System.out.println("What is the employee ID?");
                        System.out.println(persistanceHandler.getEmployee(Integer.parseInt(s.nextLine())));
                        break;
                    case "createemployee":
                        System.out.println("Type in a name:");
                        String name = s.nextLine();
                        System.out.println("Type a phone number: ");
                        int phone = Integer.parseInt(s.nextLine());
                        System.out.println("Type a position ID: ");
                        int postion_id = Integer.parseInt(s.nextLine());
                        System.out.println("Type in a Department_Id: ");
                        int depart_id = Integer.parseInt(s.nextLine());
                        System.out.println("Type in room_id: ");
                        int room_id = Integer.parseInt(s.nextLine());
                        System.out.println("Creating Employee...");
                        Employee employee = new Employee(name, phone, postion_id, depart_id, room_id);
                        persistanceHandler.createEmployee(employee);
                        System.out.println("Employee created.");
                        break;

                    case "getpatients":
                        System.out.println(persistanceHandler.getPatients());
                        break;
                    case "getpatient":
                        System.out.println("What is the patient ID?");
                        System.out.println(persistanceHandler.getPatient(Integer.parseInt(s.nextLine())));
                        break;
                    case "createpatient":
                        System.out.println("Type in a name: ");
                        String name1 = s.nextLine();
                        System.out.println("Type in a phone number: ");
                        String phone1 = s.nextLine();
                        System.out.println("Type in your cpr number: xxxxxx-xxxx ");
                        String cpr = s.nextLine();
                        System.out.println("Creating patient...");
                        persistanceHandler.createPatient(new Patient(name1, cpr, phone1));
                        System.out.println("Patient created.");
                        break;
                    case "getbeds":
                        System.out.println(persistanceHandler.getBeds());
                        break;
                    case "getbed":
                        System.out.println("What is the bed ID?");
                        System.out.println(persistanceHandler.getBed(Integer.parseInt(s.nextLine())));
                        break;
                    case "createbed":
                        System.out.println("Type in bed_number");
                        String bed_number = s.nextLine();
                        System.out.println("Creating bed..");
                        persistanceHandler.createBed(new Bed(bed_number));
                        System.out.println("Bed created.");
                    case "getadmissions":
                        System.out.println(persistanceHandler.getAdmissions());
                        break;
                    case "getadmission":
                        System.out.println("What is the admission ID?");
                        System.out.println(persistanceHandler.getAdmission(Integer.parseInt(s.nextLine())));
                        break;
                    case "createadmission":
                        System.out.println("What is the patient id?");
                        int patient_id = Integer.parseInt(s.nextLine());
                        System.out.println("What is the room_id?");
                        int room_id1 = Integer.parseInt(s.nextLine());
                        System.out.println("What is the bed ID?");
                        int bed_id = Integer.parseInt(s.nextLine());
                        System.out.println("What is the assigned_employee ID?");
                        int AEID = Integer.parseInt(s.nextLine());
                        System.out.println("Creating Admission...");
                        persistanceHandler.createAdmission(new Admission(patient_id, room_id1, bed_id, AEID));
                        System.out.println("Admission created");
                        break;
                    case "deleteadmission":
                        System.out.println("What is the admission ID?");
                        System.out.println(persistanceHandler.deleteAdmission(Integer.parseInt(s.nextLine())));
                        System.out.println("Deleted...");
                        break;
                    case "exit":
                        running = false;
                        break;
                    case "help":
                    default:
                        System.out.println(generateHelpString());
                        break;
                }
            }
        }
    }

    private static String generateHelpString() {
        return "Please write one of the following commands:\n"
                + "- getEmployees\n"
                + "- getEmployee\n"
                + "- createEmployee\n"
                + "- getPatients\n"
                + "- getPatient\n"
                + "- createPatient\n"
                + "- getBeds\n"
                + "- getBed\n"
                + "- createBed\n"
                + "- getAdmissions\n"
                + "- getAdmission\n"
                + "- createAdmission\n"
                + "- deleteAdmission\n"
                + "- exit\n";
    }
}
