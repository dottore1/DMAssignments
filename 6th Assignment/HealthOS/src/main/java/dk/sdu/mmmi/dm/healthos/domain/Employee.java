package dk.sdu.mmmi.dm.healthos.domain;

/**
 *
 * @author Oliver Nordestgaard | olnor18
 */
public class Employee {
    private int id;
    private String name;
    private int phone;
    private int position_id;
    private int department_id;
    private int room_id;

    public Employee(String name, int phone, int position_id, int department_id, int room_id) {
        this.name = name;
        this.phone = phone;
        this.position_id = position_id;
        this.department_id = department_id;
        this.room_id = room_id;
    }

    public Employee(int id, String name, int phone, int position_id, int department_id, int room_id) {
        this.id = id;
        this.name = name;
        this.phone = phone;
        this.position_id = position_id;
        this.department_id = department_id;
        this.room_id = room_id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public int getPhone() {
        return phone;
    }

    public int getPosition_id() {
        return position_id;
    }

    public int getDepartment_id() {
        return department_id;
    }

    public int getRoom_id() {
        return room_id;
    }

    @Override
    public String toString() {
        return "Employee{" + "id=" + id + ", name=" + name + ", phone=" + phone + ", position_id=" + position_id + ", department_id=" + department_id + ", room_id=" + room_id + '}';
    }
    
    
}
