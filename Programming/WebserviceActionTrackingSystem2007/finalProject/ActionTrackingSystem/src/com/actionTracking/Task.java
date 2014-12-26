package com.actionTracking;
import java.io.Serializable;

public class Task implements Serializable {
    /**
     * The id of the task
     */
    private int taskID = 0;

    /**
     * Owner name of the task
     */
    private String ownerName;

    /**
     * public default non-argument constructor
     *  
     */
    public Task() {

    }

    /**
     * Constructor of the Task class
     * 
     * @param taskID
     *            id of the task
     * @param ownerName
     *            owner name of the task
     */
    public Task(int taskID, String ownerName) {
        this.taskID = taskID;
        this.ownerName = ownerName;
    }

    /**
     * @return Returns the ownerName.
     */
    public String getOwnerName() {
        return ownerName;
    }

    /**
     * @param ownerName
     *            The ownerName to set.
     */
    public void setOwnerName(String ownerName) {
        this.ownerName = ownerName;
    }

    /**
     * @return Returns the taskID.
     */
    public int getTaskID() {
        return taskID;
    }

    /**
     * @param taskID The taskID to set.
     */
    public void setTaskID(int taskID) {
        this.taskID = taskID;
    }
}
