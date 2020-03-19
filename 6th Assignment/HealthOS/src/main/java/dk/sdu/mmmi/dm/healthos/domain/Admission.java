package dk.sdu.mmmi.dm.healthos.domain;

/**
 *
 * @author Oliver Nordestgaard | olnor18
 */
public class Admission {

    private int id;
    private int patient_id;
    private int room_id;
    private int bed_id;
    private int assaigned_employee_id;

    public Admission(int id, int patient_id, int room_id, int bed_id, int assaigned_employee_id){
        this.id = id;
        this.patient_id = patient_id;
        this.room_id = room_id;
        this.bed_id = bed_id;
        this.assaigned_employee_id = assaigned_employee_id;
    }


    public Admission( int patient_id, int room_id, int bed_id, int assaigned_employee_id){
        this.patient_id = patient_id;
        this.room_id = room_id;
        this.bed_id = bed_id;
        this.assaigned_employee_id = assaigned_employee_id;
    }

    public int getId() {
        return id;
    }

    public int getPatient_id() {
        return patient_id;
    }

    public int getRoom_id() {
        return room_id;
    }

    public int getBed_id() {
        return bed_id;
    }

    public int getAssaigned_employee_id() {
        return assaigned_employee_id;
    }


    @Override
    public String toString() {
        return "Admission {" + "ID=" + getId() + "Patient_id=" + getPatient_id() + " Room_id=" + getRoom_id() + " Bed_id=" + getBed_id() + " Assaigned_employee=" + getAssaigned_employee_id();
    }
}
