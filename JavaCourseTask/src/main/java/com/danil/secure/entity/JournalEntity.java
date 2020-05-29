package com.danil.secure.entity;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "journal", schema = "autopark", catalog = "")
public class JournalEntity {
    private int id;
    private Timestamp timeOut;
    private Timestamp timeIn;
    private Integer autoId;
    private Integer routeId;

    @Id
    @Column(name = "id")
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    @Basic
    @Column(name = "time_out")
    public Timestamp getTimeOut() {
        return timeOut;
    }

    public void setTimeOut(Timestamp timeOut) {
        this.timeOut = timeOut;
    }

    @Basic
    @Column(name = "time_in")
    public Timestamp getTimeIn() {
        return timeIn;
    }

    public void setTimeIn(Timestamp timeIn) {
        this.timeIn = timeIn;
    }

    @Basic
    @Column(name = "auto_id")
    public Integer getAutoId() {
        return autoId;
    }

    public void setAutoId(Integer autoId) {
        this.autoId = autoId;
    }

    @Basic
    @Column(name = "route_id")
    public Integer getRouteId() {
        return routeId;
    }

    public void setRouteId(Integer routeId) {
        this.routeId = routeId;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        JournalEntity that = (JournalEntity) o;

        if (id != that.id) return false;
        if (timeOut != null ? !timeOut.equals(that.timeOut) : that.timeOut != null) return false;
        if (timeIn != null ? !timeIn.equals(that.timeIn) : that.timeIn != null) return false;
        if (autoId != null ? !autoId.equals(that.autoId) : that.autoId != null) return false;
        if (routeId != null ? !routeId.equals(that.routeId) : that.routeId != null) return false;

        return true;
    }

    @Override
    public int hashCode() {
        int result = id;
        result = 31 * result + (timeOut != null ? timeOut.hashCode() : 0);
        result = 31 * result + (timeIn != null ? timeIn.hashCode() : 0);
        result = 31 * result + (autoId != null ? autoId.hashCode() : 0);
        result = 31 * result + (routeId != null ? routeId.hashCode() : 0);
        return result;
    }
}
