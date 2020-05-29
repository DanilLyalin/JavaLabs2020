package com.danil.secure;

import com.danil.secure.entity.AutoPersonnelEntity;
import com.danil.secure.utils.HibernateUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.boot.Metadata;
import org.hibernate.boot.MetadataSources;
import org.hibernate.boot.registry.StandardServiceRegistryBuilder;
import org.hibernate.query.Query;
import org.hibernate.service.ServiceRegistry;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import java.util.List;

public class TestHibernate {


    public static void main(String [] args){
        String auto_id = "2";
        Session session = HibernateUtils.sessionFactory.getCurrentSession();
            session.getTransaction().begin();
            Query query = session.createQuery("DELETE FROM AutoEntity WHERE id = " + auto_id);
            System.out.println(auto_id);
            int rowCount = query.executeUpdate();
            System.out.println(rowCount);
            session.close();
    }



}
