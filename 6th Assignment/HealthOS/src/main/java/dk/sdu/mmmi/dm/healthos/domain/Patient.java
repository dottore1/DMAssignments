package dk.sdu.mmmi.dm.healthos.domain;

/**
 *
 * @author Oliver Nordestgaard | olnor18
 */
public class Patient {
    private int id;
    private String name;
    private String phone;
    private String cpr_number;

    public  Patient(String name, String phone, String cpr_number){
        this.name = name;
        this.phone = phone;
        this.cpr_number = cpr_number;

    }

    public  Patient(int id, String name, String phone, String cpr_number){
        this.name = name;
        this.phone = phone;
        this.cpr_number = cpr_number;
        this.id = id;

    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getPhone() {
        return phone;
    }

    public String getCpr_number() {
        return cpr_number;
    }


    @Override
    public String toString() {
        return "Patient{ id=" + getId() + " name=" + getName()+ " phone=" + getPhone() + " cpr=" + getCpr_number()+ '}';
    }
}
